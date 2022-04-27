package com.project.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.project.service.SpaceService;
import com.project.vo.SpacesVO;

@Controller
@RequestMapping(value = "/space")
public class SpaceController {

	@Autowired
	private SpaceService spaceService;
	
	@RequestMapping(value = "/register.do", method = RequestMethod.GET)
	public String register(HttpServletRequest request) {
		
		if (request.getSession().getAttribute("hlogin") == null) {
			return "redirect:/";
		}
		return "space/register";
	}
	
	@RequestMapping(value= "register.do", method = RequestMethod.POST)
	public String register(SpacesVO vo) {
		
		int result = spaceService.spaceReg(vo);
		
		if (result > 0) {
			return "redirect:/";
		} else {
			return null;
		}
	}
}
