package com.ffunding.web.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ffunding.web.service.FundingService;
import com.ffunding.web.service.ManagerService;
import com.ffunding.web.vo.FundingCriteria;
import com.ffunding.web.vo.FundingPageMaker;
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
			@RequestParam(value = "sort", required = false) String sort, FundingCriteria cri, Model model)
			throws Exception {
		logger.info("list");
		request.setCharacterEncoding("UTF-8");

		HashMap<String, Object> hashMap = new HashMap<>();
		hashMap.put("category", category);
		model.addAttribute("list", service.list(cri));
		FundingPageMaker pageMaker = new FundingPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount(hashMap));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("category", category);
		model.addAttribute("sort", sort);
		return "funding/fundingList.page";
	}

	// 제품 상세 페이지
	@GetMapping("/detail")
	public String detailview(FundingVO fundingVO, Model model) throws Exception {
		logger.info("detailview");

		model.addAttribute("detail", service.viewDetail(fundingVO.getFid()));

		return "funding/fundingDetail.page";
	}

	// 제품 판매 정보 pdf
	@RequestMapping(value = "/detail/pdf", method = RequestMethod.GET)
	public String pdfview(FundingVO fundingVO, Model d) throws Exception {
		d.addAttribute("detail", service.viewDetail(fundingVO.getFid()));

		return "funding/fundingPdf.page";
	}

	@RequestMapping("/pdf/down")
	public ModelAndView pdf(HttpServletRequest request) throws Exception {
		String fids = request.getParameter("fid");
		System.out.println(fids);
		int fid = Integer.parseInt(fids);
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		ModelAndView mav = new ModelAndView();
		Map<String, String> map = new HashMap<String, String>();
		FundingVO vo = service.viewDetail(fid);
		String startDate = sdFormat.format(vo.getFstartdate());
		String endDate = sdFormat.format(vo.getFenddate());
		map.put("remaining period", vo.getRemain() + "일");
		map.put("achievement rate", Integer.toString(vo.getGoal()));
		map.put("Funding amount", Integer.toString(vo.getPrice()));
		map.put("Participants", (vo.getSell()-1) + "명");
		map.put("price", Integer.toString(vo.getFprice()));
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		mav.addObject("map", map);
		mav.setViewName("pdfDownView");
		return mav;
	}


	// 주문 페이지
	@GetMapping("/detail/order")
	public String fundingorder(FundingVO fundingVO, Model d, HttpSession session) throws Exception {
		d.addAttribute("detail", service.viewDetail(fundingVO.getFid()));
		d.addAttribute("mid", session.getAttribute("member"));
		return "funding/fundingOrder.page";
	}

	// 주문 완료
	@RequestMapping(value = "detail/order", method = RequestMethod.POST)
	public String orderProduct(@RequestParam int fo_price, @RequestParam String mid, OrderVO vo) throws Exception {
		MemberVO membervo = service2.memberDetail(mid);
		int point = membervo.getPoint() - fo_price;
		membervo.setPoint(point);
		service.orderProduct(vo);
		service.pointDown(membervo);

		return "redirect:/";
	}
}