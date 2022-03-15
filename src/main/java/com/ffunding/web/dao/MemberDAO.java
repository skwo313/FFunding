package com.ffunding.web.dao;

import com.ffunding.web.vo.MemberVO;

public interface MemberDAO {
	
	public MemberVO loginCheck(MemberVO vo) throws Exception;
}
