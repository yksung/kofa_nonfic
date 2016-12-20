package kr.co.wisenut.editor.dao.impl;

import java.util.List;

import kr.co.wisenut.editor.dao.EditorDao;
import kr.co.wisenut.db.*;
import kr.co.wisenut.editor.model.Country;
import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Period;
import kr.co.wisenut.editor.model.ScenePersonMapping;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;
import kr.co.wisenut.editor.model.VideoCategory;
import kr.co.wisenut.util.StringUtil;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mysql.cj.core.util.StringUtils;


@Repository("SceneMapper")
public class EditorDaoImpl implements EditorDao {
	
	private static final Logger logger = LoggerFactory.getLogger(EditorDaoImpl.class);
	
	private final SessionService sessionService = new SessionService(DB_ENV.PROD0);
	
	@Override
	public List<Video> getVideoList(FormVO vo){
		SqlSession session = null;
		List<Video> videoList = null;
		
		try{
			session = sessionService.getSession();
			videoList = session.selectList("VideoMapper.getVideoList", vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return videoList;
	}
	
	@Override
	public List<Scene> getSceneList(FormVO vo){
		SqlSession session = null;
		List<Scene> sceneList = null;
		
		try{
			session = sessionService.getSession();
			sceneList = session.selectList("SceneMapper.getSceneList", vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return sceneList;
	}
	
	@Override
	public List<Period> getPeriodList(){
		SqlSession session = null;
		List<Period> periodList = null;
		
		try{
			session = sessionService.getSession();
			periodList = session.selectList("EntryMapper.periodList");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return periodList;
	}
	
	@Override
	public List<Country> getCountryList(String domAbr){
		SqlSession session = null;
		List<Country> countryList = null;
		
		try{
			session = sessionService.getSession();
			
			logger.debug("[getCountryList] domAbr : " + domAbr);
			
			if(null != domAbr && !"".equals(domAbr)){
				countryList = session.selectList("EntryMapper.countryList", domAbr);
			}else{			
				countryList = session.selectList("EntryMapper.countryList");			
			}
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return countryList;
	}
	
	@Override
	public List<Country> getCountryList(FormVO vo){
		SqlSession session = null;
		List<Country> countryList = null;
		
		try{
			session = sessionService.getSession();
			if(vo.getDomAbr()==null || StringUtils.isNullOrEmpty(vo.getDomAbr())){
				countryList = session.selectList("EntryMapper.countryList");			
			}else{			
				countryList = session.selectList("EntryMapper.countryList", vo.getDomAbr());
			}
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return countryList;
	}
	
	@Override
	public List<Event> getEventList(FormVO vo){
		SqlSession session = null;
		List<Event> eventCategoryList = null;
		
		try{
			session = sessionService.getSession();
			eventCategoryList = session.selectList("EntryMapper.eventCategoryList", vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return eventCategoryList;
	}
	
	@Override
	public List<ScenePersonMapping> getPersonList(String celebrityNm){
		SqlSession session = null;
		List<ScenePersonMapping> personList = null;
		try{
			session = sessionService.getSession();
			if(StringUtils.isNullOrEmpty(celebrityNm)){
				personList = session.selectList("EntryMapper.personList");			
			}else{			
				personList = session.selectList("EntryMapper.personList", celebrityNm);
			}
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return personList;
	}
	
	@Override
	public List<VideoCategory> getVideoCategoryList(){
		SqlSession session = null;
		List<VideoCategory> videoCategoryList = null;
		try{
			session = sessionService.getSession();
			videoCategoryList = session.selectList("EntryMapper.videoCategoryList");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return videoCategoryList;
	}
	
	@Override
	public Scene findScene(FormVO vo) {
		SqlSession session = null;
		Scene theScene = null;
			
		try{
			session = sessionService.getSession();
			theScene = (Scene)session.selectOne("SceneMapper.findScene", vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
		
		return theScene;
	}
	
	@Override
	public Video findVideo(String id) {
		SqlSession session = null;
		Video theVideo = null;;
		
		try{
			session = sessionService.getSession();
			theVideo = (Video)session.selectOne("VideoMapper.findVideo", id);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{			
			session.close();
		}
	
		return theVideo;
	}
	
	public void printString(String str){
		System.out.println(str);
	}
	
	@Override
	public int updateScene(FormVO vo){
		SqlSession session = null;
		int resultCount = 0;
		
		try{
			session = sessionService.getSession();
			resultCount = session.update("SceneMapper.updateScene", vo);
			
			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}
		
		logger.info("Update count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public int insertScene(FormVO vo){
		SqlSession session = null;
		int resultCount = 0;
		try{
			session = sessionService.getSession();
			resultCount = session.insert("SceneMapper.insertScene", vo);
			
			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}

		logger.info("Insert count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public int deleteScene(FormVO vo){
		SqlSession session = null;
		int resultCount = 0;
		try{
			session = sessionService.getSession();
			resultCount = session.delete("SceneMapper.deleteScene", vo);		

			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}
		
		logger.info("Delete count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public String findVideoFilePath(FormVO vo) {
		SqlSession session = sessionService.getSession();
		String filePath = null;
		
		try{
			session = sessionService.getSession();
			filePath = (String)session.selectOne("VideoMapper.findVideoFile", vo);		
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{
			session.close();
		}
		
		return filePath;
	}
	
	@Override
	public int scenePersonMapping(FormVO vo) {
		SqlSession session = null;
		int resultCount = 0;
		
		try{
			session = sessionService.getSession();
			resultCount = session.insert("EntryMapper.scenePersonMapping", vo);			
			
			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}
		
		logger.info("Insert count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public int deletePersonFromMapping(FormVO vo) {
		SqlSession session = null;
		int resultCount = 0;
		
		try{
			session = sessionService.getSession();
			if(vo.getPersonKorNm() != null){				
				resultCount = session.delete("EntryMapper.deletePersonFromMapping", vo);			
			}else{ // 장면이 삭제되면 scene_person_mapping 의 특정 장면 관련 정보를 모두 삭제.
				resultCount = session.delete("EntryMapper.deleteMapping", vo);
			}
			
			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}

		logger.info("Delete count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public List<ScenePersonMapping> getScenePersonMapping(FormVO vo) {
		SqlSession session = null;		
		List<ScenePersonMapping> personList = null;
		
		try{
			session = sessionService.getSession();
			personList = session.selectList("EntryMapper.getScenePersonMapping", vo);			
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{
			session.close();
		}
		
		return personList;
	}
	
	@Override
	public int getVideoTotalCount(FormVO vo) {
		SqlSession session = null;
		int totalCount = 0;
		
		try{
			session = sessionService.getSession();
			totalCount = (Integer)session.selectOne("VideoMapper.getVideoTotalCount", vo);			
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{
			session.close();
		}
		
		return totalCount;
	}
	
	@Override
	public int getNewScnId() {
		SqlSession session = null;
		int scnId = 0;
		
		try{
			session = sessionService.getSession();
			scnId = (Integer)session.selectOne("SceneMapper.getNewScnId");			
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{
			session.close();
		}
		
		return scnId;
	}
	
	@Override
	public int getMaxRuntime() {
		SqlSession session = null;
		int maxRuntime = 0;
		
		try{
			session = sessionService.getSession();
			maxRuntime = (Integer)session.selectOne("VideoMapper.getMaxRuntime");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{
			session.close();
		}
		
		return maxRuntime;
	}
}
