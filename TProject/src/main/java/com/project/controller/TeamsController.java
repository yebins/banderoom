package com.project.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.TeamsService;
import com.project.vo.ApplicationsVO;
import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;
import com.sun.java.swing.plaf.windows.resources.windows;

@RequestMapping(value="/teams")
@Controller
public class TeamsController {
	
	@Autowired
	private TeamsService teamsService;

	@RequestMapping(value="/main.do")
	public String teamsMain(Model model, TeamsVO vo, String searchWord, Integer search) {
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		if(search != null) {
			searchMap.put("vo", vo);
			searchMap.put("searchWord", searchWord);
		}
		
		List<TeamsVO> teamsList = teamsService.selectList(searchMap);
		
		Map<Integer, List<PartsVO>> partsMap = new HashMap<Integer, List<PartsVO>>();
		
		for (int i=0; i<teamsList.size(); i++) {
			List<PartsVO> partsList = teamsService.selectParts(teamsList.get(i).getTeamIdx());
			partsMap.put(teamsList.get(i).getTeamIdx(), partsList);
		}
		
		model.addAttribute("teamsList", teamsList);
		model.addAttribute("partsMap", partsMap);
		
		return "teams/main";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register(HttpServletRequest request) {
		
		if (request.getSession().getAttribute("login") == null) {
			return "redirect:/";
		}
		
		return "teams/register";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String register(HttpServletRequest request, Model model, TeamsVO vo, String[] name, int[] capacity) {
		
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		} else {
		
			List<PartsVO> partsVOlist = new ArrayList<PartsVO>();
			
			for(int i=0; i<capacity.length; i++) {
				PartsVO partsVO = new PartsVO();
				partsVO.setCapacity(capacity[i]);
				if(name == null) {
					partsVO.setName("");
				}else {
					partsVO.setName(name[i]);
				}
					partsVOlist.add(partsVO);
			}
			
			int result = teamsService.register(vo, partsVOlist);
			if(result != 0) {
				return "redirect:/teams/main.do";
			}else {
				return "teams/register";
			}
		}
	}
	
	@RequestMapping(value="/details.do")
	public String details(Model model, int teamIdx) {
		TeamsVO teamsVO = teamsService.details(teamIdx);
		List<PartsVO> partsVO = teamsService.selectParts(teamIdx);
		
		model.addAttribute("details", teamsVO);
		model.addAttribute("parts", partsVO);
		
		return "teams/details";
	}
	
	@RequestMapping(value="/application.do", method=RequestMethod.GET)
	public String application(HttpServletRequest request, Model model, int teamIdx) {
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		} else {
		
			List<PartsVO> partsVO = teamsService.selectParts(teamIdx);
			TeamsVO teamsVO = teamsService.details(teamIdx);
			
			model.addAttribute("parts", partsVO);
			model.addAttribute("details", teamsVO);
			
			return "teams/application";
		}
	}
	
	@RequestMapping(value="/application.do", method=RequestMethod.POST)
	@ResponseBody
	public int application(ApplicationsVO vo) {
		int result = teamsService.apply(vo);
		return result;
	}
	
	@RequestMapping(value="/delete.do", method=RequestMethod.POST)
	@ResponseBody
	public String delete(HttpServletRequest request, Model model, int teamIdx) {
		
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		}
		
		int result = teamsService.delete(teamIdx);
		if(result != 0) {
			return "ok";
		}
		return "";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.GET)
	public String update(HttpServletRequest request, Model model, int teamIdx) {
		
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		}
		
		TeamsVO teamsVO = teamsService.details(teamIdx);
		List<PartsVO> partsVO = teamsService.selectParts(teamIdx);
		
		model.addAttribute("details", teamsVO);
		model.addAttribute("parts", partsVO);
		
		return "teams/update";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.POST)
	public String update(HttpServletRequest request, Model model, TeamsVO vo) {
		
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		}
		
		int result = teamsService.update(vo);
		
		if(result != 0) {
			return "redirect:/teams/details.do?teamIdx="+vo.getTeamIdx();
		}else {
			return "teams/update";
		}
	}
	
	@RequestMapping(value="/myteams.do")
	public String myteams(Model model, HttpServletRequest request) {
		
		
		
		return "teams/myteams";
	}
}
