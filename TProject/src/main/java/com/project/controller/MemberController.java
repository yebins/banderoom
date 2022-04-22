package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RequestMapping(value = "/member")
@Controller
public class MemberController {
	
	@RequestMapping(value = "/glogin.do", method = RequestMethod.GET)
	public String glogin() {
		return "member/glogin";
	}
	
	@RequestMapping(value = "/hlogin.do", method = RequestMethod.GET)
	public String hlogin() {
		return "member/hlogin";
	}
	
	@RequestMapping(value = "/gjoin.do", method = RequestMethod.GET)
	public String gjoin() {
		return "member/gjoin";
	}
}
