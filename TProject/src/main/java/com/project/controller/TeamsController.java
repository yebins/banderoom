package com.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.service.TeamsService;
import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

@RequestMapping(value="/teams")
@Controller
public class TeamsController {
	
	@Autowired
	private TeamsService teamsService;

	@RequestMapping(value="/main.do")
	public String teamsMain(Model model) {
		List<TeamsVO> teamsList = teamsService.selectList();
		Map<Integer, List<PartsVO>> partsMap = new HashMap<Integer, List<PartsVO>>();
		
		for (int i = 0; i < teamsList.size(); i++) {
			
			
			List<PartsVO> partsList = teamsService.selectParts(teamsList.get(i).getTeamIdx());
			
			partsMap.put(teamsList.get(i).getTeamIdx(), partsList);
		}
		
		
		
		model.addAttribute("teamsList", teamsList);
		model.addAttribute("partsMap", partsMap);
		
		System.out.println(partsMap.toString());
		
		return "teams/main";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register() {
		return "teams/register";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String register(TeamsVO vo, String[] name, int[] capacity) {
		
		List<PartsVO> partsVOlist = new ArrayList<PartsVO>();
		
		for(int i=0; i<capacity.length; i++) {
			PartsVO partsVO = new PartsVO();
			partsVO.setCapacity(capacity[i]);
			if(name == null) {
				partsVO.setName("파트 없음");
				
				
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
	
	@RequestMapping(value="/details.do")
	public String details() {
		return "teams/details";
	}
	
	@RequestMapping(value="/application.do")
	public String application() {
		return "teams/application";
	}
}
