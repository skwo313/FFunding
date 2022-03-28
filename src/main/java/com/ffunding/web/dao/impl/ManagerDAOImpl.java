package com.ffunding.web.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.ManagerDAO;
import com.ffunding.web.vo.ApplyPagingVO;
import com.ffunding.web.vo.ApplyViewVO;
import com.ffunding.web.vo.FundingExpVO;
import com.ffunding.web.vo.FundingInsVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.OrderVO;
import com.ffunding.web.vo.PurchaseVO;

@Repository
public class ManagerDAOImpl implements ManagerDAO {

	@Autowired
	private SqlSession session;
	
	//관리자
	@Override
	public List<String> managerList() throws Exception {
		return session.selectList("managerMapper.managerList");
	}
	
	//총 회원수
	@Override
	public int memberCnt() throws Exception {
		return session.selectOne("managerMapper.memberCnt");
	}
	
	//일반회원수
	@Override
	public int generalCnt() throws Exception {
		return session.selectOne("managerMapper.generalCnt");
	}
	
	//판매자수
	@Override
	public int sellerCnt() throws Exception {
		return session.selectOne("managerMapper.sellerCnt");
	}
	
	//펀딩신청 총 게시물수
	@Override
	public int applyCnt() throws Exception {
		return session.selectOne("managerMapper.applyCnt");
	}
	
	//펀딩예정 총 게시물수
	@Override
	public int expectCnt() throws Exception {
		return session.selectOne("managerMapper.expectCnt");
	}
	
	//펀딩진행중 총 게시물수
	@Override
	public int progressCnt() throws Exception {
		return session.selectOne("managerMapper.progressCnt");
	}
	
	//펀딩 카테고리별 개수
	@Override
	public int categoryCnt(String cate) throws Exception {
		return session.selectOne("managerMapper.categoryCnt", cate);
	}
	
	//회원 리스트
	@Override
	public List<MemberVO> memberList(MemberPagingVO paging) throws Exception {
		return session.selectList("managerMapper.memberList", paging);
	}
	
	//회원 검색 결과 총 회원수
	@Override
	public int memberSearchCnt(MemberPagingVO paging) throws Exception {
		return session.selectOne("managerMapper.memberSearchCnt", paging);
	}
	
	//회원 상세정보
	@Override
	public MemberVO memberDetail(String mid) throws Exception {
		return session.selectOne("managerMapper.memberDetail", mid);
	}
	
	//회원 정보수정
	@Override
	public void memberDetailUpdate(MemberVO upt) throws Exception {
		session.update("managerMapper.memberDetailUpdate", upt);
	}
	
	//펀딩신청 리스트
	@Override
	public List<ApplyViewVO> applyList(ApplyPagingVO paging) throws Exception {
		return session.selectList("managerMapper.applyList", paging);
	}
	
	//펀딩신청 상세정보
	@Override
	public ApplyViewVO applyDetail(int fid) throws Exception {
		return session.selectOne("managerMapper.applyDetail", fid);
	}
	
	//펀딩신청 이미지
	@Override
	public List<String> applyImage(int fid) throws Exception {
		return session.selectList("managerMapper.applyImage", fid);
	}
	
	//펀딩신청 삭제
	@Override
	public void applyDel(int fid) throws Exception {
		session.delete("managerMapper.applyDel", fid);
	}
	
	//펀딩신청 이미지 삭제
	@Override
	public void applyImageDel(int fid) throws Exception {
		session.delete("managerMapper.applyImageDel", fid);
	}
	
	//펀딩신청 승인
	@Override
	public void fundingIns(FundingInsVO funding) throws Exception {
		session.insert("managerMapper.fundingIns", funding);
	}
	
	//펀딩신청 승인시 order데이터 삽입
	@Override
	public void orderIns(HashMap<String, Object> map) throws Exception {
		session.insert("managerMapper.orderIns", map);
	}
	
	//판매자로 권한변경
	@Override
	public void sellerUpt(String mid) throws Exception {
		session.update("managerMapper.sellerUpt", mid);
	}
	
	//구매신청 총 게시물수
	public int purchaseCnt() throws Exception {
		return session.selectOne("managerMapper.purchaseCnt");
	}

	//구매신청 리스트
	@Override
	public List<PurchaseVO> purchaseList(ApplyPagingVO paging) throws Exception {
		return session.selectList("managerMapper.purchaseList", paging);
	}
	
	//구매신청 상세정보
	@Override
	public FundingExpVO purchaseDetail(int fid) throws Exception {
		return session.selectOne("managerMapper.purchaseDetail", fid);
	}
	
	//구매신청 삭제
	@Override
	public void purchaseDel(int fid) throws Exception {
		session.delete("managerMapper.purchaseDel", fid);
	}
	
	//펀딩구매 회원 삭제
	@Override
	public void orderDel(int fid) throws Exception {
		session.delete("managerMapper.orderDel", fid);
	}
	
	//펀딩한 회원리스트
	@Override
	public List<OrderVO> orderList(int fid) throws Exception {
		return session.selectList("managerMapper.orderList", fid);
	}
	
	//회원 포인트 환불
	@Override
	public void pointUpt(OrderVO order) throws Exception {
		session.update("managerMapper.pointUpt", order);
	}
	
	//펀딩한 회원 이메일
	@Override
	public List<String> orderEmail(int fid) throws Exception {
		return session.selectList("managerMapper.orderEmail", fid);
	}
	
	//펀딩 이름
	@Override
	public String fundingName(int fid) throws Exception {
		return session.selectOne("managerMapper.fundingName", fid);
	}
	
	//모든 회원의 이메일
	@Override
	public List<String> memberEmail() throws Exception {
		return session.selectList("managerMapper.memberEmail");
	}
	
	//판매자 이메일
	@Override
	public List<String> sellerEmail() throws Exception {
		return session.selectList("managerMapper.sellerEmail");
	}
}
