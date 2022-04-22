package com.project.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.EmailRegVO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public boolean isEmailKeyExist(EmailRegVO vo) {
		int count = sqlSession.selectOne("com.project.mapper.memberMapper.isEmailKeyExist", vo);
		
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public void setEmailKey(EmailRegVO vo) {
		sqlSession.insert("com.project.mapper.memberMapper.setEmailKey", vo);
	}
	
	public void updateEmailKey(EmailRegVO vo) {
		sqlSession.update("com.project.mapper.memberMapper.updateEmailKey", vo);
	}
	
	public EmailRegVO selectEmailReg(EmailRegVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.selectEmailReg", vo);
	}
	
}
