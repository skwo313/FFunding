package com.ffunding.web.controller;


import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ffunding.web.service.ManagerService;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;


@RequestMapping("manager")
@Controller
public class ManagerController {
	
	@Autowired
	private ManagerService service;
	
	//http://localhost:8000/ffunding/manager/dashboard
	//관리자 대시보드(메인페이지)
	@GetMapping("dashboard")
	public String dashboard(Model d) throws Exception {
		d.addAttribute("userTot", service.memberCnt());
		d.addAttribute("active", "dashboard");
		return "manager/dashboard.m";
	}
	
	//관리자 대시보드 json데이터
	@PostMapping("dashboard/data")
	public String dashboarddata(HashMap<String, Integer> data, Model d) throws Exception {
		data.put("userTot", service.memberCnt());
		data.put("generalCnt", service.generalCnt());
		data.put("sellerCnt", service.sellerCnt());
		return "jsonView";
	}
	
	//회원리스트 페이지
	@RequestMapping("member")
	public String member(MemberPagingVO paging, Model d) throws Exception {
		d.addAttribute("memberList", service.memberList(paging));
		d.addAttribute("active", "member");
		return "manager/member.m";
	}
	
	//회원 상세정보 페이지
	@GetMapping("member/detail")
	public String memberDetail(@RequestParam(required=false, value="msg") String msg, String mid, Model d) throws Exception {
		d.addAttribute("detail", service.memberDetail(mid));
		d.addAttribute("active", "member");
		return "manager/memberdetail.m";
	}
	
	//회원 정보수정
	@PostMapping("member/detail/update")
	public String memberDetailUpdate(MemberVO upt, RedirectAttributes redirect) throws Exception {
		service.memberDetailUpdate(upt);
		redirect.addAttribute("msg", "Membership information has been modified.");
		return "redirect:/manager/member/detail?mid="+upt.getMid();
	}
	
	//펀딩승인 페이지
	@GetMapping("fundingapproval")
	public String fundingApproval(Model d) {
		//카테고리 active 처리
		d.addAttribute("active", "fundingapproval");
		return "manager/fundingapproval.m";
	}
	

}
