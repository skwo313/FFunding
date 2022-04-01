package com.ffunding.web.service;

import java.util.HashMap;
import java.util.List;

import com.ffunding.web.vo.FundingCriteria;
import com.ffunding.web.vo.FundingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.OrderVO;

public interface FundingService {
	// 펀딩 목록 조회
	public List<FundingVO> list(FundingCriteria cri) throws Exception;

	// 상품 총 갯수
	public int listCount(HashMap<String, Object> hashMap) throws Exception;

	// 제품 상세 페이지
	public FundingVO viewDetail(int fid) throws Exception;

	// 주문 완료
	public void orderProduct(OrderVO vo) throws Exception;

	// 주문 완료시 포인트 차감
	public void pointDown(MemberVO membervo) throws Exception;
}
