package com.ffunding.web.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ffunding.web.dao.FundingDAO;
import com.ffunding.web.service.FundingService;
import com.ffunding.web.vo.FundingVO;

@Service
public class FundingServiceImpl implements FundingService {
	@Inject
	private FundingDAO dao;

	// 펀딩 목록 조회
	@Override
	public List<FundingVO> list(HashMap<String, Object> hashMap) throws Exception {
		System.out.println(hashMap);
		return dao.list(hashMap);
	}
	// 제품 상세 페이지
	public FundingVO viewDetail(int fid) throws Exception{
		return dao.viewDetail(fid);
	}
}
