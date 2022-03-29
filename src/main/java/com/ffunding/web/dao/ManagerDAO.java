package com.ffunding.web.dao;

import java.util.HashMap;
import java.util.List;

import com.ffunding.web.vo.ApplyPagingVO;
import com.ffunding.web.vo.ApplyViewVO;
import com.ffunding.web.vo.FundingExpVO;
import com.ffunding.web.vo.FundingInsVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.OrderVO;
import com.ffunding.web.vo.PurchaseVO;

public interface ManagerDAO {
	//관리자
	public List<String> managerList() throws Exception;
	//총 회원수
	public int memberCnt() throws Exception;
	//일반회원수
	public int generalCnt() throws Exception;
	//판매자수
	public int sellerCnt() throws Exception;
	//펀딩신청 총 게시물수
	public int applyCnt() throws Exception;
	//펀딩예정 총 게시물수
	public int expectCnt() throws Exception;
	//펀딩진행중 총 게시물수
	public int progressCnt() throws Exception;
	//펀딩 카테고리별 개수
	public int categoryCnt(String cate) throws Exception;
	//회원 리스트
	public List<MemberVO> memberList(MemberPagingVO paging) throws Exception;
	//회원 검색 결과 총 회원수
	public int memberSearchCnt(MemberPagingVO paging) throws Exception;
	//회원 상세정보
	public MemberVO memberDetail(String mid) throws Exception;
	//회원 정보수정
	public void memberDetailUpdate(MemberVO upt) throws Exception;
	//펀딩신청 리스트
	public List<ApplyViewVO> applyList(ApplyPagingVO paging) throws Exception;
	//펀딩신청 상세정보
	public ApplyViewVO applyDetail(int fid) throws Exception;
	//펀딩신청 이미지
	public List<String> applyImage(int fid) throws Exception;
	//펀딩신청 삭제
	public void applyDel(int fid) throws Exception;
	//펀딩신청 이미지 삭제
	public void applyImageDel(int fid) throws Exception;
	//펀딩신청 승인
	public void fundingIns(FundingInsVO funding) throws Exception;
	//펀딩신청 승인시 order데이터 삽입
	public void orderIns(HashMap<String, Object> map) throws Exception;
	//판매자로 권한변경
	public void sellerUpt(String mid) throws Exception;
	//구매신청 총 게시물수
	public int purchaseCnt() throws Exception;
	//구매신청 리스트
	public List<PurchaseVO> purchaseList(ApplyPagingVO paging) throws Exception;
	//구매신청 상세정보
	public FundingExpVO purchaseDetail(int fid) throws Exception;
	//구매신청 삭제
	public void purchaseDel(int fid) throws Exception;
	//펀딩구매 회원 삭제
	public void orderDel(int fid) throws Exception;
	//펀딩한 회원리스트
	public List<OrderVO> orderList(int fid) throws Exception;
	//회원 포인트 환불
	public void pointUpt(OrderVO order) throws Exception;
	//펀딩한 회원 이메일
	public List<String> orderEmail(int fid) throws Exception;
	//펀딩 이름
	public String fundingName(int fid) throws Exception;
	//모든 회원의 이메일
	public List<String> memberEmail() throws Exception;
	//판매자 이메일
	public List<String> sellerEmail() throws Exception;
	//차트 그래프 x축 y축 날짜데이터
	public String chartXList() throws Exception;
	public int date1Cnt() throws Exception; 
	public int date2Cnt() throws Exception; 
	public int date3Cnt() throws Exception; 
	public int date4Cnt() throws Exception; 
	public int date5Cnt() throws Exception; 
	public int date6Cnt() throws Exception; 
	public int date7Cnt() throws Exception; 
}
