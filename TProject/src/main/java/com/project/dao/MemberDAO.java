package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.EmailRegVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.HostMembersVO;
import com.project.vo.MessagesVO;
import com.project.vo.PointsVO;
import com.project.vo.ReportsVO;
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
		vo = sqlSession.selectOne("com.project.mapper.memberMapper.gLogin", vo);
		if (vo != null) {
			vo.setPassword(null);
		}
		return vo;
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
	
	public HostMembersVO oneMemberInfo(HostMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.hostMemberInfo",vo);
	}
	
	public int sendMessage(Map<String,Object> map) {
		return sqlSession.insert("com.project.mapper.memberMapper.sendMessage",map);
	}
	
	public HostMembersVO getHostMember (HostMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.getHostMember", vo);
	}
	
	public int setPoint(PointsVO vo) {
		return sqlSession.update("com.project.mapper.memberMapper.setPoint", vo);
	}
	
	public List<MessagesVO> listMessage(Map<String, Object> map){
		
		return sqlSession.selectList("com.project.mapper.memberMapper.listMessage", map);
	}
	
	public int senderListCount(int sender) {
		
		return sqlSession.selectOne("com.project.mapper.memberMapper.listCount",sender);
	}
	public int receiverListCount(int receiver) {
		
		return sqlSession.selectOne("com.project.mapper.memberMapper.listCount",receiver);
	}
	
	public int infoUpdate(GeneralMembersVO vo) {
		return sqlSession.update("com.project.mapper.memberMapper.ginfoUpdate", vo);
	}
	
	public int infoUpdate(HostMembersVO vo) {
		return sqlSession.update("com.project.mapper.memberMapper.hinfoUpdate", vo);
	}
	
	public String selectCurrPw(Map<String, Object> params) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.selectCurrPw", params);
	}
	
	public GeneralMembersVO selectGmemberByEmail(GeneralMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.selectGmemberByEmail", vo);
	}
	
	public boolean isBrnAndEmailExist(HostMembersVO vo) {
		int count = sqlSession.selectOne("com.project.mapper.memberMapper.isBrnAndEmailExist", vo);
		
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public HostMembersVO selectHmemberByBrn(HostMembersVO vo) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.selectHmemberByBrn", vo);
	}
	public int sendReport(ReportsVO vo) {
		return sqlSession.insert("com.project.mapper.memberMapper.sendReport", vo);
	}
	public List<ReportsVO> reportedMember(Map<String, Object> searchMap){
		return sqlSession.selectList("com.project.mapper.memberMapper.reportedMember", searchMap);
	}
	public int reportListNum(Map<String, Object> pagingMap) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.reportListNum", pagingMap);
	}
	public ReportsVO reportedDetail(int rIdx) {
		return sqlSession.selectOne("com.project.mapper.memberMapper.reportedDetail", rIdx);
	}
	public int block(int target) {
		return sqlSession.update("com.project.mapper.memberMapper.block", target);
	}
	public int withdraw(int target) {
		return sqlSession.update("com.project.mapper.memberMapper.withdraw", target);
	}
	public int deleteReport(int rIdx) {
		return sqlSession.delete("com.project.mapper.memberMapper.deleteReport", rIdx);
	}
	public List<GeneralMembersVO> gMember() {
		return sqlSession.selectList("com.project.mapper.memberMapper.gMember");
	}
	public List<HostMembersVO> hMember() {
		return sqlSession.selectList("com.project.mapper.memberMapper.hMember");
	}
}
