package testWeb.dao.impl;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import testWeb.dao.DetailDAO;
import testWeb.db.DBConnect;
import testWeb.vo.Detail;

public class DetailDAOimpl implements DetailDAO {

	@Override
	public Detail queryDetail(Detail detl) throws Exception {
		String sql1 = "select * from EXPLORE where exploreNo=?";
		String sql2 = "select * from TREASURE_FOUND where exploreNo=?";
		PreparedStatement pstmt = null;
		DBConnect dbc = null;		
		
		try {
			dbc = new DBConnect();
			pstmt = dbc.getConnection().prepareStatement(sql1);
			pstmt.setString(1,detl.getExpID());
			
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				detl.setExpID(rs.getString(1));
				detl.setExpPath(rs.getString(5));
			}
			
			pstmt = dbc.getConnection().prepareStatement(sql2);
			pstmt.setString(1,detl.getExpID());
			rs = pstmt.executeQuery();
			
			int i=0;
			while (rs.next()) {
				String[] array = new String[2];
				System.out.println("list length bf:" + detl.getTreasure().size());
				detl.getTreasure().add(array);
				System.out.println("list length af:" + detl.getTreasure().size());
				detl.getTreasure().get(i)[0] = rs.getString(1);
				detl.getTreasure().get(i)[1] = rs.getString(3);
				
				System.out.println("major");
				System.out.println(rs.getString(1) + rs.getString(3));
				System.out.println(detl.getTreasure().get(i)[0]);
				
				i++;
				if(i == 2)System.out.println("Sample4: " + detl.getTreasure().get(1)[0]);
			}
			System.out.println("Sample3: " + detl.getTreasure().get(1)[0]);
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());;
		} finally {
			dbc.close();
		}
		
		System.out.println("Sample2: " + detl.getTreasure().get(1)[0]);
		return detl;
	}

}
