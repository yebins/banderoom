package com.project.service;

import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MemberDAO;
import com.project.vo.EmailRegVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO dao;

	@Override
	public int sendEmail(String email) {
		
		String tempKey = "";
		char pwCollection[] = new char[] {
        '1','2','3','4','5','6','7','8','9','0',
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
        '!','@','#','$','%','^','&','*','(',')'};
		
		for (int i = 0; i < 8; i++) {
			tempKey += pwCollection[(int) (Math.random() * pwCollection.length)];
		}

		String sender = "ginsiderservice@gmail.com";
		String receiver = email;
		String subject = "이메일을 인증해주세요.";
		String content = "<h2>이메일을 인증해주세요.</h2><p/>아래의 인증 키를 입력해주세요.<p/>" + 
				"<div style='width: fit-content; font-size: 15px; border-radius: 5px; background-color: lightgray; padding: 5px;'>" + 
				tempKey + "</div>";
		

		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			properties.put("mail.transport.protocol", "smtp");
			properties.put("mail.debug", "true");
			properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

			Authenticator auth = new Authenticator() {
				public PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("ginsiderservice@gmail.com", "ldgjwutnnukusxvb");
				}
			};

			Session s = Session.getDefaultInstance(properties, auth);
			Message message = new MimeMessage(s);
			Address sender_address = new InternetAddress(sender);
			Address receiver_address = new InternetAddress(receiver);
			
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(sender_address);
			message.addRecipient(Message.RecipientType.TO, receiver_address);
			message.setSubject(subject);
			message.setContent(content, "text/html; charset=UTF-8");
			message.setSentDate(new java.util.Date());
			Transport.send(message);
			
			EmailRegVO erVO = new EmailRegVO();
			erVO.setEmail(email);
			erVO.setKey(tempKey);
			
			if (dao.isEmailKeyExist(erVO)) {
				dao.updateEmailKey(erVO);
			} else {
				dao.setEmailKey(erVO);
			}
			
			return 0; // 정상 발송
		} catch (Exception e) {
			e.printStackTrace();
			return 1; // 발송 오류
		}

	}
	
	public int checkEmail(EmailRegVO vo) {
		EmailRegVO check = dao.selectEmailReg(vo);
		
		if (check == null) {
			return 1; // 해당 이메일 없음
		}
		
		if (check.getKey().equals(vo.getKey())) {
			return 0; // 인증키 일치
		} else {
			return 2; // 인증키 불일치
		}
	}
}
