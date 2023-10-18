package testWeb.vo;

public class UserInfo {

	private String username;
	private String password;
	//增加了以下三条数据
	private String robotNo;
	private String robotModel;
	private String robotDes;
	
	public UserInfo() {
		super();
	}
	
	public UserInfo(String username, String password, String robotNo, String robotModel, String robotDes) {
		super();
		this.username = username;
		this.password = password;
		this.robotNo = robotNo;
		this.robotModel = robotModel;
		this.robotDes = robotDes;
	}	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRobotNo() {
		return robotNo;
	}
	public void setRobotNo(String robotNo) {
		this.robotNo = robotNo;
	}
	public String getRobotModel() {
		return robotModel;
	}
	public void setRobotModel(String robotModel) {
		this.robotModel = robotModel;
	}
	public String getRobotDes() {
		return robotDes;
	}
	public void setRobotDes(String robotDes) {
		this.robotDes = robotDes;
	}
}
