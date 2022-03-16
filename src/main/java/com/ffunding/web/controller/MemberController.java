package com.ffunding.web.controller;

import java.io.IOException;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ffunding.web.service.MemberService;
import com.ffunding.web.vo.MemberVO;

@Controller
@SessionAttributes("member")
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	private MemberService service;
	
	@ModelAttribute("member")
	public MemberVO getMember() {
		return new MemberVO();
	}
	
	/* 로그인 폼 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() {
		logger.info("loginForm");
		
		return "member/login.page";
	}
	
	/* 로그인 */
	@RequestMapping(value = "loginCk", method = RequestMethod.POST)
	public @ResponseBody Object loginCk(@RequestBody Map<String, String> loginMap,
										@ModelAttribute("member") MemberVO ck,
										Model model) throws Exception {
		logger.info("check" + loginMap.values());
		
		try {
			MemberVO member = service.loginCheck(loginMap);
			
			if (member != null) {
				model.addAttribute("member", member);
				
				return member;
			} else {
				return 0;
			}
		} catch (IOException e) {
			return 9;
		}
		
		
	}
	
	/* 로그아웃 */
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(SessionStatus status) {
		logger.info("logout");
		
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
