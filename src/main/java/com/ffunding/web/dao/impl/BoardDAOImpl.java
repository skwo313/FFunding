package com.ffunding.web.dao.impl;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.BoardDAO;
import com.ffunding.web.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	// 게시글 작성
	@Override
	public void write(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMapper.insert", boardVO);
		
	}

}