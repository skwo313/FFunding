package com.ffunding.web.service;

import java.util.List;

import com.ffunding.web.vo.ApplyPagingVO;
import com.ffunding.web.vo.ApplyViewVO;
import com.ffunding.web.vo.FundingInsVO;
import com.ffunding.web.vo.MailVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.PurchaseVO;

public interface ManagerService {
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
	//펀딩신청 승인
	public void fundingIns(FundingInsVO funding) throws Exception;
	//구매신청 리스트
	public List<PurchaseVO> purchaseList(ApplyPagingVO paging) throws Exception;
	//구매신청 승인
	public void purchaseIns(int fid) throws Exception;
	//구매신청 삭제
	public void purchaseDel(int fid) throws Exception;
	//메일전송
	public String sendMail(MailVO mail) throws Exception;
}
