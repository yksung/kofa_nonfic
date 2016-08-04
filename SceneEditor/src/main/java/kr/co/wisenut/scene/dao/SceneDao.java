package kr.co.wisenut.scene.dao;

import java.util.List;

import kr.co.wisenut.scene.model.Scene;

public interface SceneDao {
	public List<Scene> getList() throws Exception;
}
