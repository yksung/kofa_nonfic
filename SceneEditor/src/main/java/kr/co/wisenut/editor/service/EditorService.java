package kr.co.wisenut.editor.service;

import kr.co.wisenut.editor.model.FormVO;


public interface EditorService  {
	public int getMaxRuntime() throws Exception;
	public int saveSceneInfo(FormVO vo) throws Exception;
	public int deleteSceneInfo(FormVO vo) throws Exception;
	public int getNewScnId() throws Exception;
	public String getVideoListAsJson(FormVO vo) throws Exception;
	public String getVideoFilePath(FormVO vo) throws Exception;
	public int scenePersonMapping(FormVO vo) throws Exception;
	public int deletePersonFromMapping(FormVO vo) throws Exception;
}
