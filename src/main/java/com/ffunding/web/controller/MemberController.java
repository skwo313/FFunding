package com.ffunding.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ffunding.web.auth.SNSLogin;
import com.ffunding.web.auth.SnsValue;
import com.ffunding.web.dao.VisitDAO;
import com.ffunding.web.service.MemberService;
import com.ffunding.web.util.ClientInfo;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.VisitVO;

@Controller
@SessionAttributes("member")
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private ClientInfo ci;
	
	@Autowired
	private VisitDAO dao;
	@Inject
	private MemberService service;
	@Inject
	private SnsValue naverSns;
	@Inject 
	private SnsValue googleSns;
	@Autowired(required=false)
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired(required=false)
	private OAuth2Parameters googleOAuth2Parameters;
	
	
	@ModelAttribute("member")
	public MemberVO getMember() {
		return new MemberVO();
	}
	
	/* 로그인 폼 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(Model model) throws Exception {
		logger.info("loginForm");
		
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);
		
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
				String visit_ip = ci.getIpAddr();
				String visit_time = ci.getTime();
				VisitVO visitvo= new VisitVO();
				visitvo.setVisit_ip(visit_ip);
				visitvo.setVisit_time(visit_time);
				dao.insertIp(visitvo);
				return member;
			} else {
				return 0;
			}
		} catch (IOException e) {
			return 9;
		}
		
		
	}
	
	/* 로그인 api callback url 호출 */
	@RequestMapping(value = "{snsService}/callback", 
			method = { RequestMethod.GET, RequestMethod.POST})
	public String callback(@PathVariable String snsService, 
						   @RequestParam String code, Model model,
						   @ModelAttribute("member") MemberVO session,
						   HttpServletResponse response) throws Exception {
		
		logger.info("SnsLoginCallback: service={}", snsService);
		SnsValue sns = null;
		if (StringUtils.equals("naver", snsService)) {
			sns = naverSns;
		} 
		// else sns = googleSns;
			
		
		// access_token(code)을 이용하여 사용자 profile 정보 가져오기
		SNSLogin snsLogin = new SNSLogin(sns);
		MemberVO snsUser = snsLogin.getUserProfile(code);
		System.out.println("Profile>>" + snsUser);
		
		// DB 해당 유저가 존재하는지 체크
		MemberVO memberVO = service.getBySns(snsUser);
		if (memberVO == null) {
			
			service.joinBySns(snsUser);
			model.addAttribute("member", memberVO);
		} else {
			model.addAttribute("member", memberVO);
		}
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>window.opener.location.href='/ffunding';" +
					"self.close() </script>");
		out.flush();
		
		return "member/callback";
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
