package kr.co.wisenut.editor.dao;

import java.util.List;

import kr.co.wisenut.editor.model.Country;
import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Period;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;
import kr.co.wisenut.editor.model.VideoCategory;

public interface EditorDao {
	public List<Video> getVideoList(FormVO paging) throws Exception;
	public List<Scene> getSceneList(String id) throws Exception;
	public List<Country> getCountryList(String domAbr) throws Exception;
	public List<Event> getEventList(String upperClas) throws Exception;
	public List<Period> getPeriodList() throws Exception;
	public List<VideoCategory> getVideoCategoryList() throws Exception;
	public Scene getScene(String id) throws Exception;
	public void updateScene(FormVO vo) throws Exception;
}
