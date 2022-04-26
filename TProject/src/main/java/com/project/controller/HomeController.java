package com.project.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.service.BoardService;
import com.project.vo.ArticlesVO;
import com.project.vo.BoardsVO;


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
	public String serinfoupdate() {
		
		return "serinfoupdate";
	}
}
