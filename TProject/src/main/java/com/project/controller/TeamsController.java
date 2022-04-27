package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping(value="/teams")
@Controller
public class TeamsController {

	@RequestMapping(value="/main.do")
	public String teamsMain() {
		return "teams/main";
	}
	
	@RequestMapping(value="/getTeams.do")
	public String getTeams() {
		return "teams/getTeams";
	}
}
