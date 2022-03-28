package com.ffunding.web.vo;

public class PurchaseVO {
	private int fid;
	private String fname;
	private String fenddate;
	private int price;
	private int donation;
	private int fgoal;
	
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getFenddate() {
		return fenddate;
	}
	public void setFenddate(String fenddate) {
		this.fenddate = fenddate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getDonation() {
		return donation;
	}
	public void setDonation(int donation) {
		this.donation = donation;
	}
	public int getFgoal() {
		return fgoal;
	}
	public void setFgoal(int fgoal) {
		this.fgoal = fgoal;
	}
}
