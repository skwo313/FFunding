package com.ffunding.web.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ffunding.web.dao.BoardDAO;
import com.ffunding.web.service.BoardService;
import com.ffunding.web.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	// 게시글 작성
	@Override
	public void write(BoardVO boardVO) throws Exception {
		dao.write(boardVO);
	}

}