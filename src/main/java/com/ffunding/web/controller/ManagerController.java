package com.ffunding.web.controller;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ffunding.web.dao.VisitDAO;
import com.ffunding.web.service.ManagerService;
import com.ffunding.web.vo.ApplyPagingVO;
import com.ffunding.web.vo.CalendarVO;
import com.ffunding.web.vo.FundingInsVO;
import com.ffunding.web.vo.MailVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.VisitDateVO;


@RequestMapping("manager")
@Controller
public class ManagerController {
	
	@Autowired
	private ManagerService service;
	
	@Autowired
	private VisitDAO dao;
	
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
		//패스워드 암호화
		upt.setMpw(BCrypt.hashpw(upt.getMpw(), BCrypt.gensalt()));
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
	
	//일정관리 페이지
	@GetMapping("calendar")
	public String calendar(Model d) throws Exception {
		d.addAttribute("active", "calendar");
		return "manager/calendar.m";
	}
	
	//일정 리스트
	@PostMapping("calendar/list")
	public String calendarList(Model d) throws Exception {
		d.addAttribute("calendarList", service.calendarList());
		return "jsonView";
	}
	
	//일정 생성
	@PostMapping("calendar/insert")
	public String calendarIns(CalendarVO calendar) throws Exception {
		service.calendarIns(calendar);
		return "redirect:/manager/calendar";
	}
	
	//일정 수정
	@PostMapping("calendar/update")
	public String calendarUpt(CalendarVO calendar) throws Exception {
		service.calendarUpt(calendar);
		return "redirect:/manager/calendar";
	}
	
	//일정 삭제
	@PostMapping("calendar/delete")
	public String calendarDel(int id) throws Exception {
		service.calendarDel(id);
		return "redirect:/manager/calendar";
	}
	
	
	//관리자 대시보드 x축,y축 데이터
			@PostMapping("dashboard/chartx")
			public String dashboardChartx(Model d) throws Exception {
				String c_date=service.chartXList();
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				Date date = df.parse(c_date);
				Calendar cal = Calendar.getInstance();
				String chtime;
				List<String> list = new ArrayList<>();
				for(int i=6;i>=0;i--) {
					cal.setTime(date);
					cal.add(Calendar.DATE, -i);
					chtime=df.format(cal.getTime());
					list.add(chtime);
				}
				Collections.sort(list);
				 
				VisitDateVO vo = new VisitDateVO();
				String d1 = list.get(0);
				String d2 = list.get(1);
				String d3 = list.get(2);
				String d4 = list.get(3);
				String d5 = list.get(4);
				String d6 = list.get(5);
				String d7 = list.get(6);
				vo.setDate1(d1);
				vo.setDate2(d2);
				vo.setDate3(d3);
				vo.setDate4(d4);
				vo.setDate5(d5);
				vo.setDate6(d6);
				vo.setDate7(d7);
				dao.updateDate(vo);
				List<Integer> ylist = new ArrayList<>();
				ylist.add(service.date1Cnt());
				ylist.add(service.date2Cnt());
				ylist.add(service.date3Cnt());
				ylist.add(service.date4Cnt());
				ylist.add(service.date5Cnt());
				ylist.add(service.date6Cnt());
				ylist.add(service.date7Cnt());
				System.out.println("test: "+list);
				System.out.println("test2: "+ylist);
				d.addAttribute("xdata", list);
				d.addAttribute("ydata", ylist);
				return "jsonView";
			}
}
