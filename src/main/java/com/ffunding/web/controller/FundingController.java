package com.ffunding.web.controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ffunding.web.service.FundingService;
import com.ffunding.web.service.ManagerService;
import com.ffunding.web.vo.FundingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.OrderVO;

@Controller
@RequestMapping("/funding")
public class FundingController {
	@Inject
	FundingService service;
	@Autowired
	private ManagerService service2;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	// 펀딩하기 목록 조회
	@GetMapping
	public String funding(HttpServletRequest request,
			@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "sort", required = false) String sort, Model model) throws Exception {
		logger.info("list");
		request.setCharacterEncoding("UTF-8");

		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("category", category);
		hashMap.put("sort", sort);
		model.addAttribute("list", service.list(hashMap));
		model.addAttribute("category", category);
		return "funding/fundingList.page";
	}

	// 제품 상세 페이지
	@GetMapping("/detail")
	public String detailview(FundingVO fundingVO, Model model) throws Exception {
		logger.info("detailview");
		
		model.addAttribute("detail", service.viewDetail(fundingVO.getFid()));

		return "funding/fundingDetail.page";
	}

	// 주문 페이지
		@GetMapping("/detail/order")
		public String fundingorder(FundingVO fundingVO, Model model) throws Exception {
			model.addAttribute("detail", service.viewDetail(fundingVO.getFid()));
			return "funding/fundingOrder.page";
		}

		// 주문 완료
		@RequestMapping(value = "detail/order", method = RequestMethod.POST)
		public String orderProduct(@RequestParam int fo_price,@RequestParam String mid,OrderVO vo) throws Exception {
			MemberVO membervo = service2.memberDetail(mid);
			int point = membervo.getPoint()-fo_price;
			membervo.setPoint(point);
			service.orderProduct(vo);
			service.pointDown(membervo);
		
			return "redirect:/";
		}
}