package kr.co.wisenut.monitor.dao;

import java.util.List;

import kr.co.wisenut.monitor.model.Task;

public interface MonitorDao {
	public List<Task> getList() throws Exception;
}
