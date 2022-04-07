package com.ffunding.web.dao.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.MypageDao;
import com.ffunding.web.vo.MemberVO;

@Repository
public class MypageDaoImpl implements MypageDao {
	@Inject
	private SqlSession sqlSession;
	
	private static final String NS = "mypageMapper";
	private static final String GETINFO = NS + ".getInfo";
	private static final String FUNDINGLIST = NS + ".fundingList";
	private static final String UPDATEPW = NS + ".updatePW";
	private static final String UPDATEADDR = NS + ".updateAddr";
	private static final String GETFUNDING = NS + ".getFunding";
	private static final String GETDONATION = NS + ".getDonation";
	private static final String POINT = NS + ".getPoint";
	private static final String CHARGE = NS + ".pointCharge";
	
	@Override
	public Map<String, String> getInfo(MemberVO session) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(GETINFO, session.getMid());
	}
	
	@Override
	public List<Map<String, String>> fundingList(MemberVO session) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(FUNDINGLIST, session.getMid());
	}

	@Override
	public void updatePW(Map<String, String> update) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(UPDATEPW, update);
	}

	@Override
	public void updateAddr(Map<String, String> update) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(UPDATEADDR, update);
	}

	@Override
	public List<String> getFunding(MemberVO fl) throws Exception {
		// TODO Auto-generated method stub
		
		return sqlSession.selectList(GETFUNDING, fl.getMid());
	}

	@Override
	public List<String> getDonation(MemberVO dl) throws Exception {
		// TODO Auto-generated method stub
		
		return sqlSession.selectList(GETDONATION, dl.getMid());
	}

	@Override
	public void pointCharge(Map<String, String> payInfo) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.update(CHARGE, payInfo);
	}

	@Override
	public String getPoint(MemberVO id) throws Exception {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne(POINT, id.getMid());
	}
	
}
