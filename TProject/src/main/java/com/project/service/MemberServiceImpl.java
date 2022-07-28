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
	public String sendTelKey(TelRegVO vo) {

		String tempKey = "";
		char pwCollection[] = new char[] {
        '1','2','3','4','5','6','7','8','9','0'};
		
		for (int i = 0; i < 6; i++) {
			tempKey += pwCollection[(int) (Math.random() * pwCollection.length)];
		}
		
		vo.setRegkey(tempKey);
		String smsContent = "banderoom authentication key.\n" + tempKey;
		
		String response = Sms.sendSms(vo.getTel(), smsContent);

		if (dao.isTelKeyExist(vo)) {
			dao.updateTelKey(vo);
		} else {
			dao.setTelKey(vo);
		}
		return response;
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
	public int sendMessage(MessagesVO vo) {
		
		return dao.sendMessage(vo);
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
	public List<MessagesVO> MessagesList(HttpServletRequest request, MessagesVO vo,int page) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		System.out.println("받는사람"+vo.getReceiver());
		System.out.println("받는사람권한"+vo.getReceiverType());
		if(vo.getReceiver() != 0) {
			
		map2.put("receiver", vo.getReceiver());
		map2.put("receiverType", vo.getReceiverType());
		map2.put("sender", vo.getReceiver());
		map2.put("senderType", vo.getReceiverType());
		
		} else {
			
			map2.put("receiver", vo.getSender());
			map2.put("receiverType", vo.getSenderType());
			map2.put("sender", vo.getSender());
			map2.put("senderType", vo.getSenderType());
			
		}
		
		request.setAttribute("쪽지", dao.listCount(map2));
		request.setAttribute("안읽은쪽지",dao.noReadMsg(map2));
		
		page = (page == 0) ? 1 : page;
		
		int start = (page-1)*14;
		map.put("start", start);
		map.put("receiver",vo.getReceiver());
		map.put("receiverType",vo.getReceiverType());
		map.put("sender", vo.getSender());
		map.put("senderType", vo.getSenderType());
		
		System.out.println(map.toString());
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
	public int sendReport(ReportsVO vo) {
		return dao.sendReport(vo);
	}
	
	@Override
	public HostMembersVO selectHmemberByBrn(HostMembersVO vo) {
		return dao.selectHmemberByBrn(vo);
	}

	@Override
	public List<ReportsVO> reportedMember(Map<String, Object> searchMap) {
		return dao.reportedMember(searchMap);
	}

	@Override
	public int reportListNum(Map<String, Object> pagingMap) {
		return dao.reportListNum(pagingMap);
	}
	
	@Override
	public ReportsVO reportedDetail(int rIdx) {
		return dao.reportedDetail(rIdx);
	}

	@Override
	public int block(int target) {
		return dao.block(target);
	}
	
	@Override
	public int unblock(int target) {
		return dao.unblock(target);
	}

	@Override
	public int withdraw(int target) {
		return dao.withdraw(target);
	}

	@Override
	public int deleteReport(int rIdx) {
		return dao.deleteReport(rIdx);
	}

	@Override
	public List<GeneralMembersVO> gMember(Map<String, Object> searchMap) {
		return dao.gMember(searchMap);
	}
	
	@Override
	public int gMemberNum(Map<String, Object> pagingMap) {
		return dao.gMemberNum(pagingMap);
	}

	@Override
	public List<HostMembersVO> hMember(Map<String, Object> searchMap) {
		return dao.hMember(searchMap);
	}
	
	@Override
	public int hMemberNum(Map<String, Object> pagingMap) {
		return dao.hMemberNum(pagingMap);
	}

	@Override
	public int gUnregister(GeneralMembersVO vo) {
		
		GeneralMembersVO unreg = new GeneralMembersVO();

		unreg.setmIdx(vo.getmIdx());
		unreg.setEmail("unreg_" + vo.getmIdx());
		unreg.setName("unreg_" + vo.getmIdx());
		unreg.setNickname("unreg_" + vo.getmIdx());
		unreg.setAddress("unreg_" + vo.getmIdx());
		unreg.setAddr1("unreg_" + vo.getmIdx());
		unreg.setAddr2("unreg_" + vo.getmIdx());
		unreg.setTel("unreg_" + vo.getmIdx());
		unreg.setProfileSrc("/images/profile_default.png");
		unreg.setGender("U");
		unreg.setAuth(2);
		unreg.setIsKakao("U");
		
		return dao.gUnregister(unreg);
	}
	
	@Override
	public int hUnregister(HostMembersVO vo) {

		HostMembersVO unreg = new HostMembersVO();
		
		unreg.setmIdx(vo.getmIdx());
		unreg.setBrn("unreg_" + vo.getmIdx());
		unreg.setEmail("unreg_" + vo.getmIdx());
		unreg.setName("unreg_" + vo.getmIdx());
		unreg.setNickname("unreg_" + vo.getmIdx());
		unreg.setAddress("unreg_" + vo.getmIdx());
		unreg.setAddr1("unreg_" + vo.getmIdx());
		unreg.setAddr2("unreg_" + vo.getmIdx());
		unreg.setTel("unreg_" + vo.getmIdx());
		unreg.setProfileSrc("/images/profile_default.png");
		unreg.setGender("U");
		unreg.setAuth(2);
		
		unregisterSpaces(vo);
		
		return dao.hUnregister(unreg);
	}

	@Override
	public int deleteMsg(List<String> msgIdx) {
		System.out.println(msgIdx.toString());
		Map<String, List<String>> map= new HashMap<String, List <String>>();
		map.put("msgIdx", msgIdx);
		
		return dao.deleteMsg(map);
	}
	

	@Override
	public int readMsg(MessagesVO vo) {
		
		return dao.readMsg(vo);
	}

	@Override
	public int unregisterSpaces(HostMembersVO vo) {
		return dao.unregisterSpaces(vo);
	}
	
	@Override
	public Map<String, Object> noReadMsg(MessagesVO vo) {
		
		Map<String, Object> params = new HashMap<String, Object>();
	
		params.put("receiver", vo.getReceiver());
		params.put("receiverType", vo.getReceiverType());
		params.put("sender", vo.getReceiver());
		params.put("senderType", vo.getReceiverType());
	
		return dao.noReadMsg(params);
	}
	
}
