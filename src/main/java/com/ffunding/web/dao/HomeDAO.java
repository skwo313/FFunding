package com.ffunding.web.dao;

import java.util.List;

import com.ffunding.web.vo.FundingExpVO;
import com.ffunding.web.vo.RankVO;

public interface HomeDAO {
	// 메인화면 판매순 랭킹
	public List<RankVO> sellRank() throws Exception;

	// 메인화면 달성금액순 랭킹
	public List<RankVO> goalRank() throws Exception;

	// 메인화면 펀딩 예정 리스트
	public List<FundingExpVO> expected() throws Exception;
}
