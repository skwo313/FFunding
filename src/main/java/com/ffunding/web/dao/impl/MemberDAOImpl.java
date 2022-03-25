package com.ffunding.web.dao.impl;

import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.MemberDAO;
import com.ffunding.web.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NS = "userMapper";
	private static final String LOGIN = NS + ".loginCheck";
	private static final String GET_BY_SNS_NAVER = NS + ".getBySnsNaver";
	private static final String JOIN_BY_SNS_NAVER = NS + ".joinBySnsNaver";
	private static final String GET_BY_SNS_GOOGLE = NS + ".getBySnsGoogle";
	private static final String JOIN_BY_SNS_GOOGLE = NS + ".joinBySnsGoogle";
	private static final String GET_BY_SNS_KAKAO = NS + ".getBySnsKakao";
	private static final String JOIN_BY_SNS_KAKAO = NS + ".joinBySnsKakao";
	
	
	@Override
	public MemberVO loginCheck(Map<String, String> loginMap) {
		
		return sqlSession.selectOne(LOGIN, loginMap);
	}

	@Override
	public MemberVO getBySns(MemberVO snsUser) {
		
		if (StringUtils.isNotEmpty(snsUser.getNaverid())) {
			return sqlSession.selectOne(GET_BY_SNS_NAVER, snsUser.getNaverid());
		} else if (StringUtils.isNotEmpty(snsUser.getGoogleid())) {
			return sqlSession.selectOne(GET_BY_SNS_GOOGLE, snsUser.getGoogleid());
		} else {
			return sqlSession.selectOne(GET_BY_SNS_KAKAO, snsUser.getKakaoid());
		}
		
	}

	@Override
	public void joinBySns(MemberVO snsUser) {
		
		if (StringUtils.isNotEmpty(snsUser.getNaverid())) { 
			sqlSession.insert(JOIN_BY_SNS_NAVER, snsUser);
		}else if(StringUtils.isNotEmpty(snsUser.getGoogleid())) {
			sqlSession.insert(JOIN_BY_SNS_GOOGLE, snsUser);
		} else {
			sqlSession.insert(JOIN_BY_SNS_KAKAO, snsUser);
		}
	}
}
