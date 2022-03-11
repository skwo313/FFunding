package com.ffunding.web.service;

import com.ffunding.web.vo.ApplyVO;

public interface ApplyService {

	// 게시글 작성
	public void write(ApplyVO applyVO) throws Exception;
}
