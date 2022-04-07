package com.ffunding.web.dao;

import java.util.List;
import java.util.Map;

import com.ffunding.web.vo.MemberVO;

public interface MypageDao {

	public Map<String, String> getInfo(MemberVO session) throws Exception;

	public List<Map<String, String>> fundingList(MemberVO session) throws Exception;

	public void updatePW(Map<String, String> update) throws Exception;

	public void updateAddr(Map<String, String> update) throws Exception;

	public List<String> getFunding(MemberVO fl) throws Exception;

	public List<String> getDonation(MemberVO dl) throws Exception;

	public void pointCharge(Map<String, String> payInfo) throws Exception;

}
