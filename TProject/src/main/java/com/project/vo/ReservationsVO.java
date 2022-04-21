package com.project.vo;

import java.util.Date;

public class ReservationsVO {

	private int resIdx;
	private int mIdx;
	private int spaceIdx;
	private int peopleNum;
	private Date startDate;
	private Date endDate;
	private Date resDate;
	private int cost;
	
	public int getResIdx() {
		return resIdx;
	}
	public void setResIdx(int resIdx) {
		this.resIdx = resIdx;
	}
	public int getmIdx() {
		return mIdx;
	}
	public void setmIdx(int mIdx) {
		this.mIdx = mIdx;
	}
	public int getSpaceIdx() {
		return spaceIdx;
	}
	public void setSpaceIdx(int spaceIdx) {
		this.spaceIdx = spaceIdx;
	}
	public int getPeopleNum() {
		return peopleNum;
	}
	public void setPeopleNum(int peopleNum) {
		this.peopleNum = peopleNum;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Date getResDate() {
		return resDate;
	}
	public void setResDate(Date resDate) {
		this.resDate = resDate;
	}
	public int getCost() {
		return cost;
	}
	public void setCost(int cost) {
		this.cost = cost;
	}
}
