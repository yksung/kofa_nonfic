package kr.co.wisenut.db;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class SessionService {
	SqlSessionFactory sqlSessionFactory = SqlSessionFactoryManager.getSqlMapper(); 

	private SqlSession session = null;


	public SqlSession getSession(){
		return getSession(false);
	}
	
	public SqlSession getSession(boolean isBatch){
		open(isBatch);
		return session;
	}
	
	private void open(boolean isBatch) {
		try {
			if(isBatch){
				session = sqlSessionFactory.openSession(ExecutorType.BATCH, false);
			}else{
				session = sqlSessionFactory.openSession();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void close() {
		close(false);
	}
	
	public void close(boolean isBatch) {
		try {
			if(isBatch){
				session.commit();
			}
			session.close();
		} catch (Exception e) {

		}

	}
	
	public void commit(boolean isBatch){
		try {
			if(isBatch){
				session.commit();
			}
		} catch (Exception e) {

		}
	}
}
