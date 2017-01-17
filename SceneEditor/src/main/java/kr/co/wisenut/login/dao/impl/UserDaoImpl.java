package kr.co.wisenut.login.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import kr.co.wisenut.db.DB_ENV;
import kr.co.wisenut.db.SessionService;
import kr.co.wisenut.editor.dao.impl.EditorDaoImpl;
import kr.co.wisenut.login.dao.UserDao;
import kr.co.wisenut.login.model.User;
import kr.co.wisenut.util.StringUtil;

@Repository("LoginMapper")
public class UserDaoImpl implements UserDao {

private static final Logger logger = LoggerFactory.getLogger(EditorDaoImpl.class);
	
	private final SessionService sessionService = new SessionService(DB_ENV.PROD0);
	
	@Override
	public boolean isValidUser(User loginInfo){
		
		SqlSession session = sessionService.getSession();
		boolean ret = false;
		try{
			session = sessionService.getSession();
			if(session.selectOne("LoginMapper.getUserInfo", loginInfo) != null){
				ret = true;
			}
		}catch(Exception e){
			logger.error(StringUtil.getStackTrace(e));
		}finally{
			session.close();
		}
		
		return ret;
	}
}
