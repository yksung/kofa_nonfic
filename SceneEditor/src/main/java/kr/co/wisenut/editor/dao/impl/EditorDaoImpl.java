package kr.co.wisenut.editor.dao.impl;

import java.util.List;

import kr.co.wisenut.editor.dao.EditorDao;
import kr.co.wisenut.db.*;
import kr.co.wisenut.editor.model.Country;
import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Period;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;
import kr.co.wisenut.editor.model.VideoCategory;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mysql.cj.core.util.StringUtils;


@Repository("SceneMapper")
public class EditorDaoImpl implements EditorDao {
	
	private static final Logger logger = LoggerFactory.getLogger(EditorDaoImpl.class);
	
	private final SessionService sessionService = new SessionService();
	
	@Override
	public List<Video> getVideoList(FormVO paging) throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Video> videoList = session.selectList("VideoMapper.getVideoList", paging);
		
		return videoList;
	}

	@Override
	public List<Scene> getSceneList(String id) throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Scene> sceneList = session.selectList("SceneMapper.getSceneList", id);
		
		return sceneList;
	}
	
	@Override
	public List<Period> getPeriodList() throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Period> periodList = session.selectList("EntryMapper.periodList");
		
		return periodList;
	}
	
	@Override
	public List<Country> getCountryList(String domAbr) throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Country> countryList = null;
		if(StringUtils.isNullOrEmpty(domAbr)){
			countryList = session.selectList("EntryMapper.countryList");			
		}else{			
			countryList = session.selectList("EntryMapper.countryList", domAbr);
		}
		
		return countryList;
	}
	
	@Override
	public List<Event> getEventList(String upperClas) throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Event> eventCategoryList = null;
		if(StringUtils.isNullOrEmpty(upperClas)){
			eventCategoryList = session.selectList("EntryMapper.eventCategoryList");
		}else{
			eventCategoryList = session.selectList("EntryMapper.eventCategoryList", upperClas);			
		}
		
		return eventCategoryList;
	}
	
	@Override
	public List<VideoCategory> getVideoCategoryList() throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<VideoCategory> videoCategoryList = session.selectList("EntryMapper.videoCategoryList");
		
		return videoCategoryList;
	}
	
	@Override
	public Scene getScene(String id) throws Exception {
		SqlSession session = sessionService.getSession();
		Scene theScene = (Scene)session.selectOne("SceneMapper.findScene", id);
		
		logger.debug("@@@@@@ theScene.getVdoId() : " + theScene.getVdoId());
	
		return theScene;
	}
	
	public void printString(String str){
		System.out.println(str);
	}
	
	@Override
	public void updateScene(FormVO vo) throws Exception {
		SqlSession session = sessionService.getSession();
		int resultCount = session.update("SceneMapper.updateScene", vo);
		
		logger.debug("@@@@@@ resultCount : " + resultCount);
	}
}
