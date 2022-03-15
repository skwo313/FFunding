package com.ffunding.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ffunding.web.service.MemberService;
import com.ffunding.web.vo.MemberVO;

@Controller
@SessionAttributes("member")
@RequestMapping("/member/*")
public class MemberController {
	
	@Inject
	private MemberService service;
	
	@ModelAttribute("member")
	public MemberVO getMember() {
		return new MemberVO();
	}
	
	/* 로그인 폼 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		return "member/login.page";
	}
	
	/* 로그인 */
	@RequestMapping(value = "loginCk", method = RequestMethod.POST)
	public String loginCk(@ModelAttribute("member") MemberVO ck, 
							Model model) throws Exception {
		
		MemberVO member = service.loginCheck(ck);
		if ( member != null) {
			model.addAttribute("member", member);
			return "redirect:/";
		} else {
			model.addAttribute("loginMsg", "error");
			return "member/login.page";
		}
	}
	
	/* 로그아웃 */
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(SessionStatus status) {
		// boolean is_insert_success = false;
		
		// 세션 종료
		status.setComplete();
		
		/*
		if (status.isComplete() == true) {
			System.out.println("Session remove success");
			
			is_insert_success = true;
		}
		
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		retVal.put("ckeck", is_insert_success);
		*/
		
		return "redirect:/";
	}
}
