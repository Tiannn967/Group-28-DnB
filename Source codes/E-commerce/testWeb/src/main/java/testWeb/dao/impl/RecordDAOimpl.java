package testWeb.dao.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import testWeb.dao.RecordDAO;
import testWeb.db.DBConnect;
import testWeb.vo.UserRecord;

public class RecordDAOimpl implements RecordDAO {

	@Override
	public UserRecord queryRecord (UserRecord userRec) throws Exception {
		
		String sql1 = "select * from EXPLORE where userName=?";
		String sql2 = "select COUNT(*) AS num from TREASURE_FOUND group by exploreNo";
		PreparedStatement pstmt = null;
		DBConnect dbc = null;		
		
		try {
			dbc = new DBConnect();
			pstmt = dbc.getConnection().prepareStatement(sql1);
			pstmt.setString(1,userRec.getUsername());
			
			ResultSet rs = pstmt.executeQuery();
			
			int i=0;
			while(rs.next()) {
				Object[] array = new Object[4];
				userRec.getRecs().add(array);
				userRec.setRecs(i,0,rs.getString(1));
				userRec.setRecs(i,1,rs.getString(3));
				userRec.setRecs(i,2,rs.getString(4));
				System.out.println(i + " :" + rs.getString(1));
				i++;
			}
			
			pstmt = dbc.getConnection().prepareStatement(sql2);
			rs = pstmt.executeQuery();
			
			i=0;
			while(rs.next()) {
				userRec.setRecs(i,3,rs.getInt(1));
				i++;
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());;
		} finally {
			dbc.close();
		}
		
		return userRec;	
	}
	
	@Override
	public int[] queryTotTres (UserRecord userRec) throws Exception {
		String sql = "SELECT tf.treasureName, COUNT(tf.treasureName) AS total\r\n"
				+ "FROM Explore e, Treasure_found tf\r\n"
				+ "WHERE e.userName =? AND tf.exploreNo = e.exploreNo\r\n"
				+ "GROUP BY tf.treasureName;\r\n";
		PreparedStatement pstmt = null;
		DBConnect dbc = null;	
		int[] totTre = new int[4];
		
		try {
			dbc = new DBConnect();
			pstmt = dbc.getConnection().prepareStatement(sql);
			pstmt.setString(1,userRec.getUsername());
			
			ResultSet rs = pstmt.executeQuery();
			
			int i = 0;
			while (rs.next()) {
			    totTre[i] = rs.getInt(2);
			    i++;
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());;
		} finally {
			dbc.close();
		}
		
		return totTre;
	}
	

}
