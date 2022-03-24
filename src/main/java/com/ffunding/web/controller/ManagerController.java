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
import com.ffunding.web.vo.ApplyPagingVO;
import com.ffunding.web.vo.FundingExpVO;
import com.ffunding.web.vo.MailVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;


@RequestMapping("manager")
@Controller
public class ManagerController {
	
	@Autowired
	private ManagerService service;
	
	//http://localhost:8000/ffunding/manager/dashboard
	//관리자 대시보드(메인페이지)
	//@LoginType
	@GetMapping("dashboard")
	public String dashboard(Model d) throws Exception {
		d.addAttribute("userTot", service.memberCnt());
		d.addAttribute("applyTot", service.applyCnt());
		d.addAttribute("active", "dashboard");
		return "manager/dashboard.m";
	}
	
	//관리자 대시보드 json데이터
	@PostMapping("dashboard/data")
	public String dashboardData(HashMap<String, Integer> data, Model d) throws Exception {
		data.put("userTot", service.memberCnt());
		data.put("generalCnt", service.generalCnt());
		data.put("sellerCnt", service.sellerCnt());
		return "jsonView";
	}

	//회원리스트 페이지
	@GetMapping("member")
	public String member(Model d) throws Exception {
		d.addAttribute("active", "member");
		return "manager/member.m";
	}
	
	//회원 json데이터
	@PostMapping("member/data")
	public String memberData(MemberPagingVO paging, Model d) throws Exception {
		d.addAttribute("memberList", service.memberList(paging));
		return "jsonView";
	}
	
	//회원 상세정보 페이지
	@RequestMapping("member/detail")
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
	public String fundingApproval(@RequestParam(required=false, value="delmsg") String delmsg, ApplyPagingVO paging, Model d) throws Exception {
		d.addAttribute("applyList", service.applyList(paging));
		d.addAttribute("active", "fundingapproval");
		return "manager/fundingapproval.m";
	}
	
	//펀딩승인 상세정보 페이지
	@GetMapping("fundingapproval/detail")
	public String fundingApprovalDetail(int fid, Model d) throws Exception {
		d.addAttribute("detail", service.applyDetail(fid));
		d.addAttribute("active", "fundingapproval");
		return "manager/fundingapprovaldetail.m";
	}
	
	//펀딩신청 삭제
	@PostMapping("fundingapproval/detail/delete")
	public String fundingDelete(int fid, RedirectAttributes redirect) throws Exception {
		service.applyDel(fid);
		redirect.addAttribute("delmsg", "This funding has been deleted.");
		return "redirect:/manager/fundingapproval";
	}
	
	//펀딩신청 승인
	@PostMapping("fundingapproval/detail/insert")
	public String fundingInsert(FundingExpVO funding, RedirectAttributes redirect) throws Exception {
		service.fundingIns(funding);
		redirect.addAttribute("insmsg", "The funding has been approved.");
		return "redirect:/manager/fundingapproval";
	}
		
	//메일 페이지
	@GetMapping("mail")
	public String mail(@RequestParam(required=false, value="msg") String msg, Model d) {
		d.addAttribute("active", "mail");
		return "manager/mail.m";
	}
	
	//메일 전송
	@PostMapping("mail/send")
	public String mailSend(MailVO mail, RedirectAttributes redirect) throws Exception {
		redirect.addAttribute("msg", service.sendMail(mail));
		return "redirect:/manager/mail";
	}
}
