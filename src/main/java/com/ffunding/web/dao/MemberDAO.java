package com.ffunding.web.dao;

import java.util.Map;

import com.ffunding.web.vo.MemberVO;

public interface MemberDAO {
	
	public MemberVO loginCheck(Map<String, String> loginMap) throws Exception;

	public MemberVO getBySns(MemberVO snsUser);
}
