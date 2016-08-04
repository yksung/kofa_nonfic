package kr.co.wisenut.scene.dao.impl;

import java.util.List;

import kr.co.wisenut.scene.dao.SceneDao;
import kr.co.wisenut.scene.model.Scene;
import kr.co.wisenut.db.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


@Repository("SceneDao")
public class SceneDaoImpl implements SceneDao {
	
	private final SessionService sessionService = new SessionService();
	
	public List<Scene> getList() throws Exception{
		
		SqlSession session = sessionService.getSession();
	
		List<Scene> sceneList = session.selectList("SceneMapper.getSceneList");
		
		return sceneList;
	}
	
	public void printString(String str){
		System.out.println(str);
	}
}
