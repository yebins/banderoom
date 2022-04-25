package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value="/board")
@Controller
public class BoardController {
	
	@RequestMapping(value="/notice.do")
	public String Notice(Model model) {
		
		return "board/notice";
	}
	
	@RequestMapping(value="/list.do")
	public String list() {
		
		return "board/list";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register() {
		
		return "board/register";
	}
	
}
