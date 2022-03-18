package com.ffunding.web.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ffunding.web.vo.ApplyVO;
import com.ffunding.web.vo.Criteria;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.SearchCriteria;

public interface ApplyService {

	// 게시글 작성
	public void write(ApplyVO applyVO, MultipartHttpServletRequest mpRequest) throws Exception;
	
	// 게시물 목록 조회
	public List<ApplyVO> list(SearchCriteria scri) throws Exception;
	
	// 게시물 총 갯수
	public int listCount(SearchCriteria scri) throws Exception;
	
	// 게시물 조회
	public ApplyVO read(int fid) throws Exception;
	
	// 게시물 수정
	public void update(ApplyVO applyVO) throws Exception;
	
	// 게시물 삭제
	public void delete(int fid) throws Exception;
	
	// 첨부파일 조회
	public List<Map<String, Object>> selectFileList(int fid) throws Exception;
	
	// 첨부파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
}
