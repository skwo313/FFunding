package com.ffunding.web.vo;

public class OrderVO {
	private int fo_id;
	private String mid;
	private int fid;
	private int fo_cnt;
	private int fo_price;
	private int fo_donation;
	private String fo_date;
	public OrderVO(int fo_id, String mid, int fid, int fo_cnt, int fo_price, int fo_donation, String fo_date) {
		super();
		this.fo_id = fo_id;
		this.mid = mid;
		this.fid = fid;
		this.fo_cnt = fo_cnt;
		this.fo_price = fo_price;
		this.fo_donation = fo_donation;
		this.fo_date = fo_date;
	}
	public OrderVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getFo_id() {
		return fo_id;
	}
	public void setFo_id(int fo_id) {
		this.fo_id = fo_id;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public int getFo_cnt() {
		return fo_cnt;
	}
	public void setFo_cnt(int fo_cnt) {
		this.fo_cnt = fo_cnt;
	}
	public int getFo_price() {
		return fo_price;
	}
	public void setFo_price(int fo_price) {
		this.fo_price = fo_price;
	}
	public int getFo_donation() {
		return fo_donation;
	}
	public void setFo_donation(int fo_donation) {
		this.fo_donation = fo_donation;
	}
	public String getFo_date() {
		return fo_date;
	}
	public void setFo_date(String fo_date) {
		this.fo_date = fo_date;
	}
	
}
