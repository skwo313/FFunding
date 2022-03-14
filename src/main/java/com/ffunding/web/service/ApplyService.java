package com.ffunding.web.service;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ffunding.web.vo.ApplyVO;

public interface ApplyService {

	// 게시글 작성
	public void write(ApplyVO applyVO, MultipartHttpServletRequest mpRequest) throws Exception;
}
