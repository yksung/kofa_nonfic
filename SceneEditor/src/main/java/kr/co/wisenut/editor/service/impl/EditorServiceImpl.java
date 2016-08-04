package kr.co.wisenut.editor.service.impl;

import java.util.List;

import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.service.EditorService;
import kr.co.wisenut.editor.dao.EditorDao;
import kr.co.wisenut.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EditorServiceImpl implements EditorService {

	private static final Logger logger = LoggerFactory.getLogger(EditorServiceImpl.class);
	
	@Autowired
	private EditorDao sceneDao;
	
	@Override
	public List<Scene> getList(String vdoId){
		
		List<Scene> result = null;
		
		try{
			result = sceneDao.getSceneList(vdoId);
			if(result==null){
				logger.debug("result is null.");
			}else if(result.size() == 0){
				logger.debug("result size is 0.");
			}else{
				logger.debug("result size : " + result.size());
			}
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		return result;
	}
	
	@Override
	public Scene getScene(String id){
		Scene result = null;
		
		try{
			result = sceneDao.getScene(id);
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}
		
		return result;
	}
}
