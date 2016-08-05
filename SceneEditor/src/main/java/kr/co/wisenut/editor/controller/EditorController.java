package kr.co.wisenut.editor.controller;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kr.co.wisenut.editor.model.Country;
import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Period;
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
	private static final String QUOTE = "\"";
	
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
		List<Country> countryList = null;
		List<Event> eventCategoryList = null;
		List<Period> periodList = null;
		try{
			scene = editorDao.getScene(scnId);
			countryList = editorDao.getCountryList(null);
			eventCategoryList = editorDao.getEventList(null);
			periodList = editorDao.getPeriodList();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("sceneInfo", scene );
		mav.addObject("periodList", periodList);
		mav.addObject("countryList", countryList);
		mav.addObject("eventCategoryList", eventCategoryList);
		
		return mav;
	}
	
	@RequestMapping(value = "/getEventAsJson", method = RequestMethod.GET)
	public void getEventAsJson(@RequestParam String upperClasCd, HttpServletResponse response) {
		
		List<Event> eventCategoryList = null;
		StringBuffer resultJson = new StringBuffer();
		try{
			eventCategoryList = editorDao.getEventList(upperClasCd);
			for(Event event : eventCategoryList){
				resultJson.append("{");
				resultJson.append(QUOTE + "clasCd" + QUOTE).append(":").append(QUOTE+event.getClasCd()+QUOTE);
				resultJson.append(",");
				resultJson.append(QUOTE + "clasNm" + QUOTE).append(":").append(QUOTE+event.getClasNm()+QUOTE);
				resultJson.append("}");
				resultJson.append(",");
			}
			
			if(resultJson.length()>0 && resultJson.indexOf(",") != -1){				
				response.getWriter().print("[" + resultJson.substring(0, resultJson.lastIndexOf(",")) + "]");
			}else{
				response.getWriter().print("{}");
			}
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}
	
	@RequestMapping(value = "/getCountryAsJson", method = RequestMethod.GET)
	public void getCountryAsJson(@RequestParam String domAbr, HttpServletResponse response) {
		
		List<Country> countryList = null;
		StringBuffer resultJson = new StringBuffer();
		try{
			countryList = editorDao.getCountryList(domAbr);
			for(Country cntry : countryList){
				resultJson.append("{");
				resultJson.append(QUOTE + "cntryCd" + QUOTE).append(":").append(QUOTE+cntry.getCntryCd()+QUOTE);
				resultJson.append(",");
				resultJson.append(QUOTE + "cntryNm" + QUOTE).append(":").append(QUOTE+cntry.getCntryNm()+QUOTE);
				resultJson.append("}");
				resultJson.append(",");
			}
			
			if(resultJson.length()>0 && resultJson.indexOf(",") != -1){				
				response.getWriter().print("[" + resultJson.substring(0, resultJson.lastIndexOf(",")) + "]");
			}else{
				response.getWriter().print("{}");
			}
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}
}
