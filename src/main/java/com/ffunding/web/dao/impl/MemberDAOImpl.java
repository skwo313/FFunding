package com.ffunding.web.dao.impl;

import java.util.Map;

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
	public MemberVO loginCheck(Map<String, String> loginMap) {
		
		return sqlSession.selectOne("userMapper.loginCheck", loginMap);
	}
}
