package com.ffunding.web.dao.impl;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.MemberDAO;
import com.ffunding.web.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public MemberVO loginCheck(MemberVO ck) {
		
		return sqlSession.selectOne("userMapper.loginCheck", ck);
	}
}
