package com.ffunding.web.vo;

public class MemberVO {
	private String mid;
	private String mpw;
	private String mname;
	private String mphone;
	private String memail;
	private String maddress_detail;
	private String maddress;
	private int point;
	private char adminck;
	private char sellerck;
	
	private String naverid;
	private String googleid;
	private String kakaoid;
	
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpw() {
		return mpw;
	}
	public void setMpw(String mpw) {
		this.mpw = mpw;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public String getMemail() {
		return memail;
	}
	public void setMemail(String memail) {
		this.memail = memail;
	}
	public String getMaddress_detail() {
		return maddress_detail;
	}
	public void setMaddress_detail(String maddress_detail) {
		this.maddress_detail = maddress_detail;
	}
	public String getMaddress() {
		return maddress;
	}
	public void setMaddress(String maddress) {
		this.maddress = maddress;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public char getAdminck() {
		return adminck;
	}
	public void setAdminck(char adminck) {
		this.adminck = adminck;
	}
	public char getSellerck() {
		return sellerck;
	}
	public void setSellerck(char sellerck) {
		this.sellerck = sellerck;
	}
	public String getNaverid() {
		return naverid;
	}
	public void setNaverid(String naverid) {
		this.naverid = naverid;
	}
	public String getGoogleid() {
		return googleid;
	}
	public void setGoogleid(String googleid) {
		this.googleid = googleid;
	}
	public String getKakaoid() {
		return kakaoid;
	}
	public void setKakaoid(String kakaoid) {
		this.kakaoid = kakaoid;
	}
	
	@Override
	public String toString() {
		return "{mid : "+ mid +", mname : "+ mname +", naverid : "+ naverid
				+", memail : "+ memail +", googleid :"+ googleid +"}";
	}
}