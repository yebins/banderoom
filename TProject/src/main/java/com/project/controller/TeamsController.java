package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value="/teams")
@Controller
public class TeamsController {

	@RequestMapping(value="/main.do")
	public String teamsMain() {
		return "teams/main";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register() {
		return "teams/register";
	}
	
//	@RequestMapping(value="/register.do", method=RequestMethod.POST)
//	public String register() {
//		
//	}
	
	@RequestMapping(value="/details.do")
	public String details() {
		return "teams/details";
	}
	
	@RequestMapping(value="/application.do")
	public String application() {
		return "teams/application";
	}
}
