package com.ffunding.web.service;

import java.util.List;

import com.ffunding.web.vo.FundingVO;

public interface FundingService {
	// 펀딩 목록 조회
	public List<FundingVO> list() throws Exception;

}
