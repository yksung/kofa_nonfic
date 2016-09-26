package kr.co.wisenut.login.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.wisenut.db.SessionService;
import kr.co.wisenut.editor.dao.impl.EditorDaoImpl;
import kr.co.wisenut.login.dao.UserDao;
import kr.co.wisenut.login.model.User;

@Repository("LoginMapper")
public class UserDaoImpl implements UserDao {

private static final Logger logger = LoggerFactory.getLogger(EditorDaoImpl.class);
	
	private final SessionService sessionService = new SessionService();
	
	@Override
	public boolean isValidUser(User loginInfo) throws Exception{
		
		SqlSession session = sessionService.getSession();
		
		if(session.selectOne("LoginMapper.getUserInfo", loginInfo) != null){
			logger.info(loginInfo.getUserName() + " exists.");
			return true;
		}
		
		return false;
	}
}
