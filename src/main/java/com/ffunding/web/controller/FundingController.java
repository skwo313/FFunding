package com.ffunding.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FundingController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@GetMapping("/funding")
	public String funding(HttpServletRequest request, @Param("sort") String sort, @RequestParam(value="keyword", defaultValue="1") String nowPage, Model d) throws Exception {
		return "funding/fundingList.page";
	}
}