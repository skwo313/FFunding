package com.ffunding.web.service;

import java.util.List;


import com.ffunding.web.vo.MailVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;

public interface ManagerService {
	//메일전송
	public String sendMail(MailVO mail) throws Exception;
	
	//회원 리스트
	public List<MemberVO> memberList(MemberPagingVO paging) throws Exception;
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
	
}
