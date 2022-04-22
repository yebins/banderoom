package com.project.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
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
}
