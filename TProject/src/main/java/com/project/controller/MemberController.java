package com.project.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.*;
import com.project.util.PagingUtil;
import com.project.vo.*;

@RequestMapping(value = "/member")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/glogin.do", method = RequestMethod.GET)
	public String glogin() {
		return "member/glogin";
	}
	
	
	@RequestMapping(value = "/gjoin.do", method = RequestMethod.GET)
	public String gjoin(Model model, String isKakao, HttpServletRequest request) {
		
		if (isKakao.equals("N")) {
			request.getSession().invalidate();
		}
		
		Map<String, ServiceInfoVO> info = new HashMap<String, ServiceInfoVO>();
		
		for (int i = 1; i <= 2; i++) {
			info.put(String.valueOf(i), boardService.selectOneServiceInfo(i));
		}
		
		model.addAttribute("info", info);
		
		return "member/gjoin";
	}
	
	@RequestMapping(value = "/sendEmail.do", method = RequestMethod.POST)
	@ResponseBody
	public int sendEmail(String email, String memberType) {
		
		return memberService.sendEmail(email, memberType);
	}
	
	@RequestMapping(value = "/checkEmail.do", method = RequestMethod.POST)
	@ResponseBody
	public int checkEmail(EmailRegVO vo) {
		
		return memberService.checkEmail(vo);
	}
	
	@RequestMapping(value = "/profileUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String profileUpload(HttpServletRequest request, @RequestParam("profilePicture") MultipartFile file) throws Exception {
		
		
		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		String fileName = file.getOriginalFilename();
		
		String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());

		UUID uuid = UUID.randomUUID();
		String newFileName = uuid.toString() + extension;

		File dir = new File(path);
		if (!dir.exists()) {	// 해당 디렉토리가 존재하지 않는 경우
			dir.mkdirs();				// 경로의 폴더가 없는 경우 상위 폴더에서부터 전부 생성
		}
		
		File target = new File(path, newFileName);
		
		file.transferTo(target);
		
		makeThumbnail(target.getAbsolutePath(), uuid.toString(), extension.substring(1), path);
		
		return "/upload/THUMB_" + newFileName;
	}
	
	private void makeThumbnail(String filePath, String fileName, String fileExt, String path) throws Exception {

		// 저장된 원본파일로부터 BufferedImage 객체를 생성합니다.
		BufferedImage srcImg = ImageIO.read(new File(filePath));

		// 썸네일의 너비와 높이 입니다.
		int dw = 200, dh = 200;

		// 원본 이미지의 너비와 높이 입니다.
		int ow = srcImg.getWidth();
		int oh = srcImg.getHeight();

		// 원본 너비를 기준으로 하여 썸네일의 비율로 높이를 계산합니다.
		int nw = ow; int nh = (ow * dh) / dw;

		// 계산된 높이가 원본보다 높다면 crop이 안되므로
		// 원본 높이를 기준으로 썸네일의 비율로 너비를 계산합니다.
		if(nh > oh) {
			nw = (oh * dw) / dh;
			nh = oh;
		}

		// 계산된 크기로 원본이미지를 가운데에서 crop 합니다.
		BufferedImage cropImg = Scalr.crop(srcImg, (ow-nw)/2, (oh-nh)/2, nw, nh);

		// crop된 이미지로 썸네일을 생성합니다.
		BufferedImage destImg = Scalr.resize(cropImg, dw, dh);

		// 썸네일을 저장합니다. 이미지 이름 앞에 "THUMB_" 를 붙여 표시했습니다.
		String thumbName = path + "\\THUMB_" + fileName + "." + fileExt;
		File thumbFile = new File(thumbName);
		
		ImageIO.write(destImg, fileExt.toUpperCase(), thumbFile);
	}
	
	@RequestMapping(value = "checkNickname.do")
	@ResponseBody
	public int checkNickname(String nickname, String memberType) {
		return memberService.checkNickname(nickname, memberType);
	}
	
	@RequestMapping(value = "sendSms.do", method = RequestMethod.POST)
	@ResponseBody
	public int sendSms(TelRegVO vo) {
		vo.setTel(vo.getTel().replaceAll("-", ""));
		
		return memberService.sendTelKey(vo);
	}

	@RequestMapping(value = "checkTel.do", method = RequestMethod.POST)
	@ResponseBody
	public int checkTel(TelRegVO vo) {
		vo.setTel(vo.getTel().replaceAll("-", ""));
		
		return memberService.checkTel(vo);
	}
	
	@RequestMapping(value = "gjoin.do", method = RequestMethod.POST)
	@ResponseBody
	public int gjoin(GeneralMembersVO vo) {
		
		return memberService.gjoin(vo); // 1: 성공, 0: 실패
	}
	
	@RequestMapping(value = "kakaoLogin.do", method = RequestMethod.POST)
	@ResponseBody
	public int kakaoLogin(String email, String profileSrc, String nickname, HttpServletRequest request) {
		
		GeneralMembersVO vo = new GeneralMembersVO();
		vo.setEmail(email);
		
		if ((vo = memberService.kakaoLogin(vo)) != null) {
			request.getSession().setAttribute("login", vo);
			
			return 1;
		}

		Map<String, String> kakao = new HashMap<String, String>();
		kakao.put("email", email);
		kakao.put("profileSrc", profileSrc);
		kakao.put("nickname", nickname);
		
		request.getSession().setAttribute("kakao", kakao);
		
		return 0;
	}
	
	@RequestMapping(value = "logout.do")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "glogin.do", method = RequestMethod.POST)
	@ResponseBody
	public int glogin(GeneralMembersVO vo, HttpServletRequest request) {
		
		if ((vo = memberService.gLogin(vo)) != null) {
			request.getSession().setAttribute("login", vo);
			
			return 1;
		}
		
		return 0; // 회원정보 없음
	}
	
	
	

	@RequestMapping(value = "/hlogin.do", method = RequestMethod.GET)
	public String hlogin() {
		return "member/hlogin";
	}
	
	@RequestMapping(value = "/hjoin.do", method = RequestMethod.GET)
	public String hjoin(Model model) {
		
		Map<String, ServiceInfoVO> info = new HashMap<String, ServiceInfoVO>();
		
		for (int i = 1; i <= 2; i++) {
			info.put(String.valueOf(i), boardService.selectOneServiceInfo(i));
		}
		
		model.addAttribute("info", info);
		
		return "member/hjoin";
	}
	
	@RequestMapping(value = "/checkBrn.do", method = RequestMethod.POST)
	@ResponseBody
	public int checkBrn(String brn) {
		return memberService.checkBrn(brn);
	}
	
	@RequestMapping(value = "hjoin.do", method = RequestMethod.POST)
	@ResponseBody
	public int hjoin(HostMembersVO vo) {
		
		return memberService.hjoin(vo); // 1: 성공, 0: 실패
	}
	
	@RequestMapping(value = "hlogin.do", method = RequestMethod.POST)
	@ResponseBody
	public int hlogin(HostMembersVO vo, HttpServletRequest request) {
		
		if ((vo = memberService.hLogin(vo)) != null) {
			request.getSession().setAttribute("hlogin", vo);
			
			return 1;
		}
		
		return 0; // 회원정보 없음
	}
	
	@RequestMapping(value = "test.do")
	public String test() {
		return "member/test";
	}
	
	@RequestMapping(value="miniProfile.do")
	@ResponseBody
	public GeneralMembersVO miniProfile(GeneralMembersVO vo) {
		System.out.println(vo.getmIdx());
		GeneralMembersVO vo1=(GeneralMembersVO)memberService.oneMemberInfo(vo);
		
		return vo1;
	}
	
	@RequestMapping(value="myMessage.do")
	public String myMessage(Model model,HttpServletRequest request,@RequestParam Map<String, Object> params) {
		GeneralMembersVO login=(GeneralMembersVO)request.getSession().getAttribute("login");//현재 세션 로그인정보
		System.out.println("쪽지함 로그인정보"+login.getmIdx());
		
		if( login != null) {
				params.put("mIdx", login.getmIdx());
				List<MessagesVO> vo=memberService.MessagesList(request, params);
				
				model.addAttribute("list",vo);
				model.addAttribute("receiveCount",request.getAttribute("receiveCount"));
				model.addAttribute("sendCount",request.getAttribute("sendCount"));
			
			return "myMessage";
		} 
		
			request.setAttribute("msg", "로그인하세요.");
			request.setAttribute("url", "/member/glogin.do");
				
			return "alert";
		
	}
	
	@RequestMapping(value = "ginfo.do", method = RequestMethod.GET)
	public String ginfo(HttpServletRequest request) {
		
		if (request.getSession().getAttribute("login") == null) {
			return "member/glogin";
		}
		
		return "member/ginfo";
	}
	
	@RequestMapping(value = "profileupdate.do")
	@ResponseBody
	public String profileUpdate(HttpServletRequest request, @RequestParam("profilePicture") MultipartFile file) throws Exception {

		if (request.getSession().getAttribute("login") == null && request.getSession().getAttribute("hlogin") == null) {
			return "1"; // 로그인 안 됨
		}
		
		String src = "/images/profile_default.png";
		
		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		String fileName = file.getOriginalFilename();
		
		String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());

		UUID uuid = UUID.randomUUID();
		String newFileName = uuid.toString() + extension;

		File dir = new File(path);
		if (!dir.exists()) {	// 해당 디렉토리가 존재하지 않는 경우
			dir.mkdirs();				// 경로의 폴더가 없는 경우 상위 폴더에서부터 전부 생성
		}
		
		File target = new File(path, newFileName);
		
		file.transferTo(target);
		
		makeThumbnail(target.getAbsolutePath(), uuid.toString(), extension.substring(1), path);
		
		if (request.getSession().getAttribute("login") != null) {

			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
			
			src = "/upload/THUMB_" + newFileName;
			
			login.setProfileSrc(src);
			memberService.infoUpdate(login);
			
		} else if (request.getSession().getAttribute("hlogin") != null) {
			
			HostMembersVO login = (HostMembersVO) request.getSession().getAttribute("hlogin");

			src = "/upload/THUMB_" + newFileName;
			
			login.setProfileSrc(src);
			memberService.infoUpdate(login);
		}

		return src;
	}
	
	@RequestMapping(value = "profilereset.do")
	@ResponseBody
	public String profileReset(HttpServletRequest request) {

		String src = "/images/profile_default.png";
		
		if (request.getSession().getAttribute("login") == null && request.getSession().getAttribute("hlogin") == null) {
			return "1"; // 로그인 안 됨
		}

		if (request.getSession().getAttribute("login") != null) {
			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");

			login.setProfileSrc(src);
			memberService.infoUpdate(login);
		} else if (request.getSession().getAttribute("hlogin") != null) {
			HostMembersVO login = (HostMembersVO) request.getSession().getAttribute("hlogin");
			
			login.setProfileSrc(src);
			memberService.infoUpdate(login);
		}
		
		return src;
	}
	
	@RequestMapping(value = "updatenickname.do")
	@ResponseBody
	public String updateNickname(HttpServletRequest request, String nickname) {

		if (request.getSession().getAttribute("login") == null && request.getSession().getAttribute("hlogin") == null) {
			return "1"; // 로그인 안 됨
		}
		
		if (request.getSession().getAttribute("login") != null) {
			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");

			if (memberService.checkNickname(nickname, "general") == 1) {
				return "2"; // 이미 존재하는 닉네임
			}
			
			login.setNickname(nickname);
			
			if (memberService.infoUpdate(login) > 0) {
				return "0"; // 정상 업데이트
			} else {
				return "3"; // 업데이트 실패
			}
		} else if (request.getSession().getAttribute("hlogin") != null) {
			HostMembersVO login = (HostMembersVO) request.getSession().getAttribute("hlogin");

			if (memberService.checkNickname(nickname, "host") == 1) {
				return "2"; // 이미 존재하는 닉네임
			}
			
			login.setNickname(nickname);
			
			if (memberService.infoUpdate(login) > 0) {
				return "0"; // 정상 업데이트
			} else {
				return "3"; // 업데이트 실패
			}
		}	
		
		return "3";
	}
	
	@RequestMapping(value = "changepassword.do", method = RequestMethod.GET)
	public String changePassword(HttpServletRequest request) {
		
		
		return "member/changepassword";
	}
	
	@RequestMapping(value = "changepassword.do", method = RequestMethod.POST)
	@ResponseBody
	public String changePassword(HttpServletRequest request, String currPw, String pw1) {

		if (request.getSession().getAttribute("login") == null && request.getSession().getAttribute("hlogin") == null) {
			return "1"; // 로그인 안 됨
		}

		if (request.getSession().getAttribute("login") != null) {
			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
			
			if (!currPw.equals(memberService.selectCurrPw("general", login.getmIdx()))) {
				return "2"; // 현재 비밀번호 틀림
			}
			
			login.setPassword(pw1);

			if (memberService.infoUpdate(login) > 0) {
				return "0"; // 정상 업데이트
			} else {
				return "3"; // 업데이트 실패
			}
		} else if (request.getSession().getAttribute("hlogin") != null) {
			HostMembersVO login = (HostMembersVO) request.getSession().getAttribute("hlogin");
			
			if (!currPw.equals(memberService.selectCurrPw("host", login.getmIdx()))) {
				return "2"; // 현재 비밀번호 틀림
			}
			
			login.setPassword(pw1);

			if (memberService.infoUpdate(login) > 0) {
				return "0"; // 정상 업데이트
			} else {
				return "3"; // 업데이트 실패
			}
		}
		
		return "3";
		
	}
	
	@RequestMapping(value = "ginfo.do", method = RequestMethod.POST)
	@ResponseBody
	public String ginfo(GeneralMembersVO vo, HttpServletRequest request) {

		if (request.getSession().getAttribute("login") == null) {
			return "1"; // 로그인 안 됨
		}

		GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
		
		vo.setmIdx(login.getmIdx());

		if (memberService.infoUpdate(vo) > 0) {
			return "0"; // 정상 업데이트
		} else {
			return "2"; // 업데이트 실패
		}
		
	}
	
	@RequestMapping(value = "hinfo.do", method = RequestMethod.GET)
	public String hinfo(HttpServletRequest request) {

		if (request.getSession().getAttribute("hlogin") == null) {
			return "member/hlogin";
		}
		
		return "member/hinfo";
	}

	@RequestMapping(value = "hinfo.do", method = RequestMethod.POST)
	@ResponseBody
	public String hinfo(HostMembersVO vo, HttpServletRequest request) {

		if (request.getSession().getAttribute("hlogin") == null) {
			return "1"; // 로그인 안 됨
		}

		HostMembersVO login = (HostMembersVO) request.getSession().getAttribute("hlogin");
		
		vo.setmIdx(login.getmIdx());

		if (memberService.infoUpdate(vo) > 0) {
			return "0"; // 정상 업데이트
		} else {
			return "2"; // 업데이트 실패
		}
		
	}
	
	@RequestMapping(value = "gfindpw.do", method = RequestMethod.GET)
	public String gfindPw(Model model) {
		return "member/gfindpw";
	}
	
	@RequestMapping(value = "hfindpw.do", method = RequestMethod.GET)
	public String hfindPw(Model model) {
		return "member/hfindpw";
	}
	
	@RequestMapping(value = "sendemailforgfindingpw.do", method = RequestMethod.POST)
	@ResponseBody
	public int sendEmailForFindingPw(String email, String memberType) {
		
		return memberService.sendEmailForFindingPw(email, memberType);
	}
	
	@RequestMapping(value = "gfindpw.do", method = RequestMethod.POST)
	public String gfindPw(HttpServletRequest request, Model model, EmailRegVO vo) {

		int emailCheck = memberService.checkEmail(vo);
		
		if (emailCheck != 0) { // 인증 내용이 올바르지 않을 경우
			return "member/findpwerror";
		}

		model.addAttribute("emailRegVO", vo);
		
		return "member/gfindpwchange";
	}
	
	@RequestMapping(value = "gfindpwchange.do", method = RequestMethod.POST)
	@ResponseBody
	public String gFindPwChange(EmailRegVO vo, String pw1) {

		int emailCheck = memberService.checkEmail(vo);
		
		if (emailCheck != 0) { // 인증 내용이 올바르지 않을 경우
			return "1";
		}
		
		GeneralMembersVO gMember = new GeneralMembersVO();
		gMember.setEmail(vo.getEmail());
		
		gMember = memberService.selectGmemberByEmail(gMember);
		
		gMember.setPassword(pw1);
		memberService.infoUpdate(gMember);
		
		return "0";
		
	}
	
	@RequestMapping(value = "sendemailforhfindingpw.do", method = RequestMethod.POST)
	@ResponseBody
	public int sendEmailForFindingPw(HostMembersVO vo) {
		
		return memberService.sendEmailForFindingPw(vo);
	}
	
	
	@RequestMapping(value = "hfindpw.do", method = RequestMethod.POST)
	public String hfindPw(HttpServletRequest request, Model model, HostMembersVO hostVO, EmailRegVO vo) {

		int emailCheck = memberService.checkEmail(vo);
		
		if (emailCheck != 0) { // 인증 내용이 올바르지 않을 경우
			return "member/findpwerror";
		}

		model.addAttribute("hostVO", hostVO);
		model.addAttribute("emailRegVO", vo);
		
		return "member/hfindpwchange";
	}

	@RequestMapping(value = "hfindpwchange.do", method = RequestMethod.POST)
	@ResponseBody
	public String hFindPwChange(HostMembersVO hostVO, EmailRegVO vo, String pw1) {

		int emailCheck = memberService.checkEmail(vo);
		
		System.out.println(emailCheck);
		
		if (emailCheck != 0) { // 인증 내용이 올바르지 않을 경우
			return "1";
		}
		
		hostVO = memberService.selectHmemberByBrn(hostVO);
		hostVO.setPassword(pw1);
		memberService.infoUpdate(hostVO);
		
		return "0";
		
	}
	
	//신고
	@RequestMapping(value="reportPopup.do")
	public String reportPopup(Model model, GeneralMembersVO vo) {
		
		GeneralMembersVO vo1 = memberService.oneMemberInfo(vo);
		
		model.addAttribute("vo", vo1);
		
		return "member/reportPopup";
	}
	
	@RequestMapping(value="sendReport.do")
	@ResponseBody
	public int sendReport(ReportsVO vo, HttpServletRequest request) {
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		if(login != null) {
			int reporter = login.getmIdx();
			String reportername = login.getNickname();
			vo.setReporter(reporter);
			vo.setReportername(reportername);
			
			return memberService.sendReport(vo);
			
		} else{
			return -1;
		}
	}
	
	@RequestMapping(value="reportedMember.do")
	public String reportedMember(Model model, HttpServletRequest request, Integer page,
								 Integer search, String sort, String searchField, String searchWord) {
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		if (login == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		}else if (login.getAuth() != 3) {

			model.addAttribute("msg", "관리자만 볼 수 있습니다.");
			model.addAttribute("url", "/");
			
			return "alert";
			
		}else {
			
			Map<String, Object> searchMap = new HashMap<String, Object>();
			
			if(page == null) {
				page = 1;
			}
			
			if(search != null) {
				searchMap.put("sort", sort);
				searchMap.put("searchField", searchField);
				searchMap.put("searchWord", searchWord);
			}
			
			Map<String, Object> pagingMap = new HashMap<String, Object>();
			
			if(search != null) {
				pagingMap.put("sort", sort);
				pagingMap.put("searchField", searchField);
				pagingMap.put("searchWord", searchWord);
			}
			
			PagingUtil PagingUtil = new PagingUtil(memberService.reportListNum(pagingMap), page, 10, 5);
			searchMap.put("start", PagingUtil.getStart()-1);
			
			List<ReportsVO> reportedMember = memberService.reportedMember(searchMap);
			
			model.addAttribute("reportedMember", reportedMember);			
			model.addAttribute("PagingUtil", PagingUtil);
			
			return "member/reportedMember";
		}
	}
	
	
	@RequestMapping(value="reportedDetail.do")
	public String reportedDetail(Model model, int rIdx) {
		
		model.addAttribute("reportedDetail", memberService.reportedDetail(rIdx));
		
		return "member/reportedDetail";
	}
	
	@RequestMapping(value="block.do")
	@ResponseBody
	public String block(Model model, HttpServletRequest request, Integer target) {
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		if (login.getAuth() != 3) {

			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		}else if(memberService.block(target) == 1){
			return "ok";
		}
		return "x";
	}
	
	@RequestMapping(value="withdraw.do")
	@ResponseBody
	public String withdraw(Model model, HttpServletRequest request, int target) {
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		if (login.getAuth() != 3) {

			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		}else if(memberService.withdraw(target) == 1){
			return "ok";
		}
		return "x";
	}
	
	@RequestMapping(value="deleteReport.do")
	@ResponseBody
	public String deleteReport(Model model, HttpServletRequest request, int rIdx) {
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		if (login.getAuth() != 3) {

			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		}else if( memberService.deleteReport(rIdx) == 1){
			return "ok";
		}
		return "x";
	}
	//신고
	
	//회원관리
	@RequestMapping(value="gAdminCheck.do", method = RequestMethod.GET)
	public String gAdminCheck() {
		
		return "member/gAdminCheck";
	}
	
	@RequestMapping(value="gAdminCheck.do", method = RequestMethod.POST)
	public String gAdminCheck(Model model, HttpServletRequest request, GeneralMembersVO vo) {
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		vo.setEmail(login.getEmail());
		
		if(memberService.gLogin(vo) == null) {
			model.addAttribute("msg", "비밀번호가 틀렸습니다.");
			model.addAttribute("url", "/member/gAdminCheck.do");
			
			return "alert";
			
		}else {
		
			return "redirect:/member/gMemberManage.do";
		}
	}
	
	@RequestMapping(value="gMemberManage.do")
	public String gMemberManage(Model model) {
		
		List<GeneralMembersVO> gMember = memberService.gMember();
		
		model.addAttribute("gMember", gMember);
		
		return "member/gMemberManage";
	}
	
	@RequestMapping(value="hAdminCheck.do", method = RequestMethod.GET)
	public String hAdminCheck() {
		
		return "member/hAdminCheck";
	}
	
	@RequestMapping(value="hAdminCheck.do", method = RequestMethod.POST)
	public String hAdminCheck(Model model, HttpServletRequest request, GeneralMembersVO vo) {
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		vo.setEmail(login.getEmail());
		
		if(memberService.gLogin(vo) == null) {
			model.addAttribute("msg", "비밀번호가 틀렸습니다.");
			model.addAttribute("url", "/member/hAdminCheck.do");
			
			return "alert";
			
		}else {
		
			return "redirect:/member/hMemberManage.do";
		}
	}
	
	@RequestMapping(value="hMemberManage.do")
	public String hMemberManage(Model model) {
		
		List<HostMembersVO> hMember = memberService.hMember();
		
		model.addAttribute("hMember", hMember);
		
		return "member/hMemberManage";
	}
	//회원관리
	
}
