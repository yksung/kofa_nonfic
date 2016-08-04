package kr.co.wisenut.scene.controller;

import java.util.List;

import kr.co.wisenut.scene.model.Scene;
import kr.co.wisenut.scene.service.SceneService;

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
public class SceneController {
	
	private static final Logger logger = LoggerFactory.getLogger(SceneController.class);
	@Autowired
    private SceneService sceneService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/viewScene", method = RequestMethod.GET)
	public ModelAndView getListOfScenes(ModelAndView mav) {
		mav.setViewName("scene/viewScene");
		
		logger.info("View the List of Registered Scene!!");
				
		//Collection<Map<String,Object>> resultCollection = monitorService.getList();
		List<Scene> sceneList = sceneService.getList();
		
		mav.addObject("sceneList", sceneList );
		
		return mav;
	}
	
}
