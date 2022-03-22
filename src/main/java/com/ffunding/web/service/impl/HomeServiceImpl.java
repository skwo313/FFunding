package com.ffunding.web.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ffunding.web.dao.HomeDAO;
import com.ffunding.web.service.HomeService;
import com.ffunding.web.vo.FundingExpVO;
import com.ffunding.web.vo.RankVO;

@Service
public class HomeServiceImpl implements HomeService {
	@Inject
	private HomeDAO dao;

	// 메인화면 판매순 랭킹
	@Override
	public List<RankVO> sellRank() throws Exception {

		return dao.sellRank();
	}

	// 메인화면 달성금액순 랭킹
	@Override
	public List<RankVO> goalRank() throws Exception {

		return dao.goalRank();
	}

	// 메인화면 펀딩 예정리스트
	@Override
	public List<FundingExpVO> expected() throws Exception {

		return dao.expected();
	}
}
