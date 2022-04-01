package com.ffunding.web.dao.impl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.dao.FundingDAO;
import com.ffunding.web.vo.FundingCriteria;
import com.ffunding.web.vo.FundingVO;
import com.ffunding.web.vo.MemberVO;
import com.ffunding.web.vo.OrderVO;

@Repository
public class FundingDAOImpl implements FundingDAO {
	@Inject
	private SqlSession sqlSession;

	// 펀딩목록
	@Override
	public List<FundingVO> list(FundingCriteria cri) throws Exception {
		return sqlSession.selectList("fundingMapper.getlist", cri);
	}

	// 상품 총 갯수
	@Override
	public int listCount(HashMap<String, Object> hashMap) throws Exception {
		return sqlSession.selectOne("fundingMapper.listCount", hashMap);
	}

	// 제품 상세 페이지
	public FundingVO viewDetail(int fid) throws Exception {
		return sqlSession.selectOne("fundingMapper.detailview", fid);
	}

	// 주문 완료
	public void orderProduct(OrderVO vo) throws Exception {
		sqlSession.insert("fundingMapper.orderProduct", vo);
	}

	// 포인트 차감
	public void pointDown(MemberVO membervo) throws Exception {
		sqlSession.update("fundingMapper.pointDown", membervo);
	}
}
