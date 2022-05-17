package com.project.vo;

public class PointsVO extends ReservationsVO {

	private int pointIdx;
	private int mIdx;
	private int resIdx;
	private String content;
	private int amount;
	private int balance;
	
	public int getPointIdx() {
		return pointIdx;
	}
	public void setPointIdx(int pointIdx) {
		this.pointIdx = pointIdx;
	}
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
}
