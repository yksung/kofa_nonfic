package kr.co.wisenut.login.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.wisenut.login.model.User;
import kr.co.wisenut.login.service.LoginService;
import kr.co.wisenut.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/login")
public class LoginController {
		
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ModelAndView displayLogin(HttpSession session, ModelAndView mav){
		
		if(session.getAttribute("loginInfo")!=null){
			mav.setViewName("editor/viewVideo");
		}else{
			mav.setViewName("login/login");			
		}
			
		return mav;
	}
	
	@RequestMapping(value = "/loginOk", method = RequestMethod.POST)
	public void executeLogin(@ModelAttribute User loginInfo, HttpSession session, HttpServletResponse response){
		boolean isValidUser = false;
		try{
			isValidUser = loginService.isValidUser(loginInfo);
			if(isValidUser){
				session.setAttribute("loginInfo", loginInfo);
			}
			response.getWriter().print(isValidUser);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session){
		session.setAttribute("loginInfo", null);
		return "redirect:/login/page";
	}
}


