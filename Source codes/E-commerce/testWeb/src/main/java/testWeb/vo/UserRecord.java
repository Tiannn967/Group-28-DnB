package testWeb.vo;

import java.util.ArrayList;

public class UserRecord {
	private ArrayList<Object[]> recs = new ArrayList<>();
	//储存某用户所有探索记录的Arraylist
	//属性分别是：探索编号、探索开始时间、探索结束时间（空即为未结束）、探索获得宝物数目
	//四个属性有不同的数据类型，因而变量类型定为Object
	
	private String username;
	//用户名，用于查询
	
	//getters and setters
	public Object getRecs (int i) {
		return recs.get(i);
	}
	//第一个getter能够返回表中第i条记录
	
	public void setRecs (int i, int j, Object ob) {
		recs.get(i)[j] = ob;
	}

	public ArrayList<Object[]> getRecs() {
		return recs;
	}

	public void setRecs(ArrayList<Object[]> recs) {
		this.recs = recs;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
}
