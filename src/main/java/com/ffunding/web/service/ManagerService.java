package com.ffunding.web.service;

import java.util.List;

import com.ffunding.web.vo.MMemberPagingVO;
import com.ffunding.web.vo.MMemberVO;

public interface ManagerService {
	//회원 리스트
	public List<MMemberVO> memberList(MMemberPagingVO paging) throws Exception;
	//총 회원수
	public int memberCnt() throws Exception;
	//일반회원수
	public int generalCnt() throws Exception;
	//판매자수
	public int sellerCnt() throws Exception;
	//회원 상세정보
	public MMemberVO memberDetail(String mid) throws Exception;
	//회원 정보수정
	public void memberDetailUpdate(MMemberVO upt) throws Exception;
	
}
