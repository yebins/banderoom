package com.project.controller;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.MemberService;
import com.project.vo.EmailRegVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.TelRegVO;

@RequestMapping(value = "/member")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value = "/glogin.do", method = RequestMethod.GET)
	public String glogin() {
		return "member/glogin";
	}
	
	@RequestMapping(value = "/hlogin.do", method = RequestMethod.GET)
	public String hlogin() {
		return "member/hlogin";
	}
	
	@RequestMapping(value = "/gjoin.do", method = RequestMethod.GET)
	public String gjoin(String isKakao, HttpServletRequest request) {
		
		if (isKakao.equals("N")) {
			request.getSession().invalidate();
		}
		
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
}
