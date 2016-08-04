package kr.co.wisenut.editor.dao.impl;

import java.util.List;

import kr.co.wisenut.editor.dao.EditorDao;
import kr.co.wisenut.db.*;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;


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
	public Scene getScene(String id) throws Exception {
		SqlSession session = sessionService.getSession();
		Scene theScene = (Scene)session.selectOne("SceneMapper.findScene", id);
		
		logger.debug("@@@@@@ theScene.getVdoId() : " + theScene.getVdoId());
	
		return theScene;
	}
	
	public void printString(String str){
		System.out.println(str);
	}
}
