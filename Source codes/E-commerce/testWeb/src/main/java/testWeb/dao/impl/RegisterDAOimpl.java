package testWeb.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import testWeb.dao.RegisterDAO;
import testWeb.db.DBConnect;
import testWeb.vo.UserInfo;

public class RegisterDAOimpl implements RegisterDAO {

	@Override
	public boolean isUserExist (String username) {
		DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        PreparedStatement pStmt = null;
        ResultSet rs = null;
        boolean isExist = false;
        
        try {
            pStmt = conn.prepareStatement("SELECT * FROM user_info WHERE username = ?");
            pStmt.setString(1, username);
            rs = pStmt.executeQuery();
            
            if (rs.next()) {
                isExist = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pStmt != null) {
                try {
                    pStmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            dbConnect.close();
        }
        
        return isExist;
	}

	@Override
	public boolean addUser(UserInfo userInfo) {
		DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        PreparedStatement pStmt = null;
        boolean isSuccess = false;
        
        try {
            pStmt = conn.prepareStatement("INSERT INTO user_info VALUES (?,?,?,?,?)");
            pStmt.setString(1, userInfo.getUsername());
            pStmt.setString(2, userInfo.getPassword());
            pStmt.setString(3, userInfo.getRobotNo());
            pStmt.setString(4, userInfo.getRobotModel());
            pStmt.setString(5, userInfo.getRobotDes());
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
