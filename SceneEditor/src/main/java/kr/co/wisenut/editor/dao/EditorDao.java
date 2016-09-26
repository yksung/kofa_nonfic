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
	public List<Video> getVideoList(FormVO vo) throws Exception;
	public List<Scene> getSceneList(int id) throws Exception;
	public List<Country> getCountryList(FormVO vo) throws Exception;
	public List<Country> getCountryList(String domAbr) throws Exception;
	public List<Event> getEventList(FormVO vo) throws Exception;
	public List<Period> getPeriodList() throws Exception;
	public List<VideoCategory> getVideoCategoryList() throws Exception;
	public Scene findScene(FormVO vo) throws Exception;
	public Video findVideo(String id) throws Exception;
	public int updateScene(FormVO vo) throws Exception;
	public int insertScene(FormVO vo) throws Exception;
	public int deleteScene(FormVO vo) throws Exception;
}
