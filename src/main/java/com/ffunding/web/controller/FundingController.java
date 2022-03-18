package com.ffunding.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/funding")
public class FundingController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@GetMapping
	public String funding(HttpServletRequest request, @Param("sort") String sort, @RequestParam(value="keyword", defaultValue="1") String nowPage, Model d) throws Exception {
		return "funding/fundingList.page";
	}
	@GetMapping("/detail")
	public String fundingdetail(HttpServletRequest request, @Param("sort") String sort, @RequestParam(value="keyword", defaultValue="1") String nowPage, Model d) throws Exception {
		return "funding/fundingDetail.page";
	}
	@GetMapping("/detail/order")
	public String fundingorder() {
		return "funding/fundingOrder.page";
	}
}