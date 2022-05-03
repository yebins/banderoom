package com.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.service.BoardService;
import com.project.vo.ArticlesVO;
import com.project.vo.GeneralMembersVO;



@RequestMapping(value="/board")
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register(ArticlesVO vo) {
		
		return "board/register";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String register(ArticlesVO vo, HttpServletRequest request) {
		
		boardService.insertArticlesVO(vo);
		
		return "redirect:/board/list.do?bIdx=" + vo.getbIdx();
	}
	
	@RequestMapping(value="/list.do",method=RequestMethod.GET)
	public String list(Model model,int bIdx,String searchtitle) {
		
		List<ArticlesVO> list=boardService.list(bIdx,searchtitle);
		
		System.out.println(list.size());
		model.addAttribute("list",list);
		
		return "board/list";
	}
	
	@RequestMapping(value="/details.do")
	public String details(Model model,ArticlesVO vo) {
		
		boardService.readCount(vo);
		
		ArticlesVO revo = boardService.selectArticles(vo);
		
		model.addAttribute("vo",revo);
		
		return "board/details";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.GET)
	public String update(Model model, HttpServletRequest request, ArticlesVO vo){
		
		HttpSession session = request.getSession();
		session.getAttribute("login");
		
		ArticlesVO vo2 = boardService.selectArticles(vo);
		
		model.addAttribute("vo",vo2);
		
		return "board/update";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.POST)
	public String update(ArticlesVO vo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		GeneralMembersVO login = (GeneralMembersVO)(session.getAttribute("login"));
		
		if(login.getmIdx() == vo.getmIdx()) {
			boardService.boardUpdate(vo);
			return "redirect:/board/list.do?bIdx=" + vo.getbIdx();
		}else {
			
			request.setAttribute("msg", "삭제할 수 없습니다.");
			request.setAttribute("url", "/board/list.do?bIdx=" + vo.getbIdx());
			
			return "/alert";
		}
		
	}
	
	@RequestMapping(value="/delete.do")
	public String delete(ArticlesVO vo,HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		GeneralMembersVO login = (GeneralMembersVO)(session.getAttribute("login"));
		
		if(login.getmIdx() == vo.getmIdx()) {
			boardService.serlistDelete(vo);
			return "redirect:/board/list.do?bIdx=" + vo.getbIdx();
		}else{
			
			request.setAttribute("msg", "삭제권한이 없습니다.");
			request.setAttribute("url", "/board/list.do?bIdx=" + vo.getbIdx());
			
			return "/alert";
		}
		
	}
	
}

