package com.ffunding.web.vo;

import java.util.List;

public class ApplyViewVO {
	private int fid;
	private String fcate;
	private String fname;
	private int fprice;
	private int fgoal;
	private String fdate;
	private String fstartdate;
	private String fenddate;
	private String fdes;
	private String writer;
	private String agreement;	
	private List<String> fimg;
	
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getFcate() {
		return fcate;
	}
	public void setFcate(String fcate) {
		this.fcate = fcate;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public int getFprice() {
		return fprice;
	}
	public void setFprice(int fprice) {
		this.fprice = fprice;
	}
	public int getFgoal() {
		return fgoal;
	}
	public void setFgoal(int fgoal) {
		this.fgoal = fgoal;
	}
	public String getFdate() {
		return fdate;
	}
	public void setFdate(String fdate) {
		this.fdate = fdate;
	}
	public String getFstartdate() {
		return fstartdate;
	}
	public void setFstartdate(String fstartdate) {
		this.fstartdate = fstartdate;
	}
	public String getFenddate() {
		return fenddate;
	}
	public void setFenddate(String fenddate) {
		this.fenddate = fenddate;
	}
	public String getFdes() {
		return fdes;
	}
	public void setFdes(String fdes) {
		this.fdes = fdes;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getAgreement() {
		return agreement;
	}
	public void setAgreement(String agreement) {
		this.agreement = agreement;
	}
	public List<String> getFimg() {
		return fimg;
	}
	public void setFimg(List<String> fimg) {
		this.fimg = fimg;
	}
}
