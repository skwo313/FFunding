package com.ffunding.web.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ffunding.web.dao.ManagerDAO;
import com.ffunding.web.service.ManagerService;
import com.ffunding.web.vo.ApplyPagingVO;
import com.ffunding.web.vo.ApplyViewVO;
import com.ffunding.web.vo.MailVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	private ManagerDAO dao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private ServletContext servletContext;
	
	@Value("${mailPath}")
	private String mailPath;
	
	@Override
	public String sendMail(MailVO mail) throws Exception {
		String msg = "successful message transmission!";
		//이메일을 전송하기 위해 MimeMessage 선언
		MimeMessage mmsg = sender.createMimeMessage();
		//파일을 첨부하여 전송할 수 있도록 MimeMessageHelper 선언
		MimeMessageHelper message = new MimeMessageHelper(mmsg, true, "UTF-8");
		
		//getRecipientck 값에 따라 직접 입력한 이메일, 모든회원, 판매자만으로 수신인 설정
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
		
		for(int i=0; i<mail.getRecipients().length; i++) {
			toArr[i] = new InternetAddress(mail.getRecipients()[i]);
		}
		
		try {
			//이메일 제목
			message.setSubject(mail.getTitle());
			//수신인
			message.setTo(toArr);
			//이메일 내용
			message.setText(mail.getContent());
			
			//만약 파일을 첨부하고
			if(mail.getAttach().size()>0 && !mail.getAttach().get(0).getOriginalFilename().equals("")) {
				for(MultipartFile file : mail.getAttach()) {
					String fname = file.getOriginalFilename();
					//파일이 존재하면
					if(fname!=null && !fname.equals("")) {
						//파일 생성
						File newFile = new File(mailPath + fname);
						//파일 업로드
						file.transferTo(newFile);
						//업로드된 파일 넣기
						message.addAttachment(fname, newFile);
					}
				}
			}
			//이메일 전송
			sender.send(mmsg);
		} catch (MessagingException e) {
			msg = "message transmission failure!<br>Please check again.";
		} catch (Exception e) {
			msg = "There is an error in the attached file.<br>Please check again";
		}
		//이메일 전송 완료 후, 만약 파일을 첨부했었고
		if(mail.getAttach().size()>0 && !mail.getAttach().get(0).getOriginalFilename().equals("")) {
			for(MultipartFile file : mail.getAttach()) {
				String fname = file.getOriginalFilename();
				//파일이 존재하면
				if(fname!=null && !fname.equals("")) {
					//해당 파일을 생성한 후
					File delFile = new File(mailPath + fname);
					//삭제 처리
					delFile.delete();
				}
			}
		}
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
	
	//펀딩신청 리스트
	@Override
	public List<ApplyViewVO> applyList(ApplyPagingVO paging) throws Exception {
		//총 게시물 수
		paging.setCount(dao.applyCnt());
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
			
		//정렬 초기값 설정
		if(paging.getSort()==null || paging.getSort()=="") {
			paging.setSort("new");
		}
		return dao.applyList(paging);
	}
	
	//펀딩신청 총 게시물수
	@Override
	public int applyCnt() throws Exception {
		return dao.applyCnt();
	}
	
	//펀딩신청 상세정보
	@Override
	public ApplyViewVO applyDetail(int fid) throws Exception {
		ApplyViewVO vo = dao.applyDetail(fid);
		vo.setFimg(dao.applyImage(fid));
		String[] fnames = dao.applyImage(fid).toArray(new String[dao.applyImage(fid).size()]);
		System.out.println(servletContext.getRealPath("/resources/applyimage/")+fnames[0]);
		return vo;
	}
	
	//펀딩신청 이미지
	@Override
	public List<String> applyImage(int fid) throws Exception {
		return dao.applyImage(fid);
	}
	
	//펀딩신청 삭제
	@Override
	public void applyDel(int fid) throws Exception {
		String[] fnames = dao.applyImage(fid).toArray(new String[dao.applyImage(fid).size()]);
		if(fnames!=null) {
			for(int i=0; i<fnames.length; i++) {
				File file = new File(servletContext.getRealPath("/resources/applyimage/")+fnames[i]);
				file.delete();
			}
		}
		dao.applyDel(fid);
		dao.applyImageDel(fid);
	}
}
