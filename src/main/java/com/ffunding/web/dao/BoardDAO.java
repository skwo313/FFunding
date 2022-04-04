package com.ffunding.web.dao;

import java.util.List;
import java.util.Map;

import com.ffunding.web.vo.BoardVO;
import com.ffunding.web.vo.Criteria;
import com.ffunding.web.vo.SearchCriteria;

public interface BoardDAO {
	
	// 공지사항 DAO

	// 게시글 작성
	public void write(BoardVO boardVO) throws Exception;
	
	// 게시물 목록 조회
	public List<BoardVO> list(SearchCriteria scri) throws Exception;
	
	// 게시물 총 갯수
	public int listCount(SearchCriteria scri) throws Exception;
	
	// 게시물 조회
	public BoardVO read(int bno) throws Exception;
	
	// 게시물 수정
	public void update(BoardVO boardVO) throws Exception;
	
	// 게시물 삭제
	public void delete(int bno) throws Exception;
	
	// 첨부파일 추가
	public void insertFile(Map<String, Object> map) throws Exception;
	
    // 첨부파일 조회
	public List<Map<String, Object>> selectFileList(int bno) throws Exception;
	
	// 첨부파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	
	// 첨부파일 수정
	public void updateFile(Map<String, Object> map) throws Exception;
	
	// 게시판 조회수
	public void boardHit(int bno) throws Exception;
}