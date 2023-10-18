package testWeb.dao;

import testWeb.vo.UserInfo;

//增加了一个方法
public interface UserDAO {
	public int queryByUserInfo (UserInfo userinfo) throws Exception;
	public UserInfo queryUser (UserInfo userinfo) throws Exception;
	public boolean updateUser (UserInfo userinfo) throws Exception;
}
