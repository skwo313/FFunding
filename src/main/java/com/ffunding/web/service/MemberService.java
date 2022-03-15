package com.ffunding.web.service;

import com.ffunding.web.vo.MemberVO;

public interface MemberService {
	
	public MemberVO loginCheck(MemberVO ck) throws Exception;
	
}