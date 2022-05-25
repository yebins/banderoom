package com.project.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.MemberDAO;
import com.project.util.Sms;
import com.project.vo.*;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO dao;

	@Override
	public int sendEmail(String email, String memberType) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("memberType", memberType);
		params.put("email", email);
		
		if (((String) params.get("memberType")).equals("general") && dao.isEmailExist(params)) {
			
			return 2; // 이미 존재하는 이메일
		}
		
		
		String tempKey = "";
		char pwCollection[] = new char[] {
        '1','2','3','4','5','6','7','8','9','0',
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
		
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
			erVO.setRegkey(tempKey);
			
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

	@Override
	public int sendEmailForFindingPw(String email, String memberType) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("memberType", memberType);
		params.put("email", email);
		
		if (!dao.isEmailExist(params)) {
			
			return 2; // 존재하지 않는 이메일
		}
		
		
		String tempKey = "";
		char pwCollection[] = new char[] {
        '1','2','3','4','5','6','7','8','9','0',
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
		
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
			erVO.setRegkey(tempKey);
			
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
	

	@Override
	public int sendEmailForFindingPw(HostMembersVO vo) {
		
		if (!dao.isBrnAndEmailExist(vo)) {
			
			return 2; // 존재하지 않는 이메일
		}
		
		
		String tempKey = "";
		char pwCollection[] = new char[] {
        '1','2','3','4','5','6','7','8','9','0',
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
		
		for (int i = 0; i < 8; i++) {
			tempKey += pwCollection[(int) (Math.random() * pwCollection.length)];
		}

		String sender = "ginsiderservice@gmail.com";
		String receiver = vo.getEmail();
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
			erVO.setEmail(vo.getEmail());
			erVO.setRegkey(tempKey);
			
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
		
		if (check.getRegkey().equals(vo.getRegkey())) {
			
			if (new Date().after(check.getDeadLine())) {
				return 3; // 인증시간 만료
			}
			
			return 0; // 인증키 일치
		} else {
			return 2; // 인증키 불일치
		}
	}

	@Override
	public int checkNickname(String nickname, String memberType) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("nickname", nickname);
		params.put("memberType", memberType);
		
		if (dao.isNicknameExist(params)) {
			return 1; // 이미 존재하는 닉네임
		} else {
			return 0; // 닉네임 없음
		}
	}

	@Override
	public int sendTelKey(TelRegVO vo) {

		String tempKey = "";
		char pwCollection[] = new char[] {
        '1','2','3','4','5','6','7','8','9','0'};
		
		for (int i = 0; i < 6; i++) {
			tempKey += pwCollection[(int) (Math.random() * pwCollection.length)];
		}
		
		vo.setRegkey(tempKey);
		String smsContent = "banderoom 인증번호입니다.\n" + tempKey;
		
		Sms.sendSms(vo.getTel(), smsContent);

		if (dao.isTelKeyExist(vo)) {
			dao.updateTelKey(vo);
		} else {
			dao.setTelKey(vo);
		}
		return 0;
	}

	@Override
	public int checkTel(TelRegVO vo) {

		TelRegVO check = dao.selectTelReg(vo);
		
		if (check == null) {
			return 1; // 해당 번호 없음
		}
		
		if (check.getRegkey().equals(vo.getRegkey())) {
			if (new Date().after(check.getDeadLine())) {
				return 3; // 인증시간 만료
			}
			return 0; // 인증키 일치
		} else {
			return 2; // 인증키 불일치
		}
	}

	@Override
	public int gjoin(GeneralMembersVO vo) {
		return dao.gjoin(vo);
	}

	@Override
	public GeneralMembersVO kakaoLogin(GeneralMembersVO vo) {
		return dao.kakaoLogin(vo);
	}

	@Override
	public GeneralMembersVO gLogin(GeneralMembersVO vo) {
		return dao.gLogin(vo);
	}

	@Override
	public int checkBrn(String brn) {
		return dao.isBrnExist(brn);
	}

	@Override
	public int hjoin(HostMembersVO vo) {
		return dao.hjoin(vo);
	}

	@Override
	public HostMembersVO hLogin(HostMembersVO vo) {
		return dao.hLogin(vo);
	}

	@Override
	public GeneralMembersVO oneMemberInfo(GeneralMembersVO vo) {
		
		GeneralMembersVO vo1=(GeneralMembersVO)dao.oneMemberInfo(vo);
		vo1.setPassword(null);
		return vo1;
	}

	@Override
	public HostMembersVO oneMemberInfo(HostMembersVO vo) {
		return dao.oneMemberInfo(vo);
	}
	
	@Override
	public int sendMessage(Map<String, Object> map) {
		
		return dao.sendMessage(map);
	}

	@Override
	public HostMembersVO getHostMember(HostMembersVO vo) {
		return dao.getHostMember(vo);
	}

	@Override
	public int setPoint(PointsVO vo) {
		return dao.setPoint(vo);
	}

	@Override
	public List<MessagesVO> MessagesList(HttpServletRequest request, Map<String, Object> map) {
		System.out.println(map.toString());
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());
		
		int start = page+(page-1)*13;
		int end=page*14;
		map.put("start", start);
		map.put("end", end);
		
		return dao.listMessage(map);
	}
	
	@Override
	public int infoUpdate(GeneralMembersVO vo) {
		return dao.infoUpdate(vo);
	}
	@Override
	public int infoUpdate(HostMembersVO vo) {
		return dao.infoUpdate(vo);
	}
	
	@Override
	public String selectCurrPw(String memberType, int mIdx) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("memberType", memberType);
		params.put("mIdx", mIdx);
		
		return dao.selectCurrPw(params);
	}
	
	@Override
	public GeneralMembersVO selectGmemberByEmail(GeneralMembersVO vo) {
		return dao.selectGmemberByEmail(vo);
	}

	@Override
	public int sendReport(Map<String, Object> map) {
		return dao.sendReport(map);
	}
	
	@Override
	public HostMembersVO selectHmemberByBrn(HostMembersVO vo) {
		return dao.selectHmemberByBrn(vo);
	}
	
}
