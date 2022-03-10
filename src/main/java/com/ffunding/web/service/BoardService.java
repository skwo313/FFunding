package com.ffunding.web.service;

import com.ffunding.web.vo.BoardVO;

public interface BoardService {

	// 게시글 작성
	public void write(BoardVO boardVO) throws Exception;
	
}