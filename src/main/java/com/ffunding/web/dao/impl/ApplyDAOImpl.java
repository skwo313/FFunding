package com.ffunding.web.dao.impl;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.ApplyDAO;
import com.ffunding.web.vo.ApplyVO;

@Repository
public class ApplyDAOImpl implements ApplyDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	// 게시글 작성
	@Override
	public void write(ApplyVO applyVO) throws Exception {
		sqlSession.insert("applyMapper.insert", applyVO);
	}
}
