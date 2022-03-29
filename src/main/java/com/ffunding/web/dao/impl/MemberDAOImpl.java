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
	private static final String ID_CHECK = NS + ".idChk";
	private static final String REGIST = NS + ".register";
	private static final String FINDID = NS + ".findID";
	private static final String UPDATEPW = NS + ".updatePW";
	
	
	@Override
	public MemberVO loginCheck(Map<String, String> loginMap) throws Exception {
		
		return sqlSession.selectOne(LOGIN, loginMap);
	}

	@Override
	public MemberVO getBySns(MemberVO snsUser) throws Exception {
		
		if (StringUtils.isNotEmpty(snsUser.getNaverid())) {
			return sqlSession.selectOne(GET_BY_SNS_NAVER, snsUser.getNaverid());
		} else if (StringUtils.isNotEmpty(snsUser.getGoogleid())) {
			return sqlSession.selectOne(GET_BY_SNS_GOOGLE, snsUser.getGoogleid());
		} else {
			return sqlSession.selectOne(GET_BY_SNS_KAKAO, snsUser.getKakaoid());
		}
		
	}

	@Override
	public void joinBySns(MemberVO snsUser) throws Exception {
		
		if (StringUtils.isNotEmpty(snsUser.getNaverid())) { 
			sqlSession.insert(JOIN_BY_SNS_NAVER, snsUser);
		}else if(StringUtils.isNotEmpty(snsUser.getGoogleid())) {
			sqlSession.insert(JOIN_BY_SNS_GOOGLE, snsUser);
		} else {
			sqlSession.insert(JOIN_BY_SNS_KAKAO, snsUser);
		}
	}

	@Override
	public int idChk(Map<String, String> idMap) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(ID_CHECK, idMap);
	}

	@Override
	public void register(MemberVO reg) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(REGIST, reg);
	}

	@Override
	public String getID(String email) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(FINDID, email);
	}

	@Override
	public void updatePW(Map<String, String> update) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(UPDATEPW, update);
	}
}
