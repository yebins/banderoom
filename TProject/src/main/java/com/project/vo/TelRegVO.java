package com.project.vo;

import java.util.Date;

public class TelRegVO {
	
	private String tel;
	private String regkey;
	private Date deadLine;
	
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
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
