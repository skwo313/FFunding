package com.ffunding.web.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ffunding.web.service.ApplyService;
import com.ffunding.web.vo.ApplyVO;
import com.ffunding.web.vo.Criteria;
import com.ffunding.web.vo.PageMaker;
import com.ffunding.web.vo.SearchCriteria;

@Controller
@RequestMapping("/apply/*")
public class ApplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(ApplyController.class);
	
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
	
	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("list");
		
		model.addAttribute("list",service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "apply/list.page";
		
	}
	
	// 게시판 조회
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(ApplyVO applyVO, Model model) throws Exception{
		logger.info("read");
		
		model.addAttribute("read", service.read(applyVO.getFid()));
		
		return "apply/readView.page";
	}
	
	// 게시판 수정뷰
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(ApplyVO applyVO, Model model) throws Exception{
		logger.info("updateView");
		
		model.addAttribute("update", service.read(applyVO.getFid()));
		
		return "apply/updateView.page";
	}
	
	// 게시판 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ApplyVO applyVO) throws Exception{
		logger.info("update");
		
		service.update(applyVO);
		
		return "redirect:/apply/list";
	}

	// 게시판 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(ApplyVO applyVO) throws Exception{
		logger.info("delete");
		
		service.delete(applyVO.getFid());
		
		return "redirect:/apply/list";
	}
}
