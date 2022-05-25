package com.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.service.MemberService;
import com.project.service.TeamsService;
import com.project.util.PagingUtil;
import com.project.vo.ApplicationsVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

@RequestMapping(value="/teams")
@Controller
public class TeamsController {
	
	@Autowired
	private TeamsService teamsService;
	@Autowired
	private MemberService memberService;

	@RequestMapping(value="/main.do")
	public String teamsMain(Model model, TeamsVO vo, String searchWord, Integer search, String sort) {
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		if(search != null) {
			searchMap.put("vo", vo);
			searchMap.put("searchWord", searchWord);
			searchMap.put("sort", sort);
		}
		searchMap.put("start", 0);
		
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
	
	@RequestMapping(value="/scroll.do")
	@ResponseBody
	public Map<String, Object> scroll(TeamsVO vo, String searchWord, Integer search, String sort, int page){
		Map<String, Object> scrollMap = new HashMap<String, Object>();
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		if(search != null) {
			searchMap.put("vo", vo);
			searchMap.put("searchWord", searchWord);
			searchMap.put("sort", sort);
		}
		searchMap.put("start", (page-1)*12);
		
		List<TeamsVO> teamsList = teamsService.selectList(searchMap);
		
		Map<Integer, List<PartsVO>> partsMap = new HashMap<Integer, List<PartsVO>>();
		
		for (int i=0; i<teamsList.size(); i++) {
			List<PartsVO> partsList = teamsService.selectParts(teamsList.get(i).getTeamIdx());
			partsMap.put(teamsList.get(i).getTeamIdx(), partsList);
		}
		
		scrollMap.put("teamsList", teamsList);
		scrollMap.put("partsMap", partsMap);
		
		return scrollMap;
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
		
		GeneralMembersVO writer = new GeneralMembersVO();
		int mIdx = teamsVO.getmIdx();//게시글 작성자 midx
		writer.setmIdx(mIdx);//게시글 작성자의 midx 삽입
		
		writer = memberService.oneMemberInfo(writer);
		model.addAttribute("profileSrc",writer.getProfileSrc());
		
		List<PartsVO> cntList = teamsService.appNum(teamIdx); 
		
		model.addAttribute("cntList", cntList);
		
		return "teams/details";
	}
	
	@RequestMapping(value="/application.do", method=RequestMethod.GET)
	public String application(HttpServletRequest request, Model model, int teamIdx) {
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		TeamsVO teamsVO = teamsService.details(teamIdx);
		
		if (login == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
			
		} else if(login.getmIdx() == teamsVO.getmIdx()){
			
			model.addAttribute("msg", "본인 글에는 지원하실 수 없습니다.");
			model.addAttribute("url", "/teams/main.do");
			
			return "alert";
			
		} else {
		
			List<PartsVO> partsVO = teamsService.selectParts(teamIdx);
			
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
	public String myteams(Model model, HttpServletRequest request, Integer endYN) {
		
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		}else {
			GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
			
			int regPage = 1; //등록한글
			
			int mIdx = login.getmIdx();
			
			
			Map<String, Integer> endMap = new HashMap<String, Integer>();
			
			endMap.put("mIdx", mIdx);
			endMap.put("endYN", endYN);
			
			PagingUtil regPageUtil = new PagingUtil(teamsService.reglistCount(endMap), regPage, 8, 5);
			
			endMap.put("start", regPageUtil.getStart()-1);
			
			model.addAttribute("regPageUtil", regPageUtil);
			
			
			List<TeamsVO> teamsList = teamsService.reglist(endMap);
			
			Map<Integer, List<PartsVO>> partsMap = new HashMap<Integer, List<PartsVO>>();
			
			for (int i=0; i<teamsList.size(); i++) {
				List<PartsVO> partsList = teamsService.selectParts(teamsList.get(i).getTeamIdx());
				partsMap.put(teamsList.get(i).getTeamIdx(), partsList);
			}
			
			model.addAttribute("reglist", teamsList);
			model.addAttribute("partsMap", partsMap);
			
			
			int appPage = 1; //등록한지원서
			
			Map<String, Integer> appMap = new HashMap<String, Integer>();
			
			appMap.put("mIdx", mIdx);
			
			PagingUtil appPageUtil = new PagingUtil(teamsService.applistCount(mIdx), appPage, 5, 5);
			
			appMap.put("start", appPageUtil.getStart()-1);
			
			model.addAttribute("appPageUtil", appPageUtil);
			
			List<ApplicationsVO> appList = teamsService.applist(appMap); 
			
			model.addAttribute("applist", appList);
			
			return "teams/myteams";
		}
	}
	
	
	@RequestMapping(value="/reglistPaging.do")
	@ResponseBody
	public Map<String, Object> reglistPaging(HttpServletRequest request, Integer endYN, int page) {
		
		Map<String, Object> reglistMap = new HashMap<String, Object>();
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		int regPage = page; //등록한글
		
		int mIdx = login.getmIdx();
		
		Map<String, Integer> endMap = new HashMap<String, Integer>();
		
		
		endMap.put("mIdx", mIdx);
		endMap.put("endYN", endYN);
		
		PagingUtil regPageUtil = new PagingUtil(teamsService.reglistCount(endMap), regPage, 8, 5);
		
		endMap.put("start", regPageUtil.getStart()-1);
		
		reglistMap.put("regPageUtil", regPageUtil);
		
		
		List<TeamsVO> teamsList = teamsService.reglist(endMap);
		
		Map<Integer, List<PartsVO>> partsMap = new HashMap<Integer, List<PartsVO>>();
		
		for (int i=0; i<teamsList.size(); i++) {
			List<PartsVO> partsList = teamsService.selectParts(teamsList.get(i).getTeamIdx());
			partsMap.put(teamsList.get(i).getTeamIdx(), partsList);
		}
		
		reglistMap.put("reglist", teamsList);
		reglistMap.put("partsMap", partsMap);
		
		return reglistMap;
	}
	
	@RequestMapping(value="/applistPaging.do")
	@ResponseBody
	public Map<String, Object> applistPaging(HttpServletRequest request, int page){
		
		Map<String, Object> applistMap = new HashMap<String, Object>();
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		int mIdx = login.getmIdx();
		
		int appPage = page; //등록한지원서
		
		Map<String, Integer> appMap = new HashMap<String, Integer>();
		
		appMap.put("mIdx", mIdx);
		
		PagingUtil appPageUtil = new PagingUtil(teamsService.applistCount(mIdx), appPage, 5, 5);
		
		appMap.put("start", appPageUtil.getStart()-1);
		applistMap.put("appPageUtil", appPageUtil);
		
		List<ApplicationsVO> appList = teamsService.applist(appMap); 
		
		applistMap.put("applist", appList);
		
		return applistMap;
	}
	
	
	@RequestMapping(value="/finish.do")
	@ResponseBody
	public String finish(HttpServletRequest request, Model model, int teamIdx) {
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		}
		
		if(teamsService.finish(teamIdx) > 0) {
			return "ok";
		}
		return "";
	}
	
	@RequestMapping(value="/myapp.do")
	public String myapp(HttpServletRequest request, Model model, int teamIdx, int mIdx, Integer page) {
		
		GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
		
		if (login == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		}else if(login.getmIdx() != mIdx) {
			
			model.addAttribute("msg", "본인이 작성한 글만 볼 수 있습니다.");
			model.addAttribute("url", "/member/main.do");
			
			return "alert";
		}else {
			Map<String, Object> applistMap = new HashMap<String, Object>();
			
			if(page == null) {
				page = 1;
			}
			
			PagingUtil PagingUtil = new PagingUtil(teamsService.myappCount(teamIdx), page, 5, 5);
			
			applistMap.put("teamIdx", teamIdx);
			applistMap.put("start", PagingUtil.getStart()-1);
			
			List<ApplicationsVO> vo = teamsService.myapp(applistMap);
			
			model.addAttribute("applist", vo);
			model.addAttribute("PagingUtil", PagingUtil);
			
			return "teams/myapp";
			
		}
	}
	
	@RequestMapping(value="/updateStatus.do")
	@ResponseBody
	public void updateStatus() {
		teamsService.updateStatus();
	}
	
	@RequestMapping(value="/updateApp.do")
	@ResponseBody
	public int updateApp(String content, int appIdx) {
		ApplicationsVO vo = new ApplicationsVO();
		
		vo.setContent(content);
		vo.setAppIdx(appIdx);
		
		int result = teamsService.updateApp(vo);
		if(result > 0) {
			return 1;
		}
		return 0;
	}
	
	@RequestMapping(value="/deleteApp.do")
	@ResponseBody
	public int deleteApp(int appIdx) {
		
		int result = teamsService.deleteApp(appIdx);
		if(result > 0) {
			return 1;
		}
		return 0;
	}
	
	
}
