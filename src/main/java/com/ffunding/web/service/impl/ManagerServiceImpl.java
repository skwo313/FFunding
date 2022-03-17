package com.ffunding.web.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.ffunding.web.dao.ManagerDAO;
import com.ffunding.web.service.ManagerService;
import com.ffunding.web.vo.MailVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	private ManagerDAO dao;
	
	@Autowired
	private JavaMailSender sender;
	
	public String sendMail(MailVO mail) throws Exception {
		String msg = "successful message transmission!";
		MimeMessage mmsg = sender.createMimeMessage();
		
		List<String> recipientList = new ArrayList<String>();
		if(mail.getRecipientck()==0) {
			mail.setRecipients(mail.getRecipient().trim().split(",", -1));
		} else if(mail.getRecipientck()==1) {
			recipientList = dao.memberEmail();
			mail.setRecipients(recipientList.toArray(new String[recipientList.size()]));
		} else if(mail.getRecipientck()==2) {
			recipientList = dao.sellerEmail();
			mail.setRecipients(recipientList.toArray(new String[recipientList.size()]));
		}
		
		InternetAddress[] toArr = new InternetAddress[mail.getRecipients().length];
		
		try {
			for(int i=0; i<mail.getRecipients().length; i++) {
				toArr[i] = new InternetAddress(mail.getRecipients()[i]);
			}
			mmsg.setSubject(mail.getTitle());
			mmsg.setRecipients(Message.RecipientType.TO, toArr);
			mmsg.setText(mail.getContent());
		} catch (MessagingException e) {
			msg = "message transmission failure!<br>Please check again.";
		}
		sender.send(mmsg);
		
		return msg;
	}
	
	//회원 리스트
	@Override
	public List<MemberVO> memberList(MemberPagingVO paging) throws Exception {
		//총 게시물 수
		paging.setCount(dao.memberSearchCnt(paging));
		//페이지당 게시물 수 초기값 설정
		if(paging.getPageSize()==0) {
			paging.setPageSize(20);
		}
		//총 페이지 수
		paging.setPageCount((int)Math.ceil(paging.getCount()/(double)paging.getPageSize()));
		//클릭한 현재 페이지 호출(초기값은 1)
		if(paging.getCurPage()==0) {
			paging.setCurPage(1);
		}
		//DB에 넣을 rownum 시작번호
		paging.setStart((paging.getCurPage()-1)*paging.getPageSize()+1);
		//DB에 넣을 rownum 마지막번호
		//총 게시물수보다 클 경우, 총 게시물수를 마지막번호로 지정
		paging.setEnd(paging.getCurPage()*paging.getPageSize()>paging.getCount()?paging.getCount():paging.getCurPage()*paging.getPageSize());
		//페이지 블럭 수
		paging.setBlockSize(5);
		//현재 블럭 그룹 번호
		int curBlockGrpNo = (int)Math.ceil(paging.getCurPage()/(double)paging.getBlockSize());
		//블럭 그룹의 시작 페이지 번호
		paging.setStartBlock((curBlockGrpNo-1)*paging.getBlockSize()+1);
		//블럭 그룹의 마지막 페이지 번호
		//총 페이지수보다 클 경우, 총 페이지수를 마지막 번호로 지정
		paging.setEndBlock(curBlockGrpNo*paging.getBlockSize()>paging.getPageCount()?paging.getPageCount():curBlockGrpNo*paging.getBlockSize());
			
		//검색유형 초기값 설정
		if(paging.getType()==null || paging.getType()=="") {
			paging.setType("id");
		}
		
		return dao.memberList(paging);
	}
	
	//총 회원수
	@Override
	public int memberCnt() throws Exception {
		return dao.memberCnt();
	}
	
	//일반회원수
	@Override
	public int generalCnt() throws Exception {
		return dao.generalCnt();
	}
	
	//판매자수
	@Override
	public int sellerCnt() throws Exception {
		return dao.sellerCnt();
	}
	
	//회원 상세정보
	@Override
	public MemberVO memberDetail(String mid) throws Exception {
		return dao.memberDetail(mid);
	}
	
	//회원 정보수정
	@Override
	public void memberDetailUpdate(MemberVO upt) throws Exception {
		dao.memberDetailUpdate(upt);
	}
}
