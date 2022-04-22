package com.project.service;

import com.project.vo.EmailRegVO;

public interface MemberService {

	int sendEmail(String email);
	int checkEmail(EmailRegVO vo);
}
