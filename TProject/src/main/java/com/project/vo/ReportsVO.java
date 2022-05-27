package com.project.vo;

import java.util.Date;

public class ReportsVO{
	private int rIdx;
	private int reporter;
	private String reportername;
	private int target;
	private String targetname;
	private String content;
	private Date repDate;
	private int reportCount;
	
	public int getrIdx() {
		return rIdx;
	}
	public void setrIdx(int rIdx) {
		this.rIdx = rIdx;
	}
	public int getReporter() {
		return reporter;
	}
	public void setReporter(int reporter) {
		this.reporter = reporter;
	}
	public int getTarget() {
		return target;
	}
	public void setTarget(int target) {
		this.target = target;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRepDate() {
		return repDate;
	}
	public void setRepDate(Date repDate) {
		this.repDate = repDate;
	}
	public int getReportCount() {
		return reportCount;
	}
	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	public String getReportername() {
		return reportername;
	}
	public void setReportername(String reportername) {
		this.reportername = reportername;
	}
	public String getTargetname() {
		return targetname;
	}
	public void setTargetname(String targetname) {
		this.targetname = targetname;
	}
}
