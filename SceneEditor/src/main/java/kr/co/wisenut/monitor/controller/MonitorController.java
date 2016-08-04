package kr.co.wisenut.monitor.controller;

import java.util.List;

import kr.co.wisenut.monitor.model.Task;
import kr.co.wisenut.monitor.service.MonitorService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MonitorController {
	
	private static final Logger logger = LoggerFactory.getLogger(MonitorController.class);
	@Autowired
    private MonitorService monitorService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/monitor", method = RequestMethod.GET)
	public ModelAndView show(ModelAndView mav) {
		mav.setViewName("monitor/monitor");
		
		logger.info("Referee Detector's Monitoring page!");
				
		//Collection<Map<String,Object>> resultCollection = monitorService.getList();
		List<Task> taskList = monitorService.getList();
		
		mav.addObject("taskList", taskList );
		
		return mav;
	}
	
}
