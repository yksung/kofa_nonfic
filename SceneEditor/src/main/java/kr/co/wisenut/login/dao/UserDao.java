package kr.co.wisenut.login.dao;

import kr.co.wisenut.login.model.User;

public interface UserDao {
	public boolean isValidUser(User loginInfo);
}
