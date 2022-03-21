package com.ffunding.web.vo;

public class RankVO {
	private int fid;
	private int sell;
	private String fname;
	private String fcate;
	private String fimg;
	private int goal;
	public RankVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RankVO(int fid, int sell, String fname, String fcate, String fimg, int goal) {
		super();
		this.fid = fid;
		this.sell = sell;
		this.fname = fname;
		this.fcate = fcate;
		this.fimg = fimg;
		this.goal = goal;
	}
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public int getSell() {
		return sell;
	}
	public void setSell(int sell) {
		this.sell = sell;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getFcate() {
		return fcate;
	}
	public void setFcate(String fcate) {
		this.fcate = fcate;
	}
	public String getFimg() {
		return fimg;
	}
	public void setFimg(String fimg) {
		this.fimg = fimg;
	}
	public int getGoal() {
		return goal;
	}
	public void setGoal(int goal) {
		this.goal = goal;
	}
	
}
