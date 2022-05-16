package com.project.vo;

public class ApplicationsVO extends TeamsVO{

	private int appIdx;
	private int teamIdx;
	private int mIdx;
	private String mNickname;
	private int partIdx;
	private String partname;
	private String partcapacity;
	private String content;
	
	public int getAppIdx() {
		return appIdx;
	}
	public void setAppIdx(int appIdx) {
		this.appIdx = appIdx;
	}
	public int getTeamIdx() {
		return teamIdx;
	}
	public void setTeamIdx(int teamIdx) {
		this.teamIdx = teamIdx;
	}
	public int getmIdx() {
		return mIdx;
	}
	public void setmIdx(int mIdx) {
		this.mIdx = mIdx;
	}
	public String getmNickname() {
		return mNickname;
	}
	public void setmNickname(String mNickname) {
		this.mNickname = mNickname;
	}
	public int getPartIdx() {
		return partIdx;
	}
	public void setPartIdx(int partIdx) {
		this.partIdx = partIdx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPartname() {
		return partname;
	}
	public void setPartname(String partname) {
		this.partname = partname;
	}
	public String getPartcapacity() {
		return partcapacity;
	}
	public void setPartcapacity(String partcapacity) {
		this.partcapacity = partcapacity;
	}
	
}
