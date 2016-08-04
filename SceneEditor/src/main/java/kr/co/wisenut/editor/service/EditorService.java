package kr.co.wisenut.editor.service;

import java.util.List;

import kr.co.wisenut.editor.model.Scene;


public interface EditorService  {
	public List<Scene> getList(String vdoId);
	public Scene getScene(String id);
}
