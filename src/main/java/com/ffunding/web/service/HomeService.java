package com.ffunding.web.service;

import java.util.List;

import com.ffunding.web.vo.FundingVO;
import com.ffunding.web.vo.RankVO;

public interface HomeService {
	// 메인화면 판매순 랭킹
	public List<RankVO> sellRank() throws Exception;

	// 메인화면 달성금액순 랭킹
	public List<RankVO> goalRank() throws Exception;

	// 메인화면 펀딩 예정 리스트
	public List<FundingVO> expected() throws Exception;
}
