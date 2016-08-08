package kr.co.wisenut.editor.service.impl;

import java.util.List;

import kr.co.wisenut.editor.model.FormVO;
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
	
}
