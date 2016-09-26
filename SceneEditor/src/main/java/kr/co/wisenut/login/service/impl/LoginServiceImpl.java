package kr.co.wisenut.login.service.impl;

import kr.co.wisenut.login.dao.UserDao;
import kr.co.wisenut.login.model.User;
import kr.co.wisenut.login.service.LoginService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	UserDao userDao;
	
	@Override
	public boolean isValidUser(User userInfo) throws Exception{
		return userDao.isValidUser(userInfo);
	}
}
