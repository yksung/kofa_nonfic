package kr.co.wisenut.login.service;

import kr.co.wisenut.login.model.User;

public interface LoginService {
	public boolean isValidUser(User loginInfo) throws Exception;
}
