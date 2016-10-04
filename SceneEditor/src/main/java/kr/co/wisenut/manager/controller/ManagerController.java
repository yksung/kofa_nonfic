package kr.co.wisenut.manager.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.manager.service.ManagerService;
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
@RequestMapping("/manager")
public class ManagerController {
	private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	private static final String QUOTE = "\"";
	
	@Autowired
	ManagerService managerService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String manageHome(HttpServletRequest request) {
		return "redirect:/manager/editEvent";
	}
	
	@RequestMapping(value = "/editEvent", method = RequestMethod.GET)
	public ModelAndView editEvent(@ModelAttribute FormVO vo, ModelAndView mav) {
		mav.setViewName("manager/editEvent");
		
		List<Event> eventList = null;
		try {
			eventList = managerService.getEventList();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mav.addObject("eventList", eventList);
				
		return mav;
	}
	
	@RequestMapping(value = "/addEvent", method = RequestMethod.POST)
	public ModelAndView addEvent(@ModelAttribute Event event, ModelAndView mav) {
		mav.setViewName("manager/addEvent");
		
		int successfullyAddCount = 0;
		try {
			successfullyAddCount = managerService.addEvent(event);
		} catch (IOException e) {
			logger.error(StringUtil.getStackTrace(e));
		} catch (Exception e) {
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("addCount", successfullyAddCount);
		
		return mav;
	}
}
