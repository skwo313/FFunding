package com.ffunding.web.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ffunding.web.service.ApplyService;
import com.ffunding.web.vo.ApplyVO;

@Controller
@RequestMapping("/apply/*")
public class ApplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	ApplyService service;

	// 게시판 글 작성 화면
	@RequestMapping(value = "/apply/writeView", method = RequestMethod.GET)
	public String writeView() throws Exception {
		logger.info("writeView");
		
		return "apply/writeView.page";
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/apply/write", method = RequestMethod.POST)
	public String write(ApplyVO applyVO, MultipartHttpServletRequest mpRequest) throws Exception{
		logger.info("write");
		
		service.write(applyVO, mpRequest);
		
		return "redirect:/";
	}	
	
}
