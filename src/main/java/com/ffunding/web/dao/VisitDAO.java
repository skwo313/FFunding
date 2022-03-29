package com.ffunding.web.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ffunding.web.vo.VisitDateVO;
import com.ffunding.web.vo.VisitVO;

@Repository
public class VisitDAO {
	@Inject
	SqlSession sql;

	public void insertIp(VisitVO vo) {
		sql.insert("visitMapper.insertIp", vo);

	}
	public void updateDate(VisitDateVO vo) {
		sql.update("managerMapper.visitdateupdate", vo);
	}
}
