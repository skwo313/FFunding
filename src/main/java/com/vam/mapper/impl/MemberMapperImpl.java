package com.vam.mapper.impl;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.vam.mapper.MemberMapper;
import com.vam.model.MemberVO;

public class MemberMapperImpl implements MemberMapper {
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public void memberJoin(MemberVO memberVO) {
		sqlSession.insert("memberMapper.insert", memberVO);
	}

}
