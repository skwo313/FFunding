package com.ffunding.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

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
	@Inject 
	private SnsValue kakaoSns;
	@Autowired(required=false)
	private LocaleResolver localeResolver;
	
	@ModelAttribute("member")
	public MemberVO getMember() {
		return new MemberVO();
	}
	
	/* 로그인 폼 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(Model model, HttpServletRequest request) throws Exception {
		logger.info("loginForm");
		
		SNSLogin naverLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", naverLogin.getAuthURL());
		
		SNSLogin googleLogin = new SNSLogin(googleSns);
		model.addAttribute("google_url", googleLogin.getAuthURL());
		
		SNSLogin kakaoLogin = new SNSLogin(kakaoSns);
		model.addAttribute("kakao_url", kakaoLogin.getAuthURL());
		
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		if (inputFlashMap != null) {
			model.addAttribute("msg",(String) inputFlashMap.get("msg"));
		}
		
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
			/* 로그인 실패시 복호화 전 null값 처리 */
			boolean checkPw = false;
			if(member != null) {
				checkPw = BCrypt.checkpw(loginMap.get("mpw"), member.getMpw());
			}
			
			if (member != null && checkPw) {
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
		} else if (StringUtils.equals("google", snsService)) {
			sns = googleSns;
		} else {
			sns = kakaoSns;
		}
		
		// access_token(code)을 이용하여 사용자 profile 정보 가져오기
		SNSLogin snsLogin = new SNSLogin(sns);
		MemberVO snsUser = null;
		if (sns == kakaoSns) {
			snsUser = snsLogin.getKakaoUserProfile(code);
		} else {
			snsUser = snsLogin.getUserProfile(code);
		}
		System.out.println("Profile>>" + snsUser);
		
		// DB 해당 유저가 존재하는지 체크
		MemberVO memberVO = service.getBySns(snsUser);
		if (memberVO == null) {
			
			service.joinBySns(snsUser);
			memberVO = service.getBySns(snsUser);
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
	public String logout(SessionStatus status) throws Exception {
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
	
	/* 회원가입 뷰 */
	@RequestMapping(value = "registerView", method = RequestMethod.GET)
	public String registerView() throws Exception {
		logger.info("RegisterView");
		return "member/regform.page";
	}
	
	/* 회원 등록 */
	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register(MemberVO reg, RedirectAttributes rttr) throws Exception  {
		logger.info("Regist");
		/* 암호화 */
		String hashedPw = BCrypt.hashpw(reg.getMpw(), BCrypt.gensalt());
		reg.setMpw(hashedPw);
		service.register(reg);
		
		rttr.addFlashAttribute("msg", "가입이 완료되었습니다");
		
		return "redirect:/member/login";
	}
	
	/* 아이디 중복 확인 */
	@RequestMapping(value = "idChk", method = RequestMethod.POST)
	@ResponseBody
	public int idChk(@RequestBody Map<String,String> idMap) throws Exception {
		int result = service.idChk(idMap);
		
		logger.info("idChk >>"+result);
		return result;
	}
	
	/* 아이디 찾기 뷰 */
	@RequestMapping(value = "find", method = RequestMethod.GET)
	public String findId() throws Exception {
		logger.info("FindView");
		return "member/find.page";
	}
	
	/* 아이디 찾기 */
    @RequestMapping(value="findCheck", method = RequestMethod.GET)
    @ResponseBody
    public Object findCheckGET(String email, String isFindId,
    							Model model) throws Exception{
	    /* 뷰(View)로부터 넘어온 데이터 확인 */
	    logger.info("이메일 데이터 전송 확인");
	    logger.info("인증번호 : " + email);
	    logger.info("아이디찾기 유무 : " + isFindId);
        
	    Map<String, Object> find = new HashMap<String, Object>();
	    find.put("num", service.mailSend(email));
	    if ( StringUtils.equals("1", isFindId) ) {
	    	List<String> ids = service.getID(email);
	    	
	    	find.put("findId", ids);
	    }
	    
        return find;
    }
    
    /* 비밀번호 찾기(변경) */
    @RequestMapping(value = "findPw", method = RequestMethod.POST)
    @ResponseBody
    public String findpw(@RequestBody Map<String, String> update) throws Exception {
    	logger.info("FindPW>>"+update.values());
    	
    	String hashedPw = BCrypt.hashpw(update.get("mpw"), BCrypt.gensalt());
    	update.put("mpw", hashedPw);
    	/* 아이디 유무 */
    	int result = service.idChk(update);
    	if(result == 0) {
			return "0";
		}
    	
		service.updatePW(update);
		
		return "login";
    }
	
	@GetMapping("choiceLan")
	public String setLogin(
    		@RequestParam("lang")String lang,
   		    HttpServletRequest request,
   		    HttpServletResponse response) {
		System.out.println("선택한 언어:"+lang);
		Locale locale = new Locale(lang);
		localeResolver.setLocale(request, response, locale);
		
		return "member/login.page";
	}
}
