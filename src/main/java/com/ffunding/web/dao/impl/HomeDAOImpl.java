package com.ffunding.web.dao.impl;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.HomeDAO;
import com.ffunding.web.vo.FundingVO;
import com.ffunding.web.vo.RankVO;

@Repository
public class HomeDAOImpl implements HomeDAO {
	@Inject
	private SqlSession sqlSession;

	// 메인화면 판매순 랭킹
	@Override
	public List<RankVO> sellRank() throws Exception {
		return sqlSession.selectList("homeMapper.homeSellRank");
	}

	// 메인화면 달성금액순 랭킹
	@Override
	public List<RankVO> goalRank() throws Exception {
		return sqlSession.selectList("homeMapper.homeGoalRank");
	}

	// 메인화면 펀딩 예정 리스트
	@Override
	public List<FundingVO> expected() throws Exception {
		return sqlSession.selectList("homeMapper.expected");
	}
}
