package com.ffunding.web.dao.impl;

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
	public List<FundingVO> list() throws Exception {
		return sqlSession.selectList("fundingMapper.getlist");
	}

}
