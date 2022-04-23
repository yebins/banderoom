package com.project.service;

import com.project.vo.EmailRegVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.TelRegVO;

public interface MemberService {

	int sendEmail(String email, String memberType);
	int checkEmail(EmailRegVO vo);
	int checkNickname(String nickname, String memberType);
	int sendTelKey(TelRegVO vo);
	int checkTel(TelRegVO vo);
	int gjoin(GeneralMembersVO vo);
}
