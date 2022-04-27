package com.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.service.BoardService;
import com.project.vo.ArticlesVO;



@RequestMapping(value="/board")
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/notice.do")
	public String Notice(Model model) {
		
		return "board/notice";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register() {
		
		return "board/register";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String register(ArticlesVO vo) {
		
		return "redirect:/board/list.do";
	}
	
	@RequestMapping(value="/list.do",method=RequestMethod.GET)
	public String list(Model model,Integer bidx,String searchtitle) {
		System.out.println(bidx);//bidx값 확인
		System.out.println(searchtitle);//검색어 확인
		List<ArticlesVO> list=boardService.list(bidx,searchtitle);
		
		System.out.println(list.size());
		model.addAttribute("list",list);
		
		return "board/list";
	}
	
}

