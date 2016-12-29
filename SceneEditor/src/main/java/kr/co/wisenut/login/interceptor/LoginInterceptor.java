package kr.co.wisenut.login.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.wisenut.login.model.User;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		
		HttpSession session = request.getSession();
		User loginInfo = (User) session.getAttribute("loginInfo");
		
		if( loginInfo == null){
			response.sendRedirect("/login/page");
			return false;
		}else{
			return super.preHandle(request, response, handler);
		}
		
	}
}
