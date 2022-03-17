package com.ffunding.web.dao.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.ApplyDAO;
import com.ffunding.web.vo.ApplyVO;
import com.ffunding.web.vo.Criteria;

@Repository
public class ApplyDAOImpl implements ApplyDAO {

	@Inject
	private SqlSession sqlSession;

	// 게시글 작성
	@Override
	public void write(ApplyVO applyVO) throws Exception {
		sqlSession.insert("applyMapper.insert", applyVO);
	}

	// 게시물 목록 조회
	@Override
	public List<ApplyVO> list() throws Exception {
	
		return sqlSession.selectList("applyMapper.list");

	}
	
	// 게시물 조회
	@Override
	public ApplyVO read(int fid) throws Exception {
			
		return sqlSession.selectOne("applyMapper.read", fid);
	}

	// 게시물 수정
	@Override
	public void update(ApplyVO applyVO) throws Exception {
		
		sqlSession.update("applyMapper.update", applyVO);
	}

	// 게시물 삭제
	@Override
	public void delete(int fid) throws Exception {
		
		sqlSession.delete("applyMapper.delete", fid);
	}
	
	// 첨부파일 업로드
	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("applyMapper.insertFile", map);
	}
}
