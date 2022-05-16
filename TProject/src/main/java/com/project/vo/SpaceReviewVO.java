package com.project.vo;

import java.util.Date;

public class SpaceReviewVO extends GeneralMembersVO {
	
	private int resIdx;
	private int spaceIdx;
	private String pictureSrc;
	private String thumbSrc;
	private double score;
	private int mIdx;
	private String mNickname;
	private String content;
	private Date regDate;

	public int getResIdx() {
		return resIdx;
	}
	public void setResIdx(int resIdx) {
		this.resIdx = resIdx;
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
	public String getThumbSrc() {
		return thumbSrc;
	}
	public void setThumbSrc(String thumbSrc) {
		this.thumbSrc = thumbSrc;
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
	@Override
	public String toString() {
		return "SpaceReviewVO [resIdx=" + resIdx + ", spaceIdx=" + spaceIdx + ", pictureSrc=" + pictureSrc + ", thumbSrc="
				+ thumbSrc + ", score=" + score + ", mIdx=" + mIdx + ", mNickname=" + mNickname + ", content=" + content
				+ ", regDate=" + regDate + "]";
	}

}
