package com.ffunding.web.vo;

public class VisitVO {
	private String visit_ip;
	private String visit_time;
	public VisitVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public VisitVO(String visit_ip, String visit_time) {
		super();
		this.visit_ip = visit_ip;
		this.visit_time = visit_time;
	}
	public String getVisit_ip() {
		return visit_ip;
	}
	public void setVisit_ip(String visit_ip) {
		this.visit_ip = visit_ip;
	}
	public String getVisit_time() {
		return visit_time;
	}
	public void setVisit_time(String visit_time) {
		this.visit_time = visit_time;
	}
	
	
}
