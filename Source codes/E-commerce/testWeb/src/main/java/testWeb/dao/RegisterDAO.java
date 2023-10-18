package testWeb.dao;

import testWeb.vo.UserInfo;

public interface RegisterDAO {
	public boolean isUserExist(String username);
	public boolean addUser(UserInfo userInfo);
}
