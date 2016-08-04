package kr.co.wisenut.editor.controller;

import java.util.List;

import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;
//import kr.co.wisenut.editor.service.EditorService;
import kr.co.wisenut.util.StringUtil;
import kr.co.wisenut.editor.dao.EditorDao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class EditorController {
	
	private static final Logger logger = LoggerFactory.getLogger(EditorController.class);
	@Autowired
    //private EditorService sceneService;
	private EditorDao editorDao;
	
	@RequestMapping(value = "/viewVideo", method = RequestMethod.GET)
	public ModelAndView getListOfVideos(@ModelAttribute FormVO vo, ModelAndView mav) {
		mav.setViewName("editor/viewVideo");
		
		logger.info("View the List of Registered Video!!");
			
		List<Video> videoList = null;
		try{			
			videoList = editorDao.getVideoList(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("videoList", videoList);
		
		return mav;
	}
	
	@RequestMapping(value = "/viewScene", method = RequestMethod.GET)
	public ModelAndView getListOfScenes(@RequestParam String vdoId, ModelAndView mav) {
		mav.setViewName("editor/viewScene");
		
		logger.info("View the List of Registered Scene!!");
				
		//List<Scene> sceneList = sceneService.getList(vdoId);
		List<Scene> sceneList = null;
		try{
			sceneList = editorDao.getSceneList(vdoId);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("vdoId", vdoId);
		mav.addObject("sceneList", sceneList );
		
		return mav;
	}
	
	@RequestMapping(value = "/editScene", method = RequestMethod.GET)
	public ModelAndView editSceneInfo(@RequestParam String scnId, ModelAndView mav) {
		mav.setViewName("editor/editScene");
		
		logger.info("============ start to edit scene !!");
				
		Scene scene = null;//sceneService.getScene(scnId);
		try{
			scene = editorDao.getScene(scnId);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("sceneInfo", scene );
		
		return mav;
	}
	
}
