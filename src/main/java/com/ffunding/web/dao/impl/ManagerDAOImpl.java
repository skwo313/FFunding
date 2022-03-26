package com.ffunding.web.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.ManagerDAO;
import com.ffunding.web.vo.ApplyPagingVO;
import com.ffunding.web.vo.ApplyViewVO;
import com.ffunding.web.vo.FundingExpVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;

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
	public void fundingIns(FundingExpVO funding) throws Exception {
		session.insert("managerMapper.fundingIns", funding);
	}
	
	//판매자로 권한변경
	@Override
	public void sellerUpt(String mid) throws Exception {
		session.update("managerMapper.sellerUpt", mid);
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
