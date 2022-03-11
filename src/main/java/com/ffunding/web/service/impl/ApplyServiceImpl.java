package com.ffunding.web.service.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ffunding.web.dao.ApplyDAO;
import com.ffunding.web.service.ApplyService;
import com.ffunding.web.vo.ApplyVO;

@Service
public class ApplyServiceImpl implements ApplyService {

	@Inject
	private ApplyDAO dao;
	
	// 게시글 작성
	@Override
	public void write(ApplyVO applyVO) throws Exception {
		dao.write(applyVO);
	}
}
