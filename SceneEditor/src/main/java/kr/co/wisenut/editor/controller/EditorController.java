package kr.co.wisenut.editor.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.wisenut.editor.model.Country;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Period;
import kr.co.wisenut.editor.model.Person;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;
import kr.co.wisenut.editor.service.EditorService;
//import kr.co.wisenut.editor.service.EditorService;
import kr.co.wisenut.util.StringUtil;
import kr.co.wisenut.editor.dao.EditorDao;
import kr.co.wisenut.login.model.User;
import kr.co.wisenut.login.service.LoginService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/editor")
public class EditorController {
	
	private static final Logger logger = LoggerFactory.getLogger(EditorController.class);
	private static final String QUOTE = "\"";
	
	@Autowired
    private EditorService sceneService;
    
    @Autowired
    LoginService loginService;
	
	@Autowired
	private EditorDao editorDao;
	
	@RequestMapping(value = "/viewVideo")
	public ModelAndView viewVideo(@ModelAttribute FormVO vo, ModelAndView mav) {
		mav.setViewName("editor/viewVideo");
		
		logger.info("View the List of Registered Video!!");
		
		mav.addObject("vdoId", vo.getVdoId());
		mav.addObject("offset", vo.getOffset());
		mav.addObject("limit", vo.getLimit());
		
		return mav;
	}
	
	@RequestMapping(value = "/viewScene")
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
	
	@RequestMapping(value = "/editScene")
	public ModelAndView editSceneInfo(@ModelAttribute FormVO vo, HttpSession session, ModelAndView mav) {
		mav.setViewName("editor/editScene");
		
		logger.info("============ start to edit scene !!");
				
		Scene scene = new Scene();
		List<Country> countryList = null;
		List<Period> periodList = null;
		List<Person> personList = null;
		boolean isValidUser = false;
		//List<Event> eventList = null;
		int prevExists = 0;
		int nextExists = 0;
		FormVO voForPrevScene = new FormVO();
		FormVO voForNextScene = new FormVO();
		String vdoFilePath = "";
			
		try{
			if(vo.getScnId() != 0){
				scene = editorDao.findScene(vo);
				
				voForPrevScene.setDirection(-1);
				voForPrevScene.setVdoId(vo.getVdoId());
				voForPrevScene.setScnId(vo.getScnId());
				
				voForNextScene.setDirection(1);
				voForNextScene.setVdoId(vo.getVdoId());
				voForNextScene.setScnId(vo.getScnId());
				
				if(editorDao.findScene(voForPrevScene) != null){
					prevExists = 1;
				}
				
				if(editorDao.findScene(voForNextScene) != null){
					nextExists = 1;
				}
				// 해당 장몀의 사건연대 값을 받아와 해당 연대의 사건만 가져온다. 개발할 때만 적용할 수도 있음. 
				vo.setEventPrd(scene.getEventPrd());
				
				vdoFilePath = sceneService.getVideoFilePath(vo);
			}else{
				scene.setVdoId(vo.getVdoId());// 새 장면인 경우 기존에 장면정보 ID는 없지만 VIDEO_ID는 존재하므로 그 정보를 새 장면 입력화면에 넘겨준다.
				scene.setVdoNm(vo.getVdoNm());
			}
			
			countryList = editorDao.getCountryList(vo);
			periodList = editorDao.getPeriodList();
			personList = editorDao.getScenePersonMapping(vo);
			if(session.getAttribute("loginInfo")!=null){				
				User thisUser = (User)session.getAttribute("loginInfo");
				isValidUser = loginService.isValidUser(thisUser);
			}
			//eventList = editorDao.getEventList(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("prevExists", prevExists);
		mav.addObject("nextExists", nextExists);
		mav.addObject("sceneInfo", scene );
		mav.addObject("periodList", periodList);
		mav.addObject("countryList", countryList);
		mav.addObject("scenePersonMapping", personList);
		mav.addObject("vdoFilePath", (vdoFilePath!=null)? vdoFilePath.replaceAll("\\\\", "/"):"");
		mav.addObject("isValidUser", isValidUser);
		//mav.addObject("eventList", eventList);
		
		return mav;
	}
	
	@RequestMapping(value = "/saveScene")
	public ModelAndView saveSceneInfo(@ModelAttribute FormVO vo, ModelAndView mav) {
		mav.setViewName("editor/updateScene");
		
		int successfullySaveCount = 0;
		try {
			successfullySaveCount = sceneService.saveSceneInfo(vo);
		} catch (IOException e) {
			logger.error(StringUtil.getStackTrace(e));
		} catch (Exception e) {
			logger.error(StringUtil.getStackTrace(e));
		}
		
		mav.addObject("saveCount", successfullySaveCount);
		mav.addObject("sceneInfo", vo);
		
		return mav;
	}
	
	@RequestMapping(value = "/deleteScene")
	public void deleteSceneInfo(@RequestParam(value="vdoId") int vdoId,
								@RequestParam(value="scnId") int scnId,
								HttpServletResponse response) {
		
		int successfullyDeleteCount = 0;
		FormVO vo = new FormVO();
		
		vo.setVdoId(vdoId);
		vo.setScnId(scnId);
		
		try {
			successfullyDeleteCount = sceneService.deleteSceneInfo(vo);
			
			response.getWriter().print(successfullyDeleteCount);
		} catch (IOException e) {
			logger.error(StringUtil.getStackTrace(e));
		} catch (Exception e) {
			logger.error(StringUtil.getStackTrace(e));
		}
		
	}
		
	@RequestMapping(value = "/getCountryAsJson")
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

	@RequestMapping(value = "/getVideoListAsJson")
	public void getVideoListAsJson(@ModelAttribute FormVO vo, HttpServletResponse response) {
		try {
			response.getWriter().print(sceneService.getVideoListAsJson(vo));
		} catch (IOException e) {
			logger.error(StringUtil.getStackTrace(e));
		} catch (Exception e) {
			logger.error(StringUtil.getStackTrace(e));
		}	
	}
	
	@RequestMapping(value = "/getSceneListAsJson")
	public void getSceneListAsJson(@ModelAttribute FormVO vo, HttpServletResponse response) {
		
		List<Scene> sceneList = null;
		ObjectMapper mapper = new ObjectMapper();

		String jsonString = "";
		try{
			sceneList = editorDao.getSceneList(vo);
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
	
	@RequestMapping(value = "/getCelebrityListAsJson")
	public void getCelebrityAsJson(@RequestParam String celebrityNm, HttpServletResponse response) {
		
		List<Person> personList = null;
		ObjectMapper mapper = new ObjectMapper();

		String jsonString = "";
		
		System.out.println("### celebrityNm : " + celebrityNm);
	
		try{
			personList = editorDao.getPersonList(celebrityNm);
			jsonString = mapper.writeValueAsString(personList);
			
			//response.getWriter().print(jsonString.replaceAll("\\{\"", "\\{").replaceAll("\":", ":").replaceAll(",\"", ","));
			response.getWriter().print("{"
					+QUOTE+"status"+QUOTE+":"+QUOTE+"success"+QUOTE+","
					+QUOTE+"total"+QUOTE+":"+personList.size()+","
					+QUOTE+"records"+QUOTE+":"+jsonString
					+"}");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}
	
	@RequestMapping(value = "/mapSceneAndPerson")
	public void mapSceneAndPerson(@ModelAttribute FormVO vo, HttpServletResponse response) {
		
		int successfullyMappedCount = 0;
		try{
			successfullyMappedCount = sceneService.scenePersonMapping(vo);
			
			//response.getWriter().print(jsonString.replaceAll("\\{\"", "\\{").replaceAll("\":", ":").replaceAll(",\"", ","));
			response.getWriter().print("{"
					+QUOTE+"status"+QUOTE+":"+QUOTE+"success"+QUOTE+","
					+QUOTE+"total"+QUOTE+":"+successfullyMappedCount
					+"}");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}
	
	@RequestMapping(value = "/deletePersonFromMapping")
	public void deletePersonFromMapping(@ModelAttribute FormVO vo, HttpServletResponse response) {
		
		int successfullyDeleteCount = 0;
		try{
			successfullyDeleteCount = sceneService.deletePersonFromMapping(vo);
			
			response.getWriter().print("{"
					+QUOTE+"status"+QUOTE+":"+QUOTE+"success"+QUOTE+","
					+QUOTE+"total"+QUOTE+":"+successfullyDeleteCount
					+"}");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
	}
}
