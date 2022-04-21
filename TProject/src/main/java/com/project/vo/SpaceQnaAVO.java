package com.project.vo;

import java.util.Date;

public class SpaceQnaAVO {
	
	private int qnaIdx;
	private String content;
	private Date regDate;
	
	public int getQnaIdx() {
		return qnaIdx;
	}
	public void setQnaIdx(int qnaIdx) {
		this.qnaIdx = qnaIdx;
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
