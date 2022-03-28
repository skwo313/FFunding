package com.ffunding.web.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
import com.ffunding.web.vo.FundingExpVO;
import com.ffunding.web.vo.FundingInsVO;
import com.ffunding.web.vo.MailVO;
import com.ffunding.web.vo.MemberPagingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.OrderVO;
import com.ffunding.web.vo.PurchaseVO;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	private ManagerDAO dao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Value("${mailPath}")
	private String mailPath;
	
	@Value("${delPath}")
	private String delPath;
	
	@Value("${insPath}")
	private String insPath;
	
	//관리자
	@Override
	public List<String> managerList() throws Exception {
		return dao.managerList();
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
	
	//펀딩신청 총 게시물수
	@Override
	public int applyCnt() throws Exception {
		return dao.applyCnt();
	}
	
	//펀딩예정 총 게시물수
	@Override
	public int expectCnt() throws Exception {
		return dao.expectCnt();
	}
	
	//펀딩진행중 총 게시물수
	@Override
	public int progressCnt() throws Exception {
		return dao.progressCnt();
	}
	
	//펀딩 카테고리별 개수
	@Override
	public int categoryCnt(String cate) throws Exception {
		return dao.categoryCnt(cate);
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
	
	//펀딩신청 상세정보
	@Override
	public ApplyViewVO applyDetail(int fid) throws Exception {
		ApplyViewVO vo = dao.applyDetail(fid);
		vo.setFimg(dao.applyImage(fid));
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
		//해당 펀딩의 이미지파일 이름 가져오기
		String[] fnames = dao.applyImage(fid).toArray(new String[dao.applyImage(fid).size()]);
		//만약 이미지파일이 존재하면
		if(fnames!=null) {
			for(int i=0; i<fnames.length; i++) {
				File file = new File(delPath+fnames[i]);
				//삭제처리
				file.delete();
			}
			//이미지테이블에서 해당 펀딩의 이미지 삭제
			dao.applyImageDel(fid);
		}
		//펀딩신청테이블에서 해당 펀딩 삭제
		dao.applyDel(fid);
	}
	
	//펀딩신청 승인
	@Override
	public void fundingIns(FundingInsVO funding) throws Exception {
		//해당 펀딩의 이미지파일 이름 가져오기
		String[] fnames = dao.applyImage(funding.getFid()).toArray(new String[dao.applyImage(funding.getFid()).size()]);
		//만약 이미지파일이 존재하면
		if(fnames!=null) {
			for(int i=0; i<fnames.length; i++) {
				//복사할 파일 생성
				File insFile = new File(insPath+fnames[i]);
				//원본 파일 생성
				File delFile = new File(delPath+fnames[i]);
				//바이트단위 입출력을 위한 스트림 생성
				InputStream inStream = new FileInputStream(delFile);
				OutputStream outStream = new FileOutputStream(insFile);
				//한번에 읽고 쓸 사이즈 지정
				byte[] buffer  = new byte[1024];
				int read = 0;
				//buffer사이즈만큼 원본파일에서 데이터를 읽어서 복사할파일에 쓰기
				while((read=inStream.read(buffer))>0) {
					//buffer에 담긴 데이터를 0번째 offset부터 read길이만큼 쓰기
					outStream.write(buffer, 0, read);
				}
				//스트림 닫기
				inStream.close();
				outStream.close();
				//원본파일 삭제
				delFile.delete();
			}
			//이미지테이블에서 해당 펀딩의 이미지 삭제
			dao.applyImageDel(funding.getFid());
		}
		//펀딩 테이블에 해당 데이터 넣기
		//이미지 에러시 펀딩테이블로 데이터가 넘어가지 않도록 이미지 복사 이후 데이터 넣기
		dao.fundingIns(funding);
		//펀딩신청테이블에서 해당 펀딩 삭제
		dao.applyDel(funding.getFid());
		//판매자로 권한변경
		dao.sellerUpt(funding.getFmid());
		//order테이블에 초기 데이터 삽입
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("fid", funding.getFid());
		map.put("admin", funding.getAdmin());
		dao.orderIns(map);
	}
	
	//구매승인 리스트
	@Override
	public List<PurchaseVO> purchaseList(ApplyPagingVO paging) throws Exception {
		//총 게시물 수
		paging.setCount(dao.purchaseCnt());
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
		return dao.purchaseList(paging);
	}
	
	//구매신청 승인
	@Override
	public void purchaseIns(int fid) throws Exception {
		//해당 펀딩을 주문한 회원들의 이메일
		String[] email = dao.orderEmail(fid).toArray(new String[dao.orderEmail(fid).size()]);
		if(email.length>0) {
			//이메일을 전송하기 위해 MimeMessage 선언
			MimeMessage mmsg = sender.createMimeMessage();
			//메일 전송을 돕는 MimeMessageHelper 선언
			MimeMessageHelper message = new MimeMessageHelper(mmsg, "UTF-8");
			//이메일 주소를 나타날 때 사용하는 InternetAddress 선언하여 수신인 작성
			InternetAddress[] toArr = new InternetAddress[email.length];
			for(int i=0; i<email.length; i++) {
				System.out.println("email = " + email[i]);
				toArr[i] = new InternetAddress(email[i]);
			}
			//이메일 제목
			message.setSubject("[FFunding] 서포터님이 후원하신 " + dao.fundingName(fid) + " 펀딩 결과입니다.");
			//수신인
			message.setTo(toArr);
			//이메일 내용
			message.setText("서포터님이 후원하신 " + dao.fundingName(fid) + " 펀딩이 100%를 달성하였습니다."
					+ "<br>홈페이지에 접속하셔서 자세한 내용을 확인해주세요. "
					+ "<br><br>FFunding 사이트를 이용해주셔서 감사합니다.", true);
			//이메일 전송
			sender.send(mmsg);
		}
		//원래는 구매테이블에 insert도 구현해야하지만, 구매페이지를 구현하지 않기로 해서 delete만 구현
		//해당 펀딩의 상세정보 가져오기
		FundingExpVO funding = dao.purchaseDetail(fid);
		//이미지가 존재하면 삭제
		if(funding.getFimg()!=null) {
			File delFile = new File(insPath + funding.getFimg());
			delFile.delete();
			if(funding.getFimg1()!=null) {
				delFile = new File(insPath + funding.getFimg1());
				delFile.delete();
				if(funding.getFimg2()!=null) {
					delFile = new File(insPath + funding.getFimg2());
					delFile.delete();
					if(funding.getFimg3()!=null) {
						delFile = new File(insPath + funding.getFimg3());
						delFile.delete();
						if(funding.getFimg4()!=null) {
							delFile = new File(insPath + funding.getFimg4());
							delFile.delete();
							if(funding.getFimg5()!=null) {
								delFile = new File(insPath + funding.getFimg5());
								delFile.delete();
							}
						}
					}
				}
			}
		}
		//펀딩 주문리스트에서 해당 펀딩을 주문한 회원 삭제
		dao.orderDel(fid);
		//구매신청 리스트에서 해당 펀딩 삭제
		dao.purchaseDel(fid);
	}
	
	//구매신청 삭제
	@Override
	public void purchaseDel(int fid) throws Exception {
		//해당 펀딩을 주문한 회원들의 이메일
		String[] email = dao.orderEmail(fid).toArray(new String[dao.orderEmail(fid).size()]);
		if(email.length>0) {
			//이메일을 전송하기 위해 MimeMessage 선언
			MimeMessage mmsg = sender.createMimeMessage();
			//메일 전송을 돕는 MimeMessageHelper 선언
			MimeMessageHelper message = new MimeMessageHelper(mmsg, "UTF-8");
			//이메일 주소를 나타날 때 사용하는 InternetAddress 선언하여 수신인 작성
			InternetAddress[] toArr = new InternetAddress[email.length];
			for(int i=0; i<email.length; i++) {
				System.out.println("email = " + email[i]);
				toArr[i] = new InternetAddress(email[i]);
			}
			//이메일 제목
			message.setSubject("[FFunding] 서포터님이 후원하신 " + dao.fundingName(fid) + " 펀딩 결과입니다.");
			//수신인
			message.setTo(toArr);
			//이메일 내용
			message.setText("서포터님이 후원하신 " + dao.fundingName(fid) + " 펀딩이 100%를 달성하지 못하여 서포터님이 후원하신 포인트는 환불처리해드렸습니다."
					+ "<br>마이페이지에서 환불된 포인트를 확인해주세요. "
					+ "<br><br>FFunding 사이트를 이용해주셔서 감사합니다.", true);
			//이메일 전송
			sender.send(mmsg);
		}
		//펀딩 주문리스트에서 해당 펀딩을 주문한 회원 리스트
		List<OrderVO> orderList = dao.orderList(fid);
		for(OrderVO order:orderList) {
			//포인트 환불
			dao.pointUpt(order);
		}
		//해당 펀딩의 상세정보 가져오기
		FundingExpVO funding = dao.purchaseDetail(fid);
		//이미지가 존재하면 삭제
		if(funding.getFimg()!=null) {
			File delFile = new File(insPath + funding.getFimg());
			delFile.delete();
			if(funding.getFimg1()!=null) {
				delFile = new File(insPath + funding.getFimg1());
				delFile.delete();
				if(funding.getFimg2()!=null) {
					delFile = new File(insPath + funding.getFimg2());
					delFile.delete();
					if(funding.getFimg3()!=null) {
						delFile = new File(insPath + funding.getFimg3());
						delFile.delete();
						if(funding.getFimg4()!=null) {
							delFile = new File(insPath + funding.getFimg4());
							delFile.delete();
							if(funding.getFimg5()!=null) {
								delFile = new File(insPath + funding.getFimg5());
								delFile.delete();
							}
						}
					}
				}
			}
		}
		//펀딩 주문리스트에서 해당 펀딩을 주문한 회원 삭제
		dao.orderDel(fid);
		//구매신청 리스트에서 해당 펀딩 삭제
		dao.purchaseDel(fid);
	}
		
	//메일전송
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
		//이메일 주소를 나타날 때 사용하는 InternetAddress 선언하여 수신인 작성
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
}