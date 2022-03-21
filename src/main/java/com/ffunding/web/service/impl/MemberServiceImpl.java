package com.ffunding.web.service.impl;

import java.util.Map;

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
	public MemberVO loginCheck(Map<String, String> loginMap) throws Exception {
		return dao.loginCheck(loginMap);
	}

	@Override
	public MemberVO getBySns(MemberVO snsUser) {
		// TODO Auto-generated method stub
		return dao.getBySns(snsUser);
	}

	@Override
	public void joinBySns(MemberVO snsUser) {
		// TODO Auto-generated method stub
		dao.joinBySns(snsUser);
	}
}
