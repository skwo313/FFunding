package com.ffunding.web.service.impl;

import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.ffunding.web.dao.MemberDAO;
import com.ffunding.web.service.MemberService;
import com.ffunding.web.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDAO dao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Override
	public MemberVO loginCheck(Map<String, String> loginMap) throws Exception {
		
		return dao.loginCheck(loginMap);
	}

	@Override
	public MemberVO getBySns(MemberVO snsUser) throws Exception {
		// TODO Auto-generated method stub
		return dao.getBySns(snsUser);
	}

	@Override
	public void joinBySns(MemberVO snsUser) throws Exception {
		// TODO Auto-generated method stub
		dao.joinBySns(snsUser);
	}

	@Override
	public int idChk(Map<String, String> idMap) throws Exception {
		// TODO Auto-generated method stub
		return dao.idChk(idMap);
	}

	@Override
	public void register(MemberVO reg) throws Exception {
		// TODO Auto-generated method stub
		dao.register(reg);
	}

	/* 이메일 전송 */
	@Override
	public String mailSend(String email) throws Exception {
		/* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        
        /* 계정 유무 */
        String check = dao.getID(email);
        if (check == null) {
        	return "0";
        }
        
        /* 이메일 보내기 */
        String setFrom = "aptl1471@naver.com";
        String toMail = email;
        String title = "인증 이메일입니다.(FFunding).";
        String content = 
                "FFunding 홈페이지에 방문해주셔서 감사합니다.." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }		
        
        String num = Integer.toString(checkNum);
        
        return num;
	}
	
	/* 아이디 찾기 */
	@Override
	public String getID(String email) throws Exception {
		// TODO Auto-generated method stub
		return dao.getID(email);
	}

	/* password 변경 */
	@Override
	public void updatePW(Map<String, String> update) throws Exception {
		// TODO Auto-generated method stub
		dao.updatePW(update);
	}
}
