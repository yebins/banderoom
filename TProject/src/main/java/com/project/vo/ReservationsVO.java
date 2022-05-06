package com.project.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReservationsVO {

	private int resIdx;
	private int mIdx;
	private int spaceIdx;
	private int peopleNum;
	@DateTimeFormat(pattern = "yyyy-MM-dd-HH")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd-HH")
	private Date endDate;
	private int rsvHours;
	private Date resDate;
	private int cost;				// 포인트 적용 전 금액
	private int usedPoint;	// 사용한 포인트
	private int totalCost;	// 실제 결제 금액
	
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
	public int getRsvHours() {
		return rsvHours;
	}
	public void setRsvHours(int rsvHours) {
		this.rsvHours = rsvHours;
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
	public int getUsedPoint() {
		return usedPoint;
	}
	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}
	public int getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(int totalCost) {
		this.totalCost = totalCost;
	}
}
