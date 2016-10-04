package kr.co.wisenut.manager.dao;

import java.util.List;

import kr.co.wisenut.editor.model.Event;

public interface ManagerDao {
	public List<Event> getEventList() throws Exception;
	public int addEvent(Event event) throws Exception;
}
