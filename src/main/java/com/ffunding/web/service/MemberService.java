package com.ffunding.web.service;

import java.util.Map;

import com.ffunding.web.vo.MemberVO;

public interface MemberService {
	
	public MemberVO loginCheck(Map<String, String> loginMap) throws Exception;

	public MemberVO getBySns(MemberVO snsUser);

	public void joinBySns(MemberVO snsUser);
	
}