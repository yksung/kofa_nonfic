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
import kr.co.wisenut.util.StringUtil;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.mysql.cj.core.util.StringUtils;


@Repository("SceneMapper")
public class EditorDaoImpl implements EditorDao {
	
	private static final Logger logger = LoggerFactory.getLogger(EditorDaoImpl.class);
	
	private final SessionService sessionService = new SessionService();
	
	@Override
	public List<Video> getVideoList(FormVO vo) throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Video> videoList = session.selectList("VideoMapper.getVideoList", vo);
		
		return videoList;
	}
	
	@Override
	public List<Video> goBackToVideoList(FormVO vo) throws Exception {
		SqlSession session = sessionService.getSession();
		
		List<Video> videoList = session.selectList("VideoMapper.goBackToVideoList", vo);
		
		return videoList;
	}

	@Override
	public List<Scene> getSceneList(int id) throws Exception{
		
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
	public List<Country> getCountryList(FormVO vo) throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Country> countryList = null;
		if(vo.getDomAbr()==null || StringUtils.isNullOrEmpty(vo.getDomAbr())){
			countryList = session.selectList("EntryMapper.countryList");			
		}else{			
			countryList = session.selectList("EntryMapper.countryList", vo.getDomAbr());
		}
		
		return countryList;
	}
	
	@Override
	public List<Event> getEventList(FormVO vo) throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Event> eventCategoryList = null;
		eventCategoryList = session.selectList("EntryMapper.eventCategoryList", vo);
		
		return eventCategoryList;
	}
	
	@Override
	public List<VideoCategory> getVideoCategoryList() throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<VideoCategory> videoCategoryList = session.selectList("EntryMapper.videoCategoryList");
		
		return videoCategoryList;
	}
	
	@Override
	public Scene findScene(FormVO vo) throws Exception {
		SqlSession session = sessionService.getSession();
		Scene theScene = (Scene)session.selectOne("SceneMapper.findScene", vo);
			
		return theScene;
	}
	
	@Override
	public Video findVideo(String id) throws Exception {
		SqlSession session = sessionService.getSession();
		Video theVideo = (Video)session.selectOne("VideoMapper.findVideo", id);
	
		return theVideo;
	}
	
	public void printString(String str){
		System.out.println(str);
	}
	
	@Override
	public int updateScene(FormVO vo){
		SqlSession session = sessionService.getSession();

		int resultCount = 0;
		try{
			resultCount = session.update("SceneMapper.updateScene", vo);			
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}
		
		session.commit(false);
		logger.info("Update count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public int insertScene(FormVO vo){
		SqlSession session = sessionService.getSession();

		int resultCount = 0;
		try{
			resultCount = session.insert("SceneMapper.insertScene", vo);			
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}
		
		session.commit(false);
		logger.info("Insert count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public int deleteScene(FormVO vo){
		SqlSession session = sessionService.getSession();

		int resultCount = 0;
		try{
			resultCount = session.delete("SceneMapper.deleteScene", vo);			
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}
		
		session.commit(false);
		logger.info("Delete count : " + resultCount);
		
		return resultCount;
	}
}
