package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.BoardService;
import com.project.service.MemberService;
import com.project.util.PagingUtil;
import com.project.vo.ArticlesVO;
import com.project.vo.CommentRepliesVO;
import com.project.vo.CommentsVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.LikedArticlesVO;



@RequestMapping(value="/board")
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register(ArticlesVO vo) {
		
		return "board/register";
	}
	
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String register(ArticlesVO vo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("login") != null) {
			boardService.insertArticlesVO(vo);
			
			if(vo.getbIdx() == 2) {
				
				return "redirect:/board/list.do?page=1&bIdx=" + vo.getbIdx();		
				
			} else if(vo.getbIdx() == 4) {
			
				return "redirect:/board/hlist.do";
			
			} else {
			
				return "redirect:/board/jlist.do";
			}
			
		}else if(session.getAttribute("login") == null){
			
			request.setAttribute("msg", "로그인후 이용하세요.");
			request.setAttribute("url", "/board/list.do?page=1&bIdx=" + vo.getbIdx());
			
			return "/alert";
		}else {
			request.setAttribute("msg", "로그인후 이용하세요.");
			request.setAttribute("url", "/board/list.do?page=1&bIdx=" + vo.getbIdx());
			
			return "/alert";
		}
		
	}
	
	@RequestMapping(value="/list.do",method=RequestMethod.GET)
	public String list(Model model,int bIdx,String searchtitle, int page) {
		List<ArticlesVO> list=boardService.list(bIdx, searchtitle, page);
		Map<Integer, Integer> likeList = new HashMap<Integer, Integer>();		
		for (int i = 0; i < list.size(); i++) {
			likeList.put(list.get(i).getaIdx(), boardService.likeCount(list.get(i).getaIdx()));
		}
		List<ArticlesVO> pc= boardService.pageCount(bIdx, searchtitle);
		PagingUtil pu = new PagingUtil(pc.size(), page, 10, 10);
		
		model.addAttribute("pu", pu);
		
		model.addAttribute("likeList", likeList);
		
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
		
		ArticlesVO revo = boardService.selectArticles(vo);
		
		model.addAttribute("vo",revo);
		
		return "board/update";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.POST)
	public String update(ArticlesVO vo, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		GeneralMembersVO login = (GeneralMembersVO)(session.getAttribute("login"));
		
		if(login.getmIdx() == vo.getmIdx()) {
			boardService.boardUpdate(vo);
			if(vo.getbIdx() == 4) {
				return "redirect:/board/hlist.do?page=1&bIdx=" + vo.getbIdx();				
				
			} else if (vo.getbIdx() == 2) {
				return "redirect:/board/list.do?page=1&bIdx=" + vo.getbIdx();				
				
			} else {
				return "redirect:/board/jlist.do?page=1&bIdx=" + vo.getbIdx();				
			}
			
		}else {
			
			request.setAttribute("msg", "수정할 수 없습니다.");
			request.setAttribute("url", "/board/list.do?bIdx=" + vo.getbIdx());
			
			return "/alert";
		}
		
	}
	
	@RequestMapping(value="/delete.do")
	public String delete(ArticlesVO vo,HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		GeneralMembersVO login = (GeneralMembersVO)(session.getAttribute("login"));
		if(login.getmIdx() == vo.getmIdx()) {
			boardService.listDelete(vo);
			
			if(vo.getbIdx() == 4) {
				return "redirect:/board/hlist.do?page=1&bIdx=" + vo.getbIdx();				
				
			} else if (vo.getbIdx() == 2) {
				return "redirect:/board/list.do?page=1&bIdx=" + vo.getbIdx();				
				
			} else {
				return "redirect:/board/jlist.do?page=1&bIdx=" + vo.getbIdx();				
			}
		}else{
			
			request.setAttribute("msg", "삭제권한이 없습니다.");
			request.setAttribute("url", "/board/list.do?page=1&bIdx=" + vo.getbIdx());
			
			return "/alert";
		}
		
	}
	
	@RequestMapping(value="likedStatus.do")
	@ResponseBody
	public int likedStatus(LikedArticlesVO vo) {
		return boardService.likedStatus(vo);
	}
	
	@RequestMapping(value="likedArticles.do")
	@ResponseBody
	public int likedArticles(LikedArticlesVO vo) {
		return boardService.likedAtricles(vo);
	}
	
	@RequestMapping(value="unLikedArticles.do")
	@ResponseBody
	public int unLikedArticles(LikedArticlesVO vo) {
		return boardService.unLikedArticles(vo);
	}
	
	@RequestMapping(value="likeCount.do")
	@ResponseBody
	public int likeCount(int aIdx) {
		
		return boardService.likeCount(aIdx);
	}
	
	@RequestMapping(value="/jlist.do",method=RequestMethod.GET)
	public String jList(@RequestParam Map<String, Object> params, Model model,HttpServletRequest request) {
		if(params.get("bIdx") == null) {
			params.put("bIdx", 3);
		}
		System.out.println(params.toString());
		List<ArticlesVO> list = boardService.Jlist(params,request);
		
		if( list.size() >0) {
			
		Map<Integer,String> map=new HashMap<Integer, String>();
		Map<Integer,Integer> map2=new HashMap<Integer, Integer>();
			for(int i=0;i<list.size();i++) {
				String co=list.get(i).getContent().replaceAll(" ", "");
				
				
				if(co.indexOf("<img") > -1) {					
				int startIndex=co.indexOf("<img");
				startIndex=co.indexOf("src", startIndex);
				String co2=co.substring(startIndex+5);
				String[] co3=co2.split("\"");
				String url=co3[0];				
				map.put(i, url);
				} else {
					map.put(i, "");
				}
				model.addAttribute("imgsrc", map);
				
				System.out.println(map.toString());
				
				map2.put(i,boardService.commentCount(list.get(i).getaIdx()));
				
				model.addAttribute("cmt",map2);
			}
		}
		
		int articlesTotal=(Integer)request.getAttribute("count");
		System.out.println("총게시물"+articlesTotal);
		
		//카멜?기법
		model.addAttribute("list", list);
		model.addAttribute("status", params.get("status"));
		model.addAttribute("searchtitle", params.get("searchtitle"));
		model.addAttribute("articlesTotal",articlesTotal);
		
		return "/board/jlist";
		
		
	}
	
	@RequestMapping(value="/hlist.do",method=RequestMethod.GET)
	public String HList(@RequestParam Map<String, Object> params, Model model,HttpServletRequest request) {
		if(params.get("bIdx") == null) {
			params.put("bIdx", 4);
		}
		System.out.println(params.toString());
		List<ArticlesVO> list = boardService.Jlist(params,request);
		
		if( list.size() >0) {
			
			Map<Integer,String> map=new HashMap<Integer, String>();
			Map<Integer,Integer> map2=new HashMap<Integer, Integer>();
			for(int i=0;i<list.size();i++) {
				String co=list.get(i).getContent().replaceAll(" ", "");
				
				
				if(co.indexOf("<img") > -1) {					
					int startIndex=co.indexOf("<img");
					startIndex=co.indexOf("src", startIndex);
					String co2=co.substring(startIndex+5);
					String[] co3=co2.split("\"");
					String url=co3[0];				
					map.put(i, url);
				} else {
					map.put(i, "");
				}
				model.addAttribute("imgsrc", map);
				
				map2.put(i,boardService.commentCount(list.get(i).getaIdx()));
				
				model.addAttribute("cmt",map2);
			}
		}
		
		int articlesTotal=(Integer)request.getAttribute("count");
		System.out.println("총게시물"+articlesTotal);
		
		//카멜?기법
		model.addAttribute("list", list);
		model.addAttribute("status", params.get("status"));
		model.addAttribute("searchtitle", params.get("searchtitle"));
		model.addAttribute("articlesTotal",articlesTotal);
		
		return "/board/hlist";
		
		
	}
	
		@RequestMapping(value="/details.do", method=RequestMethod.GET)
		public String jlistView(Model model,ArticlesVO vo,@RequestParam Map<String, Object> params,HttpServletRequest request) {
			
		boardService.readCount(vo);
		
		System.out.println(params);
		
		Map<String, Object> one = boardService.jlistOneArticle(params,request);//게시글정보
		List<CommentsVO> cmtList=boardService.commentList(params,request);//댓글리스트
		Map<Integer, List<CommentRepliesVO>> replyMap = new HashMap<Integer, List<CommentRepliesVO>>();
		for(int i=0;i<cmtList.size();i++) {
				
				replyMap.put(cmtList.get(i).getcIdx(), boardService.replylist(cmtList.get(i).getcIdx()));
				
		}
		GeneralMembersVO writer=new GeneralMembersVO();
		int a=(int) one.get("mIdx");//게시글 작성자 midx
		writer.setmIdx(a);//게시글 작성자의 midx 삽입
		
		writer=memberService.oneMemberInfo(writer); // midx 넣은 멤버의 정보 가져오기
		
		
		System.out.println("게시글정보"+one.toString());
		
		model.addAttribute("page", request.getAttribute("page"));
		model.addAttribute("cmtList",cmtList);//댓글 리스트
		model.addAttribute("cmtCount",request.getAttribute("cmtCount"));//댓글 총개수?
		model.addAttribute("vo",one);//게시글정보 보내기
		model.addAttribute("profileSrc",writer.getProfileSrc());//글 작성자 프로필 사진 
		model.addAttribute("replyList",replyMap);
		
		
		
		return "/board/details";
	}
		
		@RequestMapping(value="/commentWrite.do")
		@ResponseBody
		public Map<String, Object> commentWrite(CommentsVO vo,@RequestParam("commentSrc") MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException {
					
			
			if(vo.getContent() != null && vo.getContent() != "") {
				
				if(!file.isEmpty()) {
					System.out.println(file);
					
					String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제경로		
						
					String fileName=file.getOriginalFilename();
					
					String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
					
					UUID uuid = UUID.randomUUID();
					
					String newFileName = uuid.toString() + extension;
		
					File target = new File(path, newFileName);
					
					System.out.println(target.toString());
					
					file.transferTo(target);//파일이생성됨
					
					vo.setPicSrc("/upload/"+newFileName);
				}
			
			return boardService.commentWrite(vo);
			
			} else {
				
				return null;
			}
		
		}
		@RequestMapping(value="/replyWrite.do")
		@ResponseBody
		public int replyWrite(CommentRepliesVO vo,@RequestParam("commentSrc") MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException {
			
			if(vo.getContent() != null && vo.getContent() != "") {
				
				if(!file.isEmpty()) {
					System.out.println(file);
					
					String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제경로		
					
					String fileName=file.getOriginalFilename();
					
					String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
					
					UUID uuid = UUID.randomUUID();
					
					String newFileName = uuid.toString() + extension;
					
					File target = new File(path, newFileName);
					
					System.out.println(target.toString());
					
					file.transferTo(target);//파일이생성됨
					
					vo.setPicSrc("/upload/"+newFileName);
				}
				
				return boardService.replyWrite(vo);
				
			} else {
				
				return -2;
			}
			
		}
		
		@RequestMapping(value="/commentUpdate.do")
		@ResponseBody
		public int commentUpdate(CommentsVO vo,@RequestParam("commentSrc") MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException {
			
			if(vo.getContent() != null && vo.getContent() != "") {
				
				if(!file.isEmpty()) {
					System.out.println(file);
					
					String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제경로		
					
					String fileName=file.getOriginalFilename();
					
					String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
					
					UUID uuid = UUID.randomUUID();
					
					String newFileName = uuid.toString() + extension;
					
					File target = new File(path, newFileName);
					
					System.out.println(target.toString());
					
					file.transferTo(target);//파일이생성됨
					
					vo.setPicSrc("/upload/"+newFileName);
				}
				
				System.out.println(vo.toString());
				System.out.println(vo.getContent());
				
				return boardService.commentUpdate(vo);
				
			} else {
				
				return -1;
			}
			
		}
		
		@RequestMapping(value="/commentDelete.do")
		@ResponseBody
		public int commentsDelete(CommentsVO vo) {
			
			return boardService.commentDelete(vo);
		}
		
		@RequestMapping(value="/commentList.do")
		@ResponseBody
		public List<Object> commentsList(@RequestParam Map<String, Object> params,HttpServletRequest request){
			Date nowDate = new Date();
			
			List<CommentsVO> list= boardService.commentList(params,request);
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd a HH:mm:ss"); 
			
			for(int i=0;i<list.size();i++) {
				String date=simpleDateFormat.format(list.get(i).getRegDate());
			}
			
			GeneralMembersVO login=(GeneralMembersVO)request.getSession().getAttribute("login");
			
			if(request.getSession().getAttribute("login") != null) {
				System.out.println("현재로그인한사람의 midx"+login.getmIdx());				
			}
			
			
			List<Object> data=new ArrayList<Object>();
			data.add(request.getAttribute("count"));
			data.add(list);
			data.add(request.getAttribute("page"));
			data.add(request.getAttribute("oCCount"));
			
			
			
			return data;
		}
		
}


