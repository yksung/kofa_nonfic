package kr.co.wisenut.scene.service.impl;

import java.util.List;

import kr.co.wisenut.scene.dao.SceneDao;
import kr.co.wisenut.scene.model.Scene;
import kr.co.wisenut.scene.service.SceneService;
import kr.co.wisenut.util.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SceneServiceImpl implements SceneService {

	private static final Logger logger = LoggerFactory.getLogger(SceneServiceImpl.class);
	
	@Autowired
	private SceneDao sceneDao;
	
	@Override
	public List<Scene> getList(){
		
		List<Scene> result = null;
		
		try{
			result = sceneDao.getList();
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
}
