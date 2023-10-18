package testWeb.dao;

import testWeb.vo.UserRecord;

//未完成
public interface RecordDAO {
	public UserRecord queryRecord (UserRecord userRec) throws Exception;
	
	public int[] queryTotTres (UserRecord userRec) throws Exception;
}	
