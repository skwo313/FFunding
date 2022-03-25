package com.ffunding.web.dao.impl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.FundingDAO;
import com.ffunding.web.vo.FundingVO;

@Repository
public class FundingDAOImpl implements FundingDAO {
	@Inject
	private SqlSession sqlSession;

	// 펀딩목록
	@Override
	public List<FundingVO> list(HashMap<String, Object> hashMap) throws Exception {
		System.out.println(hashMap);
		return sqlSession.selectList("fundingMapper.getlist", hashMap);
	}
	
	// 제품 상세 페이지
	public FundingVO viewDetail(int fid) throws Exception{
		return sqlSession.selectOne("fundingMapper.detailview", fid);
	}

}
