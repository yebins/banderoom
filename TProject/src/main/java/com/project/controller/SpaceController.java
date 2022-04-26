package com.project.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.service.SpaceService;

@Controller
@RequestMapping(value = "/space")
public class SpaceController {

	@Autowired
	private SpaceService spaceService;
	
	@RequestMapping(value = "/register.do")
	public String register(HttpServletRequest request) {
		
		if (request.getSession().getAttribute("hlogin") == null) {
			return "redirect:/";
		}
		return "space/register";
	}
}
