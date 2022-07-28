package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	
	//글쓰기 페이지 요청 GET
	@RequestMapping(value="/register.do", method=RequestMethod.GET)
	public String register(ArticlesVO vo) {
		
		return "board/register";
	}
	
	//글쓰기 페이지 POST
	@RequestMapping(value="/register.do", method=RequestMethod.POST)
	public String register(ArticlesVO vo, HttpServletRequest request) {
		
		System.out.println(vo.getStatus());
		
		HttpSession session = request.getSession();
		//로그인확인
		GeneralMembersVO login = (GeneralMembersVO)(session.getAttribute("login"));
		
		//로그인됐을경우
		if(session.getAttribute("login") != null) {
			if(vo.getTitle()==null || vo.getTitle()=="") {
				request.setAttribute("msg", "제목을 입력하세요");
				request.setAttribute("url", "/board/register.do?page=1&bIdx=" + vo.getbIdx());
				
				return "/alert";
			}
			//글쓰기 권한 차단 
			if(login.getAuth()==1) {
				request.setAttribute("msg", "글쓰기가 차단된 회원입니다.");
				request.setAttribute("url", "/board/list.do?page=1&bIdx=" + vo.getbIdx());
				
				return "/alert"; 
			}
			vo.setmIdx(((GeneralMembersVO) session.getAttribute("login")).getmIdx());
			//작성자의 midx를 매개변수로 넣어줌 
			boardService.insertArticlesVO(vo);
			
			//등록하려는 게시판이 어디인지 구분 
			//요청으로부터 받은 게시판의 bidx
			if(vo.getbIdx() == 2) {
				
				return "redirect:/board/list.do?page=1&bIdx=" + vo.getbIdx();		
				
			} else if(vo.getbIdx() == 4) {
			
				return "redirect:/board/hlist.do";
			
			} else {
			
				return "redirect:/board/jlist.do";
			}
			
		}else {
			//로그인이 되지 않았을 경우
			request.setAttribute("msg", "로그인후 이용하세요.");
			request.setAttribute("url", "/board/list.do?page=1&bIdx=" + vo.getbIdx());
			
			return "/alert";
		}
		
	}
	
	//자유게시판 목록 
	@RequestMapping(value="/list.do",method=RequestMethod.GET)
	public String list(Model model, @RequestParam Map<String, Object> map, HttpServletRequest request) {
		
		//parameter를 map 으로 받음 
		List<ArticlesVO> list=boardService.list(map, request);
		//게시글 하나에 달린 댓글 개수
		Map<Integer, Integer> cSize=new HashMap<Integer, Integer>();
		//게시글 좋아요 개수
		Map<Integer, Integer> likeList = new HashMap<Integer, Integer>();
		
		//넘어오는 게시판의 번호가 없을때에는 자유게시판으로 자동으로 등록
		if(map.get("bIdx") == null) {
			map.put("bIdx", 2);
		}
		
		for(int i=0;i<list.size();i++) {
			String co=list.get(i).getContent().replaceAll(" ", "");
			System.out.println("co : "+co);
			//댓글 개수 가져오기 게시물의 pk를 매개변수로 넣음과 동시에 키값으로 설정하고 DB에서 그 게시물번호에 달린 댓글개수를 가져옴
			cSize.put(list.get(i).getaIdx(), Integer.parseInt(String.valueOf(boardService.twoinone(list.get(i).getaIdx()).get("count"))));
			
			//좋아요 개수 가져오기 게시물의 pk를 매개변수로 넣음과 동시에 키값으로 설정하고 DB에서 그 게시물번호에 달린 좋아요개수를 가져옴
//			likeList.put(list.get(i).getaIdx(), Integer.parseInt(String.valueOf(boardService.twoinone(list.get(i).getaIdx()).get("likeCount"))));
			list.get(i).setLikeCount(Integer.parseInt(String.valueOf(boardService.twoinone(list.get(i).getaIdx()).get("likeCount"))));
			
			//리스트에서 가져온 게시물안의 내용중에 <img 태그로 시작하는 태그가 있으면 제목부분에 이미지 태그 추가 
			if(co.indexOf("<img") != -1) {
				list.get(i).setTitle(list.get(i).getTitle()+"<img src='" + request.getContextPath() + "/images/picture-button.png' height='11px'>");
			}
		}
		Iterator<Integer> kesss=likeList.keySet().iterator();
		while(kesss.hasNext()) {
			int keys=kesss.next();
			System.out.printf("키 : %s, 값 : %s %n",keys,likeList.get(keys));
		}
		
		//매개변수로 받은 값을 넣어주고 조건에 맞는 게시물을 가져옴 
		List<ArticlesVO> pc= boardService.pageCount(map);
		//페이지가 없으면 1 있으면 그 페이지 넘버로 변환
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());
		
		// 페이징유틸 ( 게시물 총 개수 , 현재 페이지 , 한 페이지 10개씩 ,5페이지씩)
		PagingUtil pu = new PagingUtil(pc.size(), page, 10, 5);
		
		//페이징
		model.addAttribute("pu", pu);
		//게시물 리스트
		model.addAttribute("list",list);
		
		//상단 추천 게시물
		List<ArticlesVO> bestArticles=boardService.bestArticles();
		for(int i =0; i<bestArticles.size(); i++) {
			cSize.put(bestArticles.get(i).getaIdx(), boardService.commentCount(bestArticles.get(i).getaIdx()));
		}
		
		model.addAttribute("cSize", cSize);
		
		model.addAttribute("bestArticles", bestArticles);
		
		return "board/list";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.GET)
	public String update(Model model, ArticlesVO vo){
		
		ArticlesVO revo = boardService.selectArticles(vo);
		
		model.addAttribute("vo",revo);
		
		return "board/update";
	}
	
	@RequestMapping(value="/update.do", method=RequestMethod.POST)
	public String update(ArticlesVO vo,int page, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		GeneralMembersVO login = (GeneralMembersVO)(session.getAttribute("login"));
		
		//로그인한사람의 idx랑 게시물작성자의 idx 또는 관리자 권한을 가진사람 
		if(login.getmIdx() == vo.getmIdx() || login.getAuth() == 3) {
			//권한없음
			if(login.getAuth()==1) {
				request.setAttribute("msg", "글수정이 차단된 회원입니다.");
				request.setAttribute("url", "/board/details.do?page="+page+"&bIdx=" + vo.getbIdx()+"&aIdx="+vo.getaIdx());
				
				return "/alert"; 
			}
			
			boardService.boardUpdate(vo);
			
			
			if(vo.getbIdx() == 4) {
				return "redirect:/board/hlist.do?page="+page+"&bIdx=" + vo.getbIdx();				
				
			} else if (vo.getbIdx() == 2) {
				return "redirect:/board/list.do?page="+page+"&bIdx=" + vo.getbIdx();				
				
			} else {
				return "redirect:/board/jlist.do?page="+page+"&bIdx=" + vo.getbIdx();				
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
		
		if(login.getmIdx() == vo.getmIdx() || login.getAuth() == 3) {
			if(login.getAuth()==1) {
				request.setAttribute("msg", "글삭제가 차단된 회원입니다.");
				request.setAttribute("url", "/board/details.do?page=1&bIdx=" + vo.getbIdx()+"&aIdx="+vo.getaIdx());
				
				return "/alert"; 
			}
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
		//URI로 접근 시 bidx가 없을때 직접 넣어줌 
		if(params.get("bIdx") == null) {
			params.put("bIdx", 3);
		}
		
		List<ArticlesVO> list = boardService.Jlist(params,request);
		
		if( list.size() >0) {
			
		Map<Integer,String> map=new HashMap<Integer, String>();
		Map<Integer,Integer> map2=new HashMap<Integer, Integer>();
		
			for(int i=0;i<list.size();i++) {
				//게시물 내용
				String co=list.get(i).getContent();
				//정규식을 이용한 이미지 태그 찾기
				Pattern pattern  =  Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
				Matcher match=pattern.matcher(co);
				
				String imgTag = "";
				 
				if(match.find()){ // 이미지 태그를 찾았다면,,
				    imgTag = match.group(0); // 글 내용 중에 첫번째 이미지 태그를 뽑아옴.
				    if(imgTag.indexOf("style") > -1) {
				    	//인라인스타일 있나 확인 후 제거
				    	int style=imgTag.lastIndexOf("style");
				    	imgTag = imgTag.substring(0,style)+">";
				    	System.out.println("style없앴는지확인"+imgTag);
				    }
				}
				
				map.put(i, imgTag);
				map2.put(i,boardService.commentCount(list.get(i).getaIdx()));
				
			}
			model.addAttribute("imgsrc", map);
			model.addAttribute("cmt",map2);
		}
		
		int articlesTotal=(Integer)request.getAttribute("count");
		//카멜?기법
		model.addAttribute("list", list);
		model.addAttribute("status", params.get("status"));
		model.addAttribute("searchtitle", params.get("searchtitle"));
		model.addAttribute("articlesTotal",articlesTotal);
		
		return "/board/jlist";
		
		
	}
	
	@RequestMapping(value="/hlist.do",method=RequestMethod.GET)
	public String HList(@RequestParam Map<String, Object> params, Model model,HttpServletRequest request) {
		//홍보게시판 idx설정
		if(params.get("bIdx") == null) {
			params.put("bIdx", 4);
		}
		
		List<ArticlesVO> list = boardService.Jlist(params,request);
		
		if( list.size() >0) {
			//게시물번호 key 값은 이미지태그
			Map<Integer,String> map=new HashMap<Integer, String>();
			Map<Integer,Integer> map2=new HashMap<Integer, Integer>();
			for(int i=0;i<list.size();i++) {
				
				
				//게시물 내용
				String co=list.get(i).getContent();
				//정규식을 이용한 이미지 태그 찾기
				Pattern pattern  =  Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
				Matcher match=pattern.matcher(co);
				
				String imgTag = "";
				 
				if(match.find()){ // 이미지 태그를 찾았다면,,
				    imgTag = match.group(0); // 글 내용 중에 첫번째 이미지 태그를 뽑아옴.
				    if(imgTag.indexOf("style") > -1) {
				    	//인라인스타일 있나 확인 후 제거
				    	int style=imgTag.lastIndexOf("style");
				    	imgTag = imgTag.substring(0,style)+">";
				    	System.out.println("style없앴는지확인"+imgTag);
				    }
				    
				}
				
				map.put(i, imgTag);
				map2.put(i,boardService.commentCount(list.get(i).getaIdx()));
				
			}
			model.addAttribute("imgsrc", map);
			model.addAttribute("cmt",map2);
		}
		
		int articlesTotal=(Integer)request.getAttribute("count");
		//System.out.println("총게시물"+articlesTotal);
		
		//카멜?기법
		model.addAttribute("list", list);
		model.addAttribute("status", params.get("status"));
		model.addAttribute("searchtitle", params.get("searchtitle"));
		model.addAttribute("articlesTotal",articlesTotal);
		
		return "/board/hlist";
		
		
	}
	
		@RequestMapping(value="/details.do", method=RequestMethod.GET)
		public String jlistView(Model model,ArticlesVO vo,@RequestParam Map<String, Object> params,HttpServletRequest request) {
		
		//조회수 올리기
		boardService.readCount(vo);
		
		//게시글정보
		Map<String, Object> one = boardService.jlistOneArticle(params,request);
		
		//댓글리스트
		List<CommentsVO> cmtList=boardService.commentsList2(params,request);
		
		//댓글번호에 대한 대댓글 리스트 맵 생성
		Map<Integer, List<CommentRepliesVO>> replyMap = new HashMap<Integer, List<CommentRepliesVO>>();
		
		for(int i=0;i<cmtList.size();i++) {
				
				//댓글번호를 키로 잡고 그 댓글번호에 대한 대댓글 리스트 셋팅
				replyMap.put(cmtList.get(i).getcIdx(), boardService.replylist(cmtList.get(i).getcIdx()));
				
		}
		System.out.println("댓글개수"+cmtList.size());
		GeneralMembersVO writer=new GeneralMembersVO();
		
		//게시글 작성자 midx
		int a=(int) one.get("mIdx");
		
		//게시글 작성자의 midx 삽입
		writer.setmIdx(a);
		
		// midx 넣은 멤버의 정보 가져오기
		writer=memberService.oneMemberInfo(writer); 
		
		//이전글 리스트
		List<ArticlesVO> prev = boardService.prevList(vo);
		//다음글 리스트
		List<ArticlesVO> next = boardService.nextList(vo);
		
		model.addAttribute("prev", prev);
		model.addAttribute("next", next);
		//댓글페이지
		model.addAttribute("cpage", request.getAttribute("cpage"));
		//댓글 리스트
		model.addAttribute("cmtList",cmtList);
		//댓글 대댓글 총개수
		model.addAttribute("cmtCount",request.getAttribute("cmtCount"));
		//게시글정보 보내기
		model.addAttribute("vo",one);
		//글 작성자 프로필 사진 
		model.addAttribute("profileSrc",writer.getProfileSrc());
		model.addAttribute("replyList",replyMap);
		
		
		
		return "/board/details";
	}
		
		@RequestMapping(value="/commentWrite.do")
		@ResponseBody
		public Map<String, Object> commentWrite(CommentsVO vo,@RequestParam("commentSrc") MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException {
			
			//세션정보가져오기
			GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
			System.out.println(vo.getContent());
			//댓글 midx에 현재 세션idx 넣어주기
			vo.setmIdx(((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
			if(vo.getContent() != null && !vo.getContent().trim().equals("")) {
				if(login == null) {
					
					Map<String,Object> signal=new HashMap<>();
					signal.put("result",2);
					return signal;
					
				} else if(login.getAuth() == 1) {
					
					Map<String,Object> signal=new HashMap<>();
					signal.put("result",3);
					return signal;
				}
				
				if(!file.isEmpty()) {
					System.out.println(file);
					
					String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제경로		
						
					String fileName=file.getOriginalFilename();
					
					String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
					
					UUID uuid = UUID.randomUUID();

					File dir = new File(path);
					if (!dir.exists()) {	// 해당 디렉토리가 존재하지 않는 경우
						dir.mkdirs();				// 경로의 폴더가 없는 경우 상위 폴더에서부터 전부 생성
					}
					
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
	
			//로그인을 안했을 때 폼 태그에 midx 값이 설정이 안돼서 vo에 바인딩 실패로 에러뜸
			//jsp 에서 로그인을 안했을 때는 임의의 값을 넘겨서 우선 바인딩 시킨 후 밑에서 로그인 유효성검사
			
			
			if(request.getSession().getAttribute("login") == null) {
				return 3;
			}
			GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
			vo.setmIdx(((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
				
				if(login.getAuth() == 1) {
					return 2;
				}
				if(!file.isEmpty()) {
					System.out.println(file);
					
					String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제경로		
					
					String fileName=file.getOriginalFilename();
					
					String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
					
					UUID uuid = UUID.randomUUID();

					File dir = new File(path);
					if (!dir.exists()) {	// 해당 디렉토리가 존재하지 않는 경우
						dir.mkdirs();				// 경로의 폴더가 없는 경우 상위 폴더에서부터 전부 생성
					}
					
					String newFileName = uuid.toString() + extension;
					
					File target = new File(path, newFileName);
					
					System.out.println(target.toString());
					
					file.transferTo(target);//파일이생성됨
					
					vo.setPicSrc("/upload/"+newFileName);
				}
				
				return boardService.replyWrite(vo);
				
				
			
		}
		
		@RequestMapping(value="/replyUpdate.do")
		@ResponseBody
		public int replyUpdate(CommentRepliesVO vo,@RequestParam("commentSrc") MultipartFile file,int fileChange,HttpServletRequest request) throws IllegalStateException, IOException {
			
			//vo의 idx를 매개변수로 넣고 정보 가져오기 
			CommentRepliesVO one=boardService.commentRepliesOneInfo(vo);
			//로그인정보
			GeneralMembersVO login = (GeneralMembersVO)request.getSession().getAttribute("login");
			//vo에다 기존에 있던 사진 셋팅
			vo.setPicSrc(one.getPicSrc());
			if(login == null) {
				
				return -1;
			}
			if(vo.getmIdx() == login.getmIdx() || login.getAuth() == 3) {
				
				if(login.getAuth() == 1) {
					return 2;
				}
				
				if(vo.getContent() != null && !vo.getContent().trim().equals("")) {
					//사진 변경 삭제
					if(fileChange == 1) {
						//변경
						if (!file.isEmpty()) {
						
						String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제경로		
						
						String fileName=file.getOriginalFilename();
						
						String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
						
						UUID uuid = UUID.randomUUID();

						File dir = new File(path);
						if (!dir.exists()) {	// 해당 디렉토리가 존재하지 않는 경우
							dir.mkdirs();				// 경로의 폴더가 없는 경우 상위 폴더에서부터 전부 생성
						}
						
						String newFileName = uuid.toString() + extension;
						
						File target = new File(path, newFileName);
						
						//System.out.println(target.toString());
						
						file.transferTo(target);//파일이생성됨
						
						vo.setPicSrc("/upload/"+newFileName);
						} else {
						//변경인데 사진을 뺄 경우 
						vo.setPicSrc(null);
						}
						
					}
					return boardService.commentRepliesUpdate(vo);
					
				}
				return -1;
				
			} else {
				
				return -1;
			}
			
		}
		
		@RequestMapping(value="/commentUpdate.do")
		@ResponseBody
		public int commentUpdate(CommentsVO vo,@RequestParam("commentSrc") MultipartFile file,int fileChange,HttpServletRequest request) throws IllegalStateException, IOException {
			CommentsVO one=boardService.commentOneInfo(vo);
			System.out.println(one.getPicSrc());
			vo.setPicSrc(one.getPicSrc());
			HttpSession session = request.getSession();
			GeneralMembersVO login = (GeneralMembersVO)(session.getAttribute("login"));
			
			if(vo.getmIdx() == login.getmIdx() || login.getAuth() == 3) {
				if(login.getAuth() == 1) {//차단회원
					return 2;
				}
				if(vo.getContent() != null && !vo.getContent().trim().equals("")) {
					//사진 변경 삭제
					if(fileChange == 1) {
						//변경
						if (!file.isEmpty()) {
						
						String path = request.getSession().getServletContext().getRealPath("/resources/upload"); //실제경로		
						
						String fileName=file.getOriginalFilename();
						
						String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
						
						UUID uuid = UUID.randomUUID();
						
						File dir = new File(path);
						if (!dir.exists()) {	// 해당 디렉토리가 존재하지 않는 경우
							dir.mkdirs();				// 경로의 폴더가 없는 경우 상위 폴더에서부터 전부 생성
						}
						
						String newFileName = uuid.toString() + extension;
						
						File target = new File(path, newFileName);
						
						//System.out.println(target.toString());
						
						file.transferTo(target);//파일이생성됨
						
						vo.setPicSrc("/upload/"+newFileName);
						
						} else {
							//변경인데 사진을 뺄 경우
							vo.setPicSrc(null);
						}
						
					}
					return boardService.commentUpdate(vo);
				}
				return -1;
				
			}else {
				
				return -1;
				
			}
			 
		}
		
		@RequestMapping(value="/commentDelete.do")
		@ResponseBody
		public int commentsDelete(CommentsVO vo,HttpServletRequest request) {
			
			GeneralMembersVO login=(GeneralMembersVO)request.getSession().getAttribute("login");
			if(vo.getmIdx() == login.getmIdx() || login.getAuth() == 3) {
				if(login.getAuth() == 1) {
					return 2;
				}
				return boardService.commentDelete(vo);
			}
			 else {
				 return -2;
			 }
		}
		
		@RequestMapping(value="/commentList.do")
		@ResponseBody
		public List<Object> commentsList(@RequestParam Map<String, Object> params,HttpServletRequest request){
			Date nowDate = new Date();
			
			//댓글리스트 불러오기
			List<CommentsVO> list= boardService.commentsList2(params,request);
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd a HH:mm:ss");
			//키 : 댓글idx 값 : 대댓글리스트
			Map<Integer, List<CommentRepliesVO>> replyMap = new HashMap<>();
			for(int i=0;i<list.size();i++) {
				replyMap.put(list.get(i).getcIdx(),boardService.replylist(list.get(i).getcIdx()));
			}
			
			List<Object> data=new ArrayList<Object>();
			data.add(request.getAttribute("count"));
			data.add(list);
			data.add(request.getAttribute("cpage"));
			data.add(request.getAttribute("oCCount"));
			data.add(replyMap);
			
			return data;
		}
		
		@RequestMapping(value="/replyDelete.do")
		@ResponseBody
		public int replyDelete(CommentRepliesVO vo,HttpServletRequest request) {
			
			GeneralMembersVO login=(GeneralMembersVO)request.getSession().getAttribute("login");
			
			if(vo.getmIdx() == login.getmIdx() || login.getAuth() == 3) {
				if(login.getAuth() == 1) {
					return 2;
				}
				return boardService.replyDelete(vo);				
			} else {
				return -2;
			}
		}
		
		
}


