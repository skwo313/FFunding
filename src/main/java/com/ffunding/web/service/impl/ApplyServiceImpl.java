package com.ffunding.web.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ffunding.web.dao.ApplyDAO;
import com.ffunding.web.service.ApplyService;
import com.ffunding.web.util.ApplyFileUtils;
import com.ffunding.web.vo.ApplyVO;
import com.ffunding.web.vo.Criteria;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.SearchCriteria;


@Service
public class ApplyServiceImpl implements ApplyService {

	// 펀딩 신청 ServiceImpl
	
	@Resource(name = "ApplyFileUtils")
	private ApplyFileUtils applyFileUtils;

	@Inject
	private ApplyDAO dao;

	// 게시글 작성
	@Override
	public void write(ApplyVO applyVO, MultipartHttpServletRequest mpRequest) throws Exception {
		dao.write(applyVO);

		List<Map<String, Object>> list = applyFileUtils.parseInsertFileInfo(applyVO, mpRequest);
		int size = list.size();
		for (int i = 0; i < size; i++) {
			dao.insertFile(list.get(i));
		}
	}
	
	// 게시물 목록 조회
	@Override
	public List<ApplyVO> list(SearchCriteria scri) throws Exception {
		
		
		return dao.list(scri);
	}
	
	// 게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		
		return dao.listCount(scri);
	}
	
	// 게시물 조회
	@Override
	public ApplyVO read(int fid) throws Exception {

		return dao.read(fid);
	}
	
	// 게시물 수정
	@Override
	public void update(ApplyVO applyVO) throws Exception {

		dao.update(applyVO);
	}

	// 게시물 삭제
	@Override
	public void delete(int fid) throws Exception {
		
		dao.delete(fid);
	}
	
	// 첨부파일 조회
	@Override
	public List<Map<String, Object>> selectFileList(int fid) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectFileList(fid);
	}
	
	// 첨부파일 다운로드
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectFileInfo(map);
	}
	
	

}
