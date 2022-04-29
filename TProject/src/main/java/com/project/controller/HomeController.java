package com.project.controller;

import java.io.*;
import java.text.DateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.project.vo.ServiceInfoVO;


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
	public String serinfo(Model model,Integer idx) {
		if(idx == null) {
			idx = 1;
		}
		
		ServiceInfoVO vo=boardService.selectOneServiceInfo(idx);
		model.addAttribute("vo",vo);
		
		return "serinfo";
	}
	
	
	@RequestMapping(value="/infoupdate.do")
	public String serinfoUp(ServiceInfoVO vo,HttpServletRequest request) {
		HttpSession session=request.getSession();
		System.out.println(vo.getIdx());
		System.out.println(vo.getContent());
		int result=0;
		
		//로그인했을때
		if(session.getAttribute("login") != null) {
			GeneralMembersVO login=(GeneralMembersVO)session.getAttribute("login");
			
			//권한체크
			if(login.getAuth() == 3) {
				result=boardService.updateServiceInfo(vo);
				System.out.println(result);
				request.setAttribute("msg", "수정이 됏다리");
				request.setAttribute("url", "/serinfo.do");
				
				return "alert";
			} else {
				
				request.setAttribute("msg", "권한도 없는놈이 어딜 감히");
				request.setAttribute("url", "/serinfo.do");
				
				return "alert";
			}
			
		}
		//로그인안했을때
		request.setAttribute("msg", "로그인하세유");
		request.setAttribute("url", "/member/glogin.do");
		
		return "alert";
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
	

	@RequestMapping(value = "/uploadPicture.do") // 스마트 에디터 이미지 업로드
	@ResponseBody
	public String profileUpload(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {
		
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
		
		return "/upload/" + newFileName;
	}
}
