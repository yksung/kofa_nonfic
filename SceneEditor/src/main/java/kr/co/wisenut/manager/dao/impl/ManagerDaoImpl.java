package kr.co.wisenut.manager.dao.impl;

import java.util.List;

import kr.co.wisenut.db.DB_ENV;
import kr.co.wisenut.db.SessionService;
import kr.co.wisenut.editor.dao.impl.EditorDaoImpl;
import kr.co.wisenut.editor.model.Event;
import kr.co.wisenut.manager.dao.ManagerDao;
import kr.co.wisenut.util.StringUtil;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository("EntryMapper")
public class ManagerDaoImpl implements ManagerDao {
	
	private static final Logger logger = LoggerFactory.getLogger(EditorDaoImpl.class);
	
	private final SessionService sessionService = new SessionService(DB_ENV.PROD0);
	
	@Override
	public List<Event> getEventList(){
		SqlSession session = null;
		List<Event> eventCategoryList = null;
		
		try{
			session = sessionService.getSession();
			eventCategoryList = session.selectList("EntryMapper.eventCategoryList");
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{
			session.close();
		}
		
		return eventCategoryList;
	}
	
	@Override
	public int addEvent(Event event){
		SqlSession session = sessionService.getSession();
		int resultCount = 0;
		
		try{
			session = sessionService.getSession();
			resultCount = session.insert("EntryMapper.insertEvent", event);
			
			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}
		
		logger.info("Insert count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public int editEvent(Event event){
		SqlSession session = sessionService.getSession();
		int resultCount = 0;
		
		try{
			session = sessionService.getSession();
			resultCount = session.update("EntryMapper.updateEvent", event);
			
			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}

		logger.info("update count : " + resultCount);
		
		return resultCount;
	}
	
	@Override
	public int deleteEvent(Event event){
		SqlSession session = sessionService.getSession();
		int resultCount = 0;
		
		try{
			session = sessionService.getSession();
			resultCount = session.delete("EntryMapper.deleteEvent", event);
			
			session.commit();
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
			session.rollback();
		}finally{
			session.close();
		}
		
		logger.info("update count : " + resultCount);
		
		return resultCount;
	}
}
