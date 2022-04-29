package com.project.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register(ArticlesVO vo) {
		
		return "board/register";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String register(Model model,ArticlesVO vo, HttpServletRequest request) {
		
		boardService.insertArticlesVO(vo);
		
		return "redirect:/board/list.do?bidx=" + vo.getbIdx();
	}
	
	@RequestMapping(value="/list.do",method=RequestMethod.GET)
	public String list(Model model,Integer bidx,String searchtitle, ArticlesVO vo) {
		System.out.println(searchtitle);//검색어 확인
		List<ArticlesVO> list=boardService.list(bidx,searchtitle);
		
		System.out.println(list.size());
		model.addAttribute("list",list);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("mm-DD-yyyy");
		SimpleDateFormat df = new SimpleDateFormat("mm-DD");
		
		
		if(sdf.format(vo.getRegDate())==sdf.format(date)) {
			String mm = df.format(vo.getRegDate());
			try {
				vo.setRegDate(df.parse(mm));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return "board/list";
	}
	
	@RequestMapping(value="/details.do")
	public String details() {
		
		return "board/details";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.GET)
	public String update(ArticlesVO vo) {
		
		return "board/update";
	}
	
}

