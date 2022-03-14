package com.ffunding.web.dao;

import java.util.Map;

import com.ffunding.web.vo.ApplyVO;

public interface ApplyDAO {

	// 게시글 작성
	public void write(ApplyVO applyVO) throws Exception;
	
	// 첨부파일 업로드
	public void insertFile(Map<String, Object> map) throws Exception;
}
