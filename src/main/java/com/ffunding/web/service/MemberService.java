package com.ffunding.web.service;

import java.util.Map;

import com.ffunding.web.vo.MemberVO;

public interface MemberService {
	
	public MemberVO loginCheck(Map<String, String> loginMap) throws Exception;

	public MemberVO getBySns(MemberVO snsUser) throws Exception;

	public void joinBySns(MemberVO snsUser) throws Exception;

	public int idChk(Map<String, String> idMap) throws Exception;

	public void register(MemberVO reg) throws Exception;
	
}