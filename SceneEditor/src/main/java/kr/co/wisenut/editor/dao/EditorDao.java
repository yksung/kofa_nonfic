package kr.co.wisenut.editor.dao;

import java.util.List;

import kr.co.wisenut.editor.model.Country;
import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Period;
import kr.co.wisenut.editor.model.ScenePersonMapping;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;
import kr.co.wisenut.editor.model.VideoCategory;

public interface EditorDao {
	public List<Video> getVideoList(FormVO vo);
	public List<Scene> getSceneList(FormVO vo);
	public List<Country> getCountryList(FormVO vo);
	public List<Country> getCountryList(String domAbr);
	public List<Event> getEventList(FormVO vo);
	public List<ScenePersonMapping> getPersonList(String celebrityNm);
	public List<Period> getPeriodList();
	public List<VideoCategory> getVideoCategoryList();
	public Scene findScene(FormVO vo);
	public Video findVideo(String id);
	public int updateScene(FormVO vo);
	public int insertScene(FormVO vo);
	public int deleteScene(FormVO vo);
	public String findVideoFilePath(FormVO vo);
	public int scenePersonMapping(FormVO vo);
	public int deletePersonFromMapping(FormVO vo);
	public List<ScenePersonMapping> getScenePersonMapping(FormVO vo);
	public int getVideoTotalCount(FormVO vo);
	public int getNewScnId();
	public int getMaxRuntime();
}
