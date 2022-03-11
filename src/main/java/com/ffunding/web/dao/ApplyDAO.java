package com.ffunding.web.dao;

import com.ffunding.web.vo.ApplyVO;

public interface ApplyDAO {

	// 게시글 작성
	public void write(ApplyVO applyVO) throws Exception;
}
