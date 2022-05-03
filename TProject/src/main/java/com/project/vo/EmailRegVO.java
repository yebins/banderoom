package com.project.vo;

import java.util.Date;

public class EmailRegVO {
	
	private String email;
	private String regkey;
	private Date deadLine;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRegkey() {
		return regkey;
	}
	public void setRegkey(String regkey) {
		this.regkey = regkey;
	}
	public Date getDeadLine() {
		return deadLine;
	}
	public void setDeadLine(Date deadLine) {
		this.deadLine = deadLine;
	}
}
