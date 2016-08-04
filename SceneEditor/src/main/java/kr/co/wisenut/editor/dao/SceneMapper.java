package kr.co.wisenut.editor.dao;

import java.util.List;

import kr.co.wisenut.editor.model.Scene;

public interface SceneMapper {
	public List<Scene> getList();
	public Scene getScene(String id);
}
