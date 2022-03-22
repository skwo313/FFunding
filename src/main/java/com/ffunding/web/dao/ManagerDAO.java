package com.ffunding.web.dao;

import java.util.List;

import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;

public interface ManagerDAO {
	//관리자
	public List<String> managerList() throws Exception;
	//회원 리스트
	public List<MemberVO> memberList(MemberPagingVO paging) throws Exception;
	//회원 검색 및 페이징
	public int memberSearchCnt(MemberPagingVO paging) throws Exception;
	//총 회원수
	public int memberCnt() throws Exception;
	//일반회원수
	public int generalCnt() throws Exception;
	//판매자수
	public int sellerCnt() throws Exception;
	//회원 상세정보
	public MemberVO memberDetail(String mid) throws Exception;
	//회원 정보수정
	public void memberDetailUpdate(MemberVO upt) throws Exception;
	//모든 회원의 이메일
	public List<String> memberEmail() throws Exception;
	//판매자 이메일
	public List<String> sellerEmail() throws Exception;
}
