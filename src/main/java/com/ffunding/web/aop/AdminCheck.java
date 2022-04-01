package com.ffunding.web.aop;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ffunding.web.service.ManagerService;
import com.ffunding.web.vo.MemberVO;

@Aspect
@Component
public class AdminCheck {
	
	@Autowired
	private ManagerService service;
	
	//실행될 위치 설정
	@Pointcut("within(com.ffunding.web.controller.ManagerController)")
	public void pointCut() {}
	
	//메서드 실행 이전에 수행
	@Before("pointCut()")
	private void adminCheck() throws Exception {
	 	 //Controller 외에서 세션을 받아오기 위한 방법
		 HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession();
		 MemberVO member = (MemberVO)session.getAttribute("member");
		 //관리자 아이디 리스트
		 List<String> admin = service.managerList();
		 int cnt = 0;
		 if(member!=null && member.getMid()!=null) {
			 for(String a:admin) {
				 //로그인한 아이디와 관리자 아이디가 일치할 경우
				 if(member.getMid().equals(a)) {
					 cnt++;
				 }
			 }
		 } else {
			//HttpClientErrorException 에러 발생
			throw new HttpClientErrorException(HttpStatus.UNAUTHORIZED);
		 }
		 //로그인한 아이디와 관리자 아이디가 일치하지 않을경우
		 if(cnt!=1) {
			//HttpClientErrorException 에러 발생
			throw new HttpClientErrorException(HttpStatus.UNAUTHORIZED);
		 }
	}
	

}