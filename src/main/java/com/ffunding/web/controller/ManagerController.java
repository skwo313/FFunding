package com.ffunding.web.controller;


import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.ffunding.web.vo.FundingInsVO;
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
	@GetMapping("dashboard")
	public String dashboard(Model d) throws Exception {
		d.addAttribute("userCnt", service.memberCnt());
		d.addAttribute("applyCnt", service.applyCnt());
		d.addAttribute("expectCnt", service.expectCnt());
		d.addAttribute("progressCnt", service.progressCnt());
		d.addAttribute("active", "dashboard");
		return "manager/dashboard.m";
	}
	
	//관리자 대시보드 json데이터
	@PostMapping("dashboard/data")
	public String dashboardData(HashMap<String, Integer> data, Model d) throws Exception {
		//Member
		data.put("generalCnt", service.generalCnt());
		data.put("sellerCnt", service.sellerCnt());
		//Category
		data.put("tech", service.categoryCnt("테크·가전"));
		data.put("fashion", service.categoryCnt("패션·잡화"));
		data.put("beauty", service.categoryCnt("뷰티"));
		data.put("food", service.categoryCnt("푸드"));
		data.put("home", service.categoryCnt("홈·리빙"));
		data.put("travel", service.categoryCnt("여행·레저"));
		data.put("sport", service.categoryCnt("스포츠·모빌리티"));
		data.put("character", service.categoryCnt("캐릭터·굿즈"));
		data.put("game", service.categoryCnt("게임·취미"));
		
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
	@GetMapping("member/detail")
	public String memberDetail(@RequestParam(required=false, value="msg") String msg, String mid, Model d) throws Exception {
		d.addAttribute("detail", service.memberDetail(mid));
		d.addAttribute("active", "member");
		return "manager/memberDetail.m";
	}
	
	//회원 정보수정
	@PostMapping("member/detail/update")
	public String memberDetailUpdate(MemberVO upt, RedirectAttributes redirect) throws Exception {
		service.memberDetailUpdate(upt);
		redirect.addAttribute("msg", "Membership information has been modified.");
		return "redirect:/manager/member/detail?mid="+upt.getMid();
	}
	
	//펀딩승인 페이지
	@GetMapping("fundingApproval")
	public String fundingApproval(@RequestParam(required=false, value="delmsg") String delmsg, @RequestParam(required=false, value="insmsg") String insmsg, ApplyPagingVO paging, Model d) throws Exception {
		d.addAttribute("applyList", service.applyList(paging));
		d.addAttribute("active", "fundingApproval");
		return "manager/fundingApproval.m";
	}
	
	//펀딩승인 상세정보 페이지
	@GetMapping("fundingApproval/detail")
	public String fundingApprovalDetail(int fid, Model d) throws Exception {
		d.addAttribute("detail", service.applyDetail(fid));
		d.addAttribute("active", "fundingApproval");
		return "manager/fundingApprovalDetail.m";
	}
	
	//펀딩신청 삭제
	@PostMapping("fundingApproval/detail/delete")
	public String fundingDelete(int fid, RedirectAttributes redirect) throws Exception {
		service.applyDel(fid);
		redirect.addAttribute("delmsg", "This funding has been deleted.");
		return "redirect:/manager/fundingApproval";
	}
	
	//펀딩신청 승인
	@PostMapping("fundingApproval/detail/insert")
	public String fundingInsert(FundingInsVO funding, HttpServletRequest request, RedirectAttributes redirect) throws Exception {
		//현재 세션 가져오기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("member");
		//adming컬럼에 해당 펀딩신청을 승인한 관리자 id 넣기
		funding.setAdmin(member.getMid());
		service.fundingIns(funding);
		redirect.addAttribute("insmsg", "The funding has been approved.");
		return "redirect:/manager/fundingApproval";
	}
	
	//구매신청 페이지
	@GetMapping("purchaseApproval")
	public String purchaseApproval(@RequestParam(required=false, value="delmsg") String delmsg, @RequestParam(required=false, value="insmsg") String insmsg, ApplyPagingVO paging, Model d) throws Exception {
		d.addAttribute("purchaseList", service.purchaseList(paging));
		d.addAttribute("active", "purchaseApproval");
		return "manager/purchaseApproval.m";
	}
	
	//구매신청 승인
	@PostMapping("purchaseApproval/insert")
	public String purchaseApprovalIns(int fid, RedirectAttributes redirect) throws Exception {
		service.purchaseIns(fid);
		redirect.addAttribute("insmsg", "The funding has been approved.");
		return "redirect:/manager/purchaseApproval";
	}
	
	//구매신청 삭제
	@PostMapping("purchaseApproval/delete")
	public String purchaseApprovalDel(int fid, RedirectAttributes redirect) throws Exception {
		service.purchaseDel(fid);
		redirect.addAttribute("delmsg", "This funding has been deleted.");
		return "redirect:/manager/purchaseApproval";
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
