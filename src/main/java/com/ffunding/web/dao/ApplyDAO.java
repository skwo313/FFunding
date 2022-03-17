package com.ffunding.web.dao;

import java.util.List;
import java.util.Map;

import com.ffunding.web.vo.ApplyVO;
import com.ffunding.web.vo.Criteria;
import com.ffunding.web.vo.SearchCriteria;

public interface ApplyDAO {

	// 게시글 작성
	public void write(ApplyVO applyVO) throws Exception;
	
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
	
	// 첨부파일 업로드
	public void insertFile(Map<String, Object> map) throws Exception;

}
