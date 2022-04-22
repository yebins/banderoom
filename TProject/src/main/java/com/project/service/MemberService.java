package com.project.service;

import com.project.vo.EmailRegVO;

public interface MemberService {

	int sendEmail(String email, String memberType);
	int checkEmail(EmailRegVO vo);
	int checkNickname(String nickname, String memberType);
}
