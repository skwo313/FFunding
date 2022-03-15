package com.ffunding.web.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ffunding.web.dao.MemberDAO;
import com.ffunding.web.service.MemberService;
import com.ffunding.web.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDAO dao;
	
	@Override
	public MemberVO loginCheck(MemberVO ck) throws Exception {
		System.out.println(ck.getMid());
		System.out.println(ck.getMpw());
		return dao.loginCheck(ck);
	}
}
