package kr.co.wisenut.editor.dao;

import java.util.List;

import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;

public interface EditorDao {
	public List<Video> getVideoList(FormVO paging) throws Exception;
	public List<Scene> getSceneList(String id) throws Exception;
	public Scene getScene(String id) throws Exception;
}
