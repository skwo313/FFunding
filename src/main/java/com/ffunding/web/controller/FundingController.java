package com.ffunding.web.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ffunding.web.service.FundingService;

@Controller
@RequestMapping("/funding")
public class FundingController {
	@Inject
	FundingService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@GetMapping
	public String funding(Model model) throws Exception {
		logger.info("list");
		model.addAttribute("list", service.list());
		
		return "funding/fundingList.page";
	}

	@GetMapping("/detail")
	public String fundingdetail(Model model) throws Exception {
		return "funding/fundingDetail.page";
	}

	@GetMapping("/detail/order")
	public String fundingorder(Model model) throws Exception {
		return "funding/fundingOrder.page";
	}
}