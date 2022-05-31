package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.project.service.SpaceService;
import com.project.vo.ArticlesVO;
import com.project.vo.GeneralMembersVO;
import com.project.vo.HostMembersVO;
import com.project.vo.MessagesVO;
import com.project.vo.ServiceInfoVO;
import com.project.vo.SpacesVO;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private SpaceService spaceService;
	
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {

		Map<String, Object> params = new HashMap<>();
		
		params.put("start", 0);
		
		params.put("likedMidx", 0);
		if (request.getSession().getAttribute("login") != null) {
			params.put("likedMidx", ((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
		}
		
		params.put("orderType", "score");
		params.put("liked", 0);
		
		List<SpacesVO> spaceList = spaceService.spaceList(params);
		model.addAttribute("spaceList", spaceList);
		
		return "home";
	}
	
	@RequestMapping(value = "/header.do")
	public String header (HttpServletRequest request) {
		
		if (request.getSession().getAttribute("login") != null) {
			request.getSession().setAttribute("login"
					, memberService.oneMemberInfo(
							(GeneralMembersVO) request.getSession().getAttribute("login")
							));
		}
		if (request.getSession().getAttribute("hlogin") != null) {
			request.getSession().setAttribute("hlogin"
					, memberService.oneMemberInfo(
							(HostMembersVO) request.getSession().getAttribute("hlogin")
							));
		}
		
		return "header";
	}
	
	@RequestMapping(value = "/footer.do")
	public String footer() {
		
		return "footer";
	}

	@RequestMapping(value = "/frame.do")
	public String frame() {
		return "frame";
	}
	
	@RequestMapping(value="/serinfo.do")
	public String serinfo(Model model,Integer idx) {
		if(idx == null) {
			idx = 1;
			
		}
		
		ServiceInfoVO vo=boardService.selectOneServiceInfo(idx);
		model.addAttribute("vo",vo);
		
		return "serinfo";
	}
	
	
	@RequestMapping(value="/infoupdate.do")
	public String serinfoUp(ServiceInfoVO vo,HttpServletRequest request) {
		HttpSession session=request.getSession();
		System.out.println(vo.getIdx());
		System.out.println(vo.getContent());
		int result=0;
		
		//로그인했을때
		if(session.getAttribute("login") != null) {
			GeneralMembersVO login=(GeneralMembersVO)session.getAttribute("login");
			
			//권한체크
			if(login.getAuth() == 3) {
				result=boardService.updateServiceInfo(vo);
				System.out.println(result);
				request.setAttribute("msg", "수정완료");
				request.setAttribute("url", "/serinfo.do");
				
				return "alert";
			} else {
				
				request.setAttribute("msg", "권한이 없습니다");
				request.setAttribute("url", "/serinfo.do");
				
				return "alert";
			}
			
		}
		//로그인안했을때
		request.setAttribute("msg", "로그인하세요");
		request.setAttribute("url", "/member/glogin.do");
		
		return "alert";
	}
	//serlist 수정버튼 >> 글 정보 읽어오기
	@RequestMapping(value="/serlistModify.do" ,method=RequestMethod.GET)
	public String serlistModify(Model model,ArticlesVO vo,HttpServletRequest request) {
		HttpSession session=request.getSession();
		if(session.getAttribute("login") != null) {
			GeneralMembersVO login=(GeneralMembersVO)(session.getAttribute("login"));
			
			if(login.getAuth() == 3) {
				
				ArticlesVO vo1=boardService.selectArticles(vo);
				model.addAttribute("vo",vo1);
				
				return "serlistModify";
			} else {
				
				request.setAttribute("msg", "권한이 없습니다");
				request.setAttribute("url", "/serlist.do");
				
				return "alert";
			}
		}
		System.out.println(vo.getaIdx()+","+vo.getbIdx());
		
		request.setAttribute("msg", "로그인하세요");
		request.setAttribute("url", "/member/glogin.do");
		
		return "alert";
	}
	//serviceInfo 수정한 데이터 처리
	@RequestMapping(value="/serlistModify.do", method=RequestMethod.POST)
	public String serlistModify(ArticlesVO vo,HttpServletRequest request) {
		HttpSession session=request.getSession();
		if(session.getAttribute("login") != null) {
			GeneralMembersVO login=(GeneralMembersVO)(session.getAttribute("login"));
			
			if(login.getAuth() == 3) {
				
				int result=boardService.serlistModify(vo);
				
				if(result > 0 ) {
					request.setAttribute("msg", "수정 성공");
					request.setAttribute("url", "/serlist.do?bIdx="+vo.getbIdx());					
					return "alert";
				} else {
					
					request.setAttribute("msg", "수정 실패");
					request.setAttribute("url", "/serlist.do"+vo.getbIdx());	
					return "alert";
				}
						
			} else {
				
				request.setAttribute("msg", "권한이 없습니다");
				request.setAttribute("url", "/serlist.do"+vo.getbIdx());
				
				return "alert";
			}
		}
		
		request.setAttribute("msg", "로그인하세요");
		request.setAttribute("url", "/member/glogin.do");
		
		return "alert";
	}
	
	@RequestMapping(value="/serlist.do",method=RequestMethod.GET)
	public String serlist(Model model, @RequestParam Map<String, Object> map, HttpServletRequest request) {
		if(map.get("bIdx") == null) {
			map.put("bIdx", 1);
		}
		
		List<ArticlesVO> list=boardService.list(map, request);
		System.out.println(list.size());
		model.addAttribute("list",list);
		model.addAttribute("bIdx",map.get("bIdx"));
		
		return "serlist";
		
	}
	
	@RequestMapping(value="/serlistDelete.do")
	@ResponseBody
	public int serlistDelete(ArticlesVO vo,HttpServletRequest request) {
		HttpSession session=request.getSession();
		int result=-2;
		
		if(session.getAttribute("login") != null) {
			GeneralMembersVO login=(GeneralMembersVO)(session.getAttribute("login"));
			
			if(login.getAuth() == 3) {
				
				return boardService.serlistDelete(vo);
			} else {
				
				return -1;
			}
		} 
		
		return -2;
	}
	
	@RequestMapping(value="/serinfoupdate.do", method=RequestMethod.GET)
	public String serinfoupdate(HttpServletResponse response,HttpServletRequest request) throws IOException {
		PrintWriter pw=response.getWriter();
		HttpSession session=request.getSession();
		
		if(session.getAttribute("login") != null) {
			GeneralMembersVO vo=(GeneralMembersVO)session.getAttribute("login");			
			if(vo.getAuth() ==3) {
				return "serinfoupdate";
			} else {
				
				return "redirect:/";
			}
		} else {
			return "redirect:/";			
		}		
			
	}
	
	@RequestMapping(value="/serinfoupdate.do", method=RequestMethod.POST)
	public String serinfoupdate(Model model,ArticlesVO vo) {
		System.out.println(vo.getbIdx());//글쓸때 선택한 게시판 확인
		System.out.println(vo.getmIdx());//글쓸때 관리자 midx인지 확인
		System.out.println(vo.getContent());//글쓴내용 확인
		System.out.println(vo.getTitle());//글쓴제목 확인
		System.out.println(vo.getmNickname());//글쓸때 관리자 닉네임확인
		
		boardService.insertArticlesVO(vo);
		
		
		return "redirect:/serlist.do?bIdx="+vo.getbIdx();
	}
	
	@RequestMapping(value="/messagePopup.do")
	public String messagePopup(Model model,HostMembersVO vo1, GeneralMembersVO vo2,String type,HttpServletRequest request) {
		HttpSession session=request.getSession();
		
		if(session.getAttribute("login") == null && session.getAttribute("hlogin") == null) {
				
			request.setAttribute("msg", "로그인하세요");
			request.setAttribute("url", "/member/glogin.do");
			request.setAttribute("close", 1);
			
			return "alert";
			
		} else if(type.equals("general")){
			GeneralMembersVO vo = memberService.oneMemberInfo(vo2);
			
			model.addAttribute("vo",vo);
			model.addAttribute("type",type);
			
			return "messagePopup";
		} else {
			HostMembersVO vo = memberService.oneMemberInfo(vo1);
			
			model.addAttribute("vo",vo);
			model.addAttribute("type",type);
			
			return "messagePopup";
		}
		
	}
	
	@RequestMapping(value="/messageSend.do")
	@ResponseBody
	public int messageSend(MessagesVO msgVO, HttpServletRequest request) {
		HttpSession session=request.getSession();
		System.out.println(msgVO.toString());
		System.out.println("보낸내용"+msgVO.getContent());
		System.out.println("받는사람"+msgVO.getReceiver());
		System.out.println("받는사람의타입"+msgVO.getReceiverType());
		
		if(session.getAttribute("login") == null && session.getAttribute("hlogin") == null) {
				
			
			return -2;
			
		} else if(session.getAttribute("login") != null){
			GeneralMembersVO vo=(GeneralMembersVO)session.getAttribute("login");
			msgVO.setSender(vo.getmIdx());
			msgVO.setSenderType("general");
			
			
			return memberService.sendMessage(msgVO);
		} else {
			HostMembersVO vo=(HostMembersVO)session.getAttribute("hlogin");
			msgVO.setSender(vo.getmIdx());
			msgVO.setSenderType("host");
			
			return memberService.sendMessage(msgVO);
		}
		
	}
	
	@RequestMapping(value="/deleteMsg.do")
	@ResponseBody
	public int deleteMsg(@RequestParam(value="msgIdx[]")List<String> msgIdx) {
		System.out.println(msgIdx.size());
		System.out.println(msgIdx.toString());
		
		
		return memberService.deleteMsg(msgIdx);
	}
	
	@RequestMapping(value="/readMsg.do")
	@ResponseBody
	public int readMsg(MessagesVO msgVO,HttpServletRequest request) {
		HttpSession session=request.getSession();
		
		if(session.getAttribute("login") == null && session.getAttribute("hlogin") == null) {
				
			
			return -2;
			
		} else if(session.getAttribute("login") != null){
			GeneralMembersVO vo=(GeneralMembersVO)session.getAttribute("login");
			System.out.println(msgVO.getReceiver());
			if(vo.getmIdx() == msgVO.getReceiver()) {
				return memberService.readMsg(msgVO);				
			}
			
			return -2;
		} else {
			HostMembersVO vo=(HostMembersVO)session.getAttribute("hlogin");
			System.out.println(msgVO.getReceiver());
			if(vo.getmIdx() == msgVO.getReceiver()) {
				return memberService.readMsg(msgVO);				
			}
			
			return -2;
		}
		
	}

	@RequestMapping(value = "/uploadPicture.do") // 스마트 에디터 이미지 업로드
	@ResponseBody
	public String profileUpload(HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {
		
		String path = request.getSession().getServletContext().getRealPath("/resources/upload");
		String fileName = file.getOriginalFilename();
		
		String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());

		UUID uuid = UUID.randomUUID();
		String newFileName = uuid.toString() + extension;

		File dir = new File(path);
		if (!dir.exists()) {	// 해당 디렉토리가 존재하지 않는 경우
			dir.mkdirs();				// 경로의 폴더가 없는 경우 상위 폴더에서부터 전부 생성
		}
		
		File target = new File(path, newFileName);
		
		file.transferTo(target);
		
		return "/upload/" + newFileName;
	}
}
