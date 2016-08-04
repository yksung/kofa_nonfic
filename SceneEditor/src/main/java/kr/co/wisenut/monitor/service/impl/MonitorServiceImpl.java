package kr.co.wisenut.monitor.service.impl;

import java.util.List;

import kr.co.wisenut.monitor.dao.MonitorDao;
import kr.co.wisenut.monitor.model.Task;
import kr.co.wisenut.monitor.service.MonitorService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MonitorServiceImpl implements MonitorService {

	private static final Logger logger = LoggerFactory.getLogger(MonitorServiceImpl.class);
	
	@Autowired
	private MonitorDao monitorDao;
	
	@Override
	public List<Task> getList(){
		
		List<Task> result = null;
		
		try{
			result = monitorDao.getList();
			if(result==null){
				logger.debug("result is null.");
			}else if(result.size() == 0){
				logger.debug("result size is 0.");
			}else{
				logger.debug("result size : " + result.size());
			}
		}catch(Exception e){
			logger.error(e.getMessage());
		}
		return result;
	}
}
