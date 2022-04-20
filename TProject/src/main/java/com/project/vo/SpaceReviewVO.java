package com.project.vo;

import java.util.Date;

public class SpaceReviewVO {
	
	private int reviewIdx;
	private int spaceIdx;
	private String pictureSrc;
	private double score;
	private int mIdx;
	private String mNickname;
	private String content;
	private Date regDate;
	
	public int getReviewIdx() {
		return reviewIdx;
	}
	public void setReviewIdx(int reviewIdx) {
		this.reviewIdx = reviewIdx;
	}
	public int getSpaceIdx() {
		return spaceIdx;
	}
	public void setSpaceIdx(int spaceIdx) {
		this.spaceIdx = spaceIdx;
	}
	public String getPictureSrc() {
		return pictureSrc;
	}
	public void setPictureSrc(String pictureSrc) {
		this.pictureSrc = pictureSrc;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
}
