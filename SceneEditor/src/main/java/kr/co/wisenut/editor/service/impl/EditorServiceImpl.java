package kr.co.wisenut.editor.service.impl;

import kr.co.wisenut.editor.model.FormVO;
import kr.co.wisenut.editor.model.Scene;
import kr.co.wisenut.editor.service.EditorService;
import kr.co.wisenut.editor.dao.EditorDao;

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
}
