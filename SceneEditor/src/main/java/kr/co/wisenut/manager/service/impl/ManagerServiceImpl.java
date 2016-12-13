package kr.co.wisenut.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.manager.dao.ManagerDao;
import kr.co.wisenut.manager.service.ManagerService;

@Service
public class ManagerServiceImpl implements ManagerService {
	
	@Autowired
	ManagerDao managerDao;
	
	@Override
	public List<Event> getEventList() throws Exception{
		return managerDao.getEventList();
	}
	
	@Override
	public int addEvent(Event event) throws Exception{
		int result = managerDao.addEvent(event);
		
		return result;
	}
	
	@Override
	public int editEvent(Event event) throws Exception{
		int result = managerDao.editEvent(event);
		return result;
	}
	
	@Override
	public int deleteEvent(Event event) throws Exception{
		int result = managerDao.deleteEvent(event);
		return result;
	}
}
