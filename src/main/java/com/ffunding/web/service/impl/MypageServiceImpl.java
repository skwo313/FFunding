package com.ffunding.web.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ffunding.web.dao.MypageDao;
import com.ffunding.web.service.MypageService;
import com.ffunding.web.vo.MemberVO;

@Service
public class MypageServiceImpl implements MypageService{

	@Inject
	private MypageDao dao;
	
	@Override
	public Map<String, String> getInfo(MemberVO session) throws Exception {
		// TODO Auto-generated method stub
		
		return dao.getInfo(session);
	}

	@Override
	public List<Map<String, String>> fundingList(MemberVO session) throws Exception {
		// TODO Auto-generated method stub
		
		return dao.fundingList(session);
	}

	@Override
	public void updatePW(Map<String, String> update) throws Exception {
		// TODO Auto-generated method stub
		dao.updatePW(update);
	}

	@Override
	public void updateAddr(Map<String, String> update) throws Exception {
		// TODO Auto-generated method stub
		
		dao.updateAddr(update);
	}

	@Override
	public List<String> getFunding(MemberVO fl) throws Exception {
		// TODO Auto-generated method stub
		
		return dao.getFunding(fl);
	}

	@Override
	public List<String> getDonation(MemberVO dl) throws Exception {
		// TODO Auto-generated method stub
		
		return dao.getDonation(dl);
	}

	@Override
	public void pointCharge(Map<String, String> payInfo) throws Exception {
		// TODO Auto-generated method stub
		
		dao.pointCharge(payInfo);
	}

}
