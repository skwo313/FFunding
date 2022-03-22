package com.ffunding.web.dao;

import java.util.List;

import com.ffunding.web.vo.FundingVO;

public interface FundingDAO {
	// 펀딩 목록 조회
	public List<FundingVO> list() throws Exception;

}
