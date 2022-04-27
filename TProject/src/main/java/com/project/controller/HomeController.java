package com.project.controller;

import java.awt.image.BufferedImage;
import java.io.*;
import java.text.DateFormat;
import java.util.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.BoardService;
import com.project.vo.ArticlesVO;
import com.project.vo.GeneralMembersVO;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/header.do")
	public String header () {
		
		return "header";
	}
	

	@RequestMapping(value = "/uploadPicture.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> profileUpload(HttpServletRequest request, @RequestParam("picture") MultipartFile file) throws Exception {
		
		Map<String, String> pictures = new HashMap<String, String>();
		
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

    makeThumbnail(target.getAbsolutePath(), uuid.toString(), extension.substring(1), path, 200, 150);
    
    String original = "/upload/" + newFileName;
    String thumb = "/upload/THUMB_" + newFileName;
    
    pictures.put("original", original);
    pictures.put("thumb", thumb);
		
		return pictures;
	}

	private void makeThumbnail(String filePath, String fileName, String fileExt, String path, int width, int height) throws Exception {

		// 저장된 원본파일로부터 BufferedImage 객체를 생성합니다.
		BufferedImage srcImg = ImageIO.read(new File(filePath));

		// 썸네일의 너비와 높이 입니다.
		int dw = width, dh = height;

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

	@RequestMapping(value = "/newfile.do")
	public String newfile () {
		
		return "NewFile";
	}

	@RequestMapping(value = "/newfile1.do")
	public String newfile1 () {
		
		return "NewFile1";
	}
	
	@RequestMapping(value = "/payProcess.do", method = RequestMethod.POST)
	public void payProcess(String imp_uid, String merchant_uid) {
		System.out.println(imp_uid + merchant_uid);
		
	}
	
	@RequestMapping(value = "/newfile2.do")
	public String newfile2() {
		return "NewFile2";
	}

	@RequestMapping(value = "/newfile3.do")
	public String newfile3() {
		return "NewFile3";
	}

	@RequestMapping(value = "/formtest.do")
	public String formtest(String no, String yes) {
		System.out.println(no);
		System.out.println(yes);
		return "NewFile3";
	}
	

	@RequestMapping(value = "/frame.do")
	public String frame() {
		return "frame";
	}
	
	@RequestMapping(value="/serinfo.do")
	public String serinfo() {
		
		return "serinfo";
	}
	
	@RequestMapping(value="/serlist.do",method=RequestMethod.GET)
	public String serlist(Model model,Integer bidx,String searchtitle) {
		System.out.println(bidx);//bidx값 확인
		System.out.println(searchtitle);//검색어 확인
		List<ArticlesVO> list=boardService.list(bidx,searchtitle);
		
		System.out.println(list.size());
		model.addAttribute("list",list);
		
		return "serlist";
	}
	
	@RequestMapping(value="/serinfoupdate.do", method=RequestMethod.GET)
	public String serinfoupdate(HttpServletResponse response,HttpServletRequest request) throws IOException {
		PrintWriter pw=response.getWriter();
		HttpSession session=request.getSession();
		
		if(session.getAttribute("login") != null) {
			GeneralMembersVO vo=(GeneralMembersVO)session.getAttribute("login");			
			if(vo.getAuth() ==3) {
				return "serinfoupdate";
			} else {
				
				return "redirect:/";
			}
		} else {
			return "redirect:/";			
		}		
			
	}
	
	@RequestMapping(value="/serinfoupdate.do", method=RequestMethod.POST)
	public String serinfoupdate(Model model,ArticlesVO vo) {
		System.out.println(vo.getbIdx());//글쓸때 선택한 게시판 확인
		System.out.println(vo.getmIdx());//글쓸때 관리자 midx인지 확인
		System.out.println(vo.getContent());//글쓴내용 확인
		System.out.println(vo.getTitle());//글쓴제목 확인
		System.out.println(vo.getmNickname());//글쓸때 관리자 닉네임확인
		
		boardService.insertArticlesVO(vo);
		
		
		return "redirect:/serlist.do?bidx="+vo.getbIdx();
	}
}
