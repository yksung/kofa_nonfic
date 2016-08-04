package kr.co.wisenut.monitor.dao.impl;

import java.util.List;

import kr.co.wisenut.monitor.dao.MonitorDao;
import kr.co.wisenut.monitor.model.Task;
import kr.co.wisenut.db.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;


@Repository("MonitorDao")
public class MonitorDaoImpl implements MonitorDao {
	
	private final SessionService sessionService = new SessionService();
	
	public List<Task> getList() throws Exception{
		
		SqlSession session = sessionService.getSession(true);
	
		List<Task> taksList = session.selectList("MonitorMapper.getTaskList");
		
		return taksList;
	}
	
	public void printString(String str){
		System.out.println(str);
	}
}
