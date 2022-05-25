package com.project.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.project.vo.EmailRegVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.HostMembersVO;
import com.project.vo.MessagesVO;
import com.project.vo.PointsVO;
import com.project.vo.TelRegVO;

public interface MemberService {

	int sendEmail(String email, String memberType);
	int sendEmailForFindingPw(String email, String memberType);
	int sendEmailForFindingPw(HostMembersVO vo);
	int checkEmail(EmailRegVO vo);
	int checkNickname(String nickname, String memberType);
	int sendTelKey(TelRegVO vo);
	int checkTel(TelRegVO vo);
	int gjoin(GeneralMembersVO vo);
	GeneralMembersVO kakaoLogin(GeneralMembersVO vo);
	GeneralMembersVO gLogin(GeneralMembersVO vo);
	int checkBrn(String brn);
	int hjoin(HostMembersVO vo);
	HostMembersVO hLogin(HostMembersVO vo);
	GeneralMembersVO oneMemberInfo(GeneralMembersVO vo);
	HostMembersVO oneMemberInfo(HostMembersVO vo);
	int sendMessage(Map<String,Object> map);
	HostMembersVO getHostMember(HostMembersVO vo);
	int setPoint(PointsVO vo);
	List<MessagesVO> MessagesList(HttpServletRequest request,Map<String, Object> map);
	int infoUpdate(GeneralMembersVO vo);
	int infoUpdate(HostMembersVO vo);
	String selectCurrPw(String memberType, int mIdx);
	GeneralMembersVO selectGmemberByEmail(GeneralMembersVO vo);
	HostMembersVO selectHmemberByBrn(HostMembersVO vo);
	int sendReport(Map<String, Object> map);
}
