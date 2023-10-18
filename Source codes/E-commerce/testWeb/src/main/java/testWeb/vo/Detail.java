package testWeb.vo;

import java.util.ArrayList;

public class Detail {
	private String expID;
	private String expPath;
	private ArrayList<String[]> treasure= new ArrayList<>();
	public String getExpID() {
		return expID;
	}
	public void setExpID(String expID) {
		this.expID = expID;
	}
	public String getExpPath() {
		return expPath;
	}
	public void setExpPath(String expPath) {
		this.expPath = expPath;
	}
	public ArrayList<String[]> getTreasure() {
		return treasure;
	}
	public void setTreasure(ArrayList<String[]> treasure) {
		this.treasure = treasure;
	}


}
