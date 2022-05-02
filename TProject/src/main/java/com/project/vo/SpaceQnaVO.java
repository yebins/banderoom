package com.project.vo;

import java.util.Date;

public class SpaceQnaVO {
	
	private int qnaIdx;
	private int spaceIdx;
	private int mIdx;
	private String mNickname;
	private String content;
	private String publicYN;
	private Date regDate;
	private String answer;
	private Date answerDate;
	
	public int getQnaIdx() {
		return qnaIdx;
	}
	public void setQnaIdx(int qnaIdx) {
		this.qnaIdx = qnaIdx;
	}
	public int getSpaceIdx() {
		return spaceIdx;
	}
	public void setSpaceIdx(int spaceIdx) {
		this.spaceIdx = spaceIdx;
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
	public String getPublicYN() {
		return publicYN;
	}
	public void setPublicYN(String publicYN) {
		this.publicYN = publicYN;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public Date getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}
}
