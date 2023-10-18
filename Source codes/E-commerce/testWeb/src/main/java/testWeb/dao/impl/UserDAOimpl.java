package testWeb.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import testWeb.dao.UserDAO;
import testWeb.vo.UserInfo;
import testWeb.db.DBConnect;

//此class增加了一个方法，原方法只用于验证用户密码是否正确，先增加一个方法用于检索用户数据
public class UserDAOimpl implements UserDAO {

	@Override
	public int queryByUserInfo(UserInfo userinfo) throws Exception {
		int flag =0;
		String sql = "select * from USER_INFO where username=?";
		PreparedStatement pstmt = null;
		DBConnect dbc = null;
		
		try {
			dbc = new DBConnect();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1,userinfo.getUsername());
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getString("password").equals(userinfo.getPassword())) {
					flag =1;
				}
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());;
		} finally {
			dbc.close();
		}
		
		return flag;
	}

	//检索用户数据，将除了用户名和密码以外的信息存在数组中并返回数组首地址
	@Override
	public UserInfo queryUser(UserInfo userinfo) throws Exception {
		String sql = "select * from user_info where username=?";
		PreparedStatement pstmt = null;
		DBConnect dbc = null;		
		
		try {
			dbc = new DBConnect();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1,userinfo.getUsername());
			
			ResultSet rs = pstmt.executeQuery();
			
			System.out.println("hi");
			if( rs.next() ) System.out.println("hello");
			userinfo.setRobotNo(rs.getString("robotNo"));
			userinfo.setRobotModel(rs.getString("robotModel"));
			userinfo.setRobotDes(rs.getString("robotDes"));
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());;
		} finally {
			dbc.close();
		}
		
		return userinfo;
		
	}
	
	@Override
	public boolean updateUser (UserInfo userInfo) throws Exception {
		DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        PreparedStatement pStmt = null;
        boolean isSuccess = false;
        
        try {
            pStmt = conn.prepareStatement("UPDATE user_info\r\n"
            		+ "SET robotNo = ?, robotModel = ?, robotDes = ?\r\n"
            		+ "WHERE username = ?;\r\n");
            System.out.println("message from UserDAO: " + userInfo.getRobotNo() +" "+ userInfo.getRobotModel() +" "+ userInfo.getRobotDes() +" "+userInfo.getUsername());
            pStmt.setString(1, userInfo.getRobotNo());
            pStmt.setString(2, userInfo.getRobotModel());
            pStmt.setString(3, userInfo.getRobotDes());
            pStmt.setString(4, userInfo.getUsername());
            int rst = pStmt.executeUpdate();
            
            if (rst != 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pStmt != null) {
                try {
                    pStmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            dbConnect.close();
        }
        
        return isSuccess;		
	}
	
}
