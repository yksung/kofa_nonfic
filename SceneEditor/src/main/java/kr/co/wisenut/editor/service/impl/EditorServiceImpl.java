package kr.co.wisenut.editor.service.impl;

import java.util.List;

import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.model.Video;
import kr.co.wisenut.editor.service.EditorService;
import kr.co.wisenut.editor.dao.EditorDao;
import kr.co.wisenut.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class EditorServiceImpl implements EditorService {

	private static final Logger logger = LoggerFactory.getLogger(EditorServiceImpl.class);
	
	private static final String QUOTE = "\"";
	
	@Autowired
	private EditorDao sceneDao;
	
	@Override
	public int saveSceneInfo(FormVO vo) throws Exception {
		int resultCnt = 0;
		
		Scene scene = sceneDao.findScene(vo);
		if(scene != null){			
			resultCnt = sceneDao.updateScene(vo);
		}else{
			resultCnt = sceneDao.insertScene(vo);
		}
		
		return resultCnt;
	}
	
	@Override
	public int deleteSceneInfo(FormVO vo) throws Exception {
		int resultCnt = sceneDao.deleteScene(vo);
		
		return resultCnt;
	}
	
	@Override
	public String getVideoListAsJson(FormVO vo) throws Exception {
		List<Video> videoList = null;
		ObjectMapper mapper = new ObjectMapper();
		
		StringBuffer jsonString = new StringBuffer();
		try{
			vo.setPage(vo.getOffset());
			vo.setPageSize(vo.getOffset()+vo.getLimit());
			videoList = sceneDao.getVideoList(vo);

			jsonString.append("{");
			jsonString.append(QUOTE+"status"+QUOTE).append(":").append(QUOTE+"success"+QUOTE);
			jsonString.append(",");
			jsonString.append(QUOTE+"total"+QUOTE).append(":").append(sceneDao.getVideoTotalCount(vo));
			jsonString.append(",");
			jsonString.append(QUOTE+"records"+QUOTE).append(":").append(mapper.writeValueAsString(videoList));
			jsonString.append("}");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		return jsonString.toString();
	}
	
	@Override
	public String getVideoFilePath(FormVO vo) throws Exception {
		String filePath = "";
		
		try{
			filePath = sceneDao.findVideoFilePath(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		return filePath;
	}
	
	@Override
	public int scenePersonMapping(FormVO vo) throws Exception {
		int successfullyMappedCount = 0;
		
		try{
			successfullyMappedCount = sceneDao.scenePersonMapping(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		return successfullyMappedCount;
	}
	
	@Override
	public int deletePersonFromMapping(FormVO vo) throws Exception {
		int successfullyDeleteCount = 0;
		
		try{
			successfullyDeleteCount = sceneDao.deletePersonFromMapping(vo);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		return successfullyDeleteCount;
	}
}
