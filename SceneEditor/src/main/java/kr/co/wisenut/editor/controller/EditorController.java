package kr.co.wisenut.editor.controller;

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

import com.fasterxml.jackson.databind.ObjectMapper;

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
			
		/*List<Video> videoList = null;
		try{			
			videoList = editorDao.getVideoList(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("videoList", videoList);*/
		
		return mav;
	}
	
	@RequestMapping(value = "/viewScene", method = RequestMethod.GET)
	public ModelAndView getListOfScenes(@RequestParam String vdoId, ModelAndView mav) {
		mav.setViewName("editor/viewScene");
		
		logger.info("View the List of Registered Scene!!");
		
		Video video = null;
		try{
			video = editorDao.findVideo(vdoId);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("videoInfo", video );
		
		return mav;
	}
	
	@RequestMapping(value = "/editScene", method = RequestMethod.GET)
	public ModelAndView editSceneInfo(@ModelAttribute FormVO vo, ModelAndView mav) {
		mav.setViewName("editor/editScene");
		
		logger.info("============ start to edit scene !!");
				
		Scene scene = null;
		List<Country> countryList = null;
		List<Period> periodList = null;
		List<Event> eventList = null;
		int prevExists = 0;
		int nextExists = 0;
		
		FormVO voForPrevScene = new FormVO();
		voForPrevScene.setDirection(-1);
		voForPrevScene.setVdoId(vo.getVdoId());
		voForPrevScene.setScnId(vo.getScnId());

		FormVO voForNextScene = new FormVO();
		voForNextScene.setDirection(1);
		voForNextScene.setVdoId(vo.getVdoId());
		voForNextScene.setScnId(vo.getScnId());
		
		try{
			scene = editorDao.findScene(vo);
			if(editorDao.findScene(voForPrevScene) != null){
				prevExists = 1;
			}
			if(editorDao.findScene(voForNextScene) != null){
				nextExists = 1;
			}
			countryList = editorDao.getCountryList(null);
			periodList = editorDao.getPeriodList();
			
			// 해당 장몀의 사건연대 값을 받아와 해당 연대의 사건만 가져온다. 개발할 때만 적용할 수도 있음. 
			vo.setEventPrd(scene.getEventPrd());
			eventList = editorDao.getEventList(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("prevExists", prevExists);
		mav.addObject("nextExists", nextExists);
		mav.addObject("sceneInfo", scene );
		mav.addObject("periodList", periodList);
		mav.addObject("countryList", countryList);
		mav.addObject("eventList", eventList);
		
		return mav;
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

	@RequestMapping(value = "/getVideoListAsJson", method = RequestMethod.POST)
	public void getVideoListAsJson(@ModelAttribute FormVO vo, HttpServletResponse response) {
		
		List<Video> videoList = null;
		ObjectMapper mapper = new ObjectMapper();

		String jsonString = "";
		try{
			videoList = editorDao.getVideoList(vo);
			jsonString = mapper.writeValueAsString(videoList);
			
			//response.getWriter().print(jsonString.replaceAll("\\{\"", "\\{").replaceAll("\":", ":").replaceAll(",\"", ","));
			response.getWriter().print("{"
					+QUOTE+"status"+QUOTE+":"+QUOTE+"success"+QUOTE+","
					+QUOTE+"total"+QUOTE+":"+videoList.size()+","
					+QUOTE+"records"+QUOTE+":"+jsonString
					+"}");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}
	
	@RequestMapping(value = "/getSceneListAsJson", method = RequestMethod.POST)
	public void getSceneListAsJson(@ModelAttribute FormVO vo, HttpServletResponse response) {
		
		List<Scene> sceneList = null;
		ObjectMapper mapper = new ObjectMapper();

		String jsonString = "";
		try{
			sceneList = editorDao.getSceneList(vo.getVdoId());
			jsonString = mapper.writeValueAsString(sceneList);
			
			//response.getWriter().print(jsonString.replaceAll("\\{\"", "\\{").replaceAll("\":", ":").replaceAll(",\"", ","));
			response.getWriter().print("{"
					+QUOTE+"status"+QUOTE+":"+QUOTE+"success"+QUOTE+","
					+QUOTE+"total"+QUOTE+":"+sceneList.size()+","
					+QUOTE+"records"+QUOTE+":"+jsonString
					+"}");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}

	@RequestMapping(value = "/updateScene", method = RequestMethod.POST)
	public String update(@RequestParam FormVO vo, HttpServletResponse response) {
		try{
			editorDao.updateScene(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		return "redirect:/editScene?scnId="+vo.getScnId();
	}
}