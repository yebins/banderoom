package com.project.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.EmailRegVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.HostMembersVO;
import com.project.vo.TelRegVO;

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
	
	public boolean isEmailExist(Map<String, Object> params) {
		int count = sqlSession.selectOne("com.project.mapper.memberMapper.isEmailExist", params);

		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public boolean isNicknameExist(Map<String, Object> params) {
		int count = sqlSession.selectOne("com.project.mapper.memberMapper.isNicknameExist", params);
		
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	

	public boolean isTelKeyExist(TelRegVO vo) {
		int count = sqlSession.selectOne("com.project.mapper.memberMapper.isTelKeyExist", vo);
		
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public void setTelKey(TelRegVO vo) {
		sqlSession.insert("com.project.mapper.memberMapper.setTelKey", vo);
	}
	
	public void updateTelKey(TelRegVO vo) {
		sqlSession.update("com.project.mapper.memberMapper.updateTelKey", vo);
	}
	
	public TelRegVO selectTelReg(TelRegVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.selectTelReg", vo);
	}
	
	public int gjoin(GeneralMembersVO vo) {
		return sqlSession.insert("com.project.mapper.memberMapper.gjoin", vo);
	}
	
	public GeneralMembersVO kakaoLogin(GeneralMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.kakaoLogin", vo);
	}
	
	public GeneralMembersVO gLogin(GeneralMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.gLogin", vo);
	}
	
	public int isBrnExist(String brn) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.isBrnExist", brn);
	}
	
	public int hjoin(HostMembersVO vo) {
		return sqlSession.insert("com.project.mapper.memberMapper.hjoin", vo);
	}
	
	public HostMembersVO hLogin(HostMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.hLogin", vo);
	}
	
	public GeneralMembersVO oneMemberInfo(GeneralMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.oneMemberInfo",vo);
	}
	
	public int sendMessage(Map<String,Object> map) {
		
		return sqlSession.insert("com.project.mapper.memberMapper.sendMessage",map);
	}
}
