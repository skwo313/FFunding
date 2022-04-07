package com.ffunding.web.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ffunding.web.service.MypageService;
import com.ffunding.web.vo.MemberVO;

@Controller
@RequestMapping("/mypage/*")
@SessionAttributes("member")
public class MypageController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MypageService service;
	
	@ModelAttribute("member")
	public MemberVO getMember() {
		return new MemberVO();
	}
	
	/* 마이페이지 뷰 */
	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String mypageView(@ModelAttribute("member") MemberVO session, Model model) throws Exception {
		logger.info("MypageView");
		
		Map<String, String> info = service.getInfo(session);
		System.out.println(info);
		model.addAttribute("info", info);
		
		List<Map<String, String>> fundingList = service.fundingList(session);
		System.out.println(fundingList);
		model.addAttribute("fundingList", fundingList);
		
		return "mypage/main.page";
	}
	
	/* 회원정보 확인 */
	@RequestMapping(value = "userConfirm", method = RequestMethod.GET)
	public String userCk(@RequestParam(value = "pass", required = false) String pass, Model model, 
						 @ModelAttribute("member") MemberVO check) {
		logger.info("UserConfirm");
		
		System.out.println(pass + check.getMpw());
		boolean checkPw = false;
		if(pass != null) {
			checkPw = BCrypt.checkpw(pass, check.getMpw());
		}
		
		if( pass == null ) {
			return "mypage/userCheck.page";
		} else if( checkPw ) {;
			
			return "redirect:userModify";
		} else {
			model.addAttribute("loginMsg", "현재 비밀번호가 일치하지 않습니다.");
			return "mypage/userCheck.page";
		}
	}
	
	/* 회원정보 수정 뷰 */
	@RequestMapping(value = "userModify", method = RequestMethod.GET)
	public String userModifyFrm() throws Exception {
		logger.info("UserModifyView");
		
		return "mypage/userModify.page";
	}
	
	/* 비밀번호 변경 */
	@RequestMapping(value = "userModify", method = RequestMethod.POST)
	@ResponseBody
	public String userModify(@RequestBody Map<String, String> update,
							@ModelAttribute("member") MemberVO check,
							SessionStatus status) throws Exception {
		logger.info("update"+update.values());
		boolean checkPw = false;
		String paraPW = update.get("currentmpw");
		if(paraPW != null) {
			checkPw = BCrypt.checkpw(paraPW, check.getMpw());
		}
		if(!checkPw) {
			return "0";
		}
		
		String hashedPw = BCrypt.hashpw(update.get("mpw"), BCrypt.gensalt());
		update.put("mpw", hashedPw);
		
		service.updatePW(update);
		
		// 세션 종료
		status.setComplete();
		
		return "/member/login";
	}
	
	/* 주소 검색 api 호출 */
	@RequestMapping(value = "popup", 
				method = { RequestMethod.GET, RequestMethod.POST})
	public String popup() {
		logger.info("addrSch");
		
		return "mypage/jusoPopup";
	}
	
	/* 배송지 변경 */
	@RequestMapping(value = "updateAddr", method = RequestMethod.POST)
	@ResponseBody
	public String updateAddr(@RequestBody Map<String, String> update) throws Exception {
		logger.info("updateAddr"+update.values());
		
		service.updateAddr(update);
		
		return "main";
	}
	
	/* 펀딩 내역 */
	@RequestMapping(value = "fundingList", method = RequestMethod.GET)
	public String fundingList(@ModelAttribute("member") MemberVO fl,
								Model model) throws Exception {
		logger.info("FundingListView");
		
		model.addAttribute("fundingList", service.getFunding(fl));
		return "mypage/fundingList.page";
	}
	
	/* 후원 내역 */
	@RequestMapping(value = "donation", method = RequestMethod.GET)
	public String donationList(@ModelAttribute("member") MemberVO dl,
								Model model) throws Exception {
		logger.info("DonationList");
		
		System.out.println(service.getDonation(dl));
		model.addAttribute("donaList", service.getDonation(dl));
		return "mypage/donation.page";
	}
	
	/* 포인트 뷰*/
	@RequestMapping(value = "point", method = RequestMethod.GET)
	public String pointView(@ModelAttribute("member") MemberVO id, Model model) throws Exception {
		logger.info("PointView");
		
		model.addAttribute("point", service.getPoint(id));
		return "mypage/pay.page";
	}
	
	/* 결제 완료 정보 받기 */
	@RequestMapping(value = "endPoint", method = RequestMethod.POST)
	public void endPoint(@RequestBody Map<String, String> payInfo) throws Exception {
		logger.info("Endpoint"+payInfo.values());
		
		service.pointCharge(payInfo);
		logger.info("PayEnd");
	}
	
}
