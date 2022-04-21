package com.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping(value="/board")
@Controller
public class BoardController {
	
	@RequestMapping(value="/notice.do")
	public String Notice() {
		
		
		
		return "board/notice";
	}
	
	@RequestMapping(value="/freeBoard.do")
	public String freeBoard() {
		
		return "board/freeBoard";
	}
}
