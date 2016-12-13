package kr.co.wisenut.manager.service;

import java.util.List;

import kr.co.wisenut.editor.model.Event;

public interface ManagerService {
	public List<Event> getEventList() throws Exception;
	public int addEvent(Event event) throws Exception;
	public int editEvent(Event event) throws Exception;
	public int deleteEvent(Event event) throws Exception;
}
