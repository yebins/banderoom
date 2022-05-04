package com.project.service;

import java.util.Map;

import com.project.vo.EmailRegVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.HostMembersVO;
import com.project.vo.TelRegVO;

public interface MemberService {

	int sendEmail(String email, String memberType);
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
	int sendMessage(Map<String,Object> map);
}
