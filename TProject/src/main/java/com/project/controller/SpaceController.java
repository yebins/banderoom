package com.project.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.*;

import javax.imageio.ImageIO;
import javax.servlet.http.*;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.project.service.MemberService;
import com.project.service.SpaceService;
import com.project.util.PagingUtil;
import com.project.vo.*;

@Controller
@RequestMapping(value = "/space")
public class SpaceController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private SpaceService spaceService;
	
	@RequestMapping(value = "/register.do", method = RequestMethod.GET)
	public String register(HttpServletRequest request) {
		
		if (request.getSession().getAttribute("hlogin") == null) {
			return "redirect:/";
		}
		return "space/register";
	}
	
	@RequestMapping(value= "/register.do", method = RequestMethod.POST)
	public String register(SpacesVO vo, String[] src, String[] thumbSrc) {

		if (thumbSrc != null && thumbSrc.length != 0) {
			vo.setThumb(thumbSrc[0]);
		}
		
		int result = spaceService.spaceReg(vo, src, thumbSrc);
		
		if (result > 0) {
			return "redirect:/space/myspace.do";
		} else {
			return null;
		}
	}

	@RequestMapping(value= "/update.do", method = RequestMethod.POST)
	public String update(HttpServletRequest request, Model model, SpacesVO vo, String[] src, String[] thumbSrc) {


		
		if (request.getSession().getAttribute("hlogin") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/hlogin.do");
			
			return "alert";
		} else {
			
			if (((HostMembersVO) request.getSession().getAttribute("hlogin")).getmIdx() == vo.getHostIdx()) {

				if (thumbSrc != null && thumbSrc.length != 0) {
					vo.setThumb(thumbSrc[0]);
				}
				
				int result = spaceService.update(vo, src, thumbSrc);
				
				if (result > 0) {
					return "redirect:/space/details.do?idx=" + vo.getIdx();
				} else {
					return null;
				}
				
				
			} else {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/space/details.do?idx=" + vo.getIdx());
				
				return "alert";
			}
		}
	}
	

	@RequestMapping(value = "/uploadPicture.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> uploadPicture(HttpServletRequest request, @RequestParam("picture") MultipartFile file, int thumbWidth, int thumbHeight) throws Exception {
		
		Map<String, String> pictures = new HashMap<String, String>();
		
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

    makeThumbnail(target.getAbsolutePath(), uuid.toString(), extension.substring(1), path, thumbWidth, thumbHeight);
    
    String original = "/upload/" + newFileName;
    String thumb = "/upload/THUMB_" + newFileName;
    
    pictures.put("original", original);
    pictures.put("thumb", thumb);
		
		return pictures;
	}

	private void makeThumbnail(String filePath, String fileName, String fileExt, String path, int width, int height) throws Exception {

		// 저장된 원본파일로부터 BufferedImage 객체를 생성합니다.
		BufferedImage srcImg = ImageIO.read(new File(filePath));

		// 썸네일의 너비와 높이 입니다.
		int dw = width, dh = height;

		// 원본 이미지의 너비와 높이 입니다.
		int ow = srcImg.getWidth();
		int oh = srcImg.getHeight();

		// 원본 너비를 기준으로 하여 썸네일의 비율로 높이를 계산합니다.
		int nw = ow; int nh = (ow * dh) / dw;

		// 계산된 높이가 원본보다 높다면 crop이 안되므로
		// 원본 높이를 기준으로 썸네일의 비율로 너비를 계산합니다.
		if(nh > oh) {
			nw = (oh * dw) / dh;
			nh = oh;
		}

		// 계산된 크기로 원본이미지를 가운데에서 crop 합니다.
		BufferedImage cropImg = Scalr.crop(srcImg, (ow-nw)/2, (oh-nh)/2, nw, nh);

		// crop된 이미지로 썸네일을 생성합니다.
		BufferedImage destImg = Scalr.resize(cropImg, dw, dh);

		// 썸네일을 저장합니다. 이미지 이름 앞에 "THUMB_" 를 붙여 표시했습니다.
		String thumbName = path + "\\THUMB_" + fileName + "." + fileExt;
		File thumbFile = new File(thumbName);
		
		ImageIO.write(destImg, fileExt.toUpperCase(), thumbFile);
	}
	
	@RequestMapping(value = "/myspace.do")
	public String myspace(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("hlogin") != null) {
			model.addAttribute("spacesVOs", spaceService.getSpaceList(((HostMembersVO) session.getAttribute("hlogin")).getmIdx()));
		} else if (session.getAttribute("login") != null) {
			if (((GeneralMembersVO) session.getAttribute("login")).getAuth() == 3) {
				model.addAttribute("spacesVOs", spaceService.getSpaceList(0));
			}
		}
		
		return "space/myspace";
	}
	
	@RequestMapping(value = "/getlocations.do")
	@ResponseBody
	public List<LocationsVO> getLocations() {
		return spaceService.getLocations();
	}

	@RequestMapping(value = "/details.do")
	public String details(Model model, SpacesVO vo, HttpServletRequest request) {
		
		vo = spaceService.details(vo);
		
		// 리뷰 목록 불러오기
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("spacesVO", vo);
		
		int reviewPage = 1;
		String orderType = "regDateDesc";
		
		params.put("orderType", orderType);
		
		PagingUtil reviewPu = new PagingUtil(
				Integer.parseInt(
						String.valueOf(
								spaceService.spaceReviewCntAvg(
										(SpacesVO) params.get("spacesVO")).get("count")))
				, reviewPage, 5, 10);
		
		params.put("start", reviewPu.getStart() - 1);
		
		List<SpaceReviewVO> reviewList = spaceService.spaceReviewList(params);
		
		Iterator<SpaceReviewVO> reviewIterator = reviewList.iterator();
		
		while(reviewIterator.hasNext()) {
			SpaceReviewVO reviewVO = reviewIterator.next();
			
			reviewVO.setContent(reviewVO.getContent().replaceAll("\r\n", "<br>"));
		}
		
		model.addAttribute("reviewLastPage", reviewPu.getLastPage());
		model.addAttribute("spacesVO", vo);
		model.addAttribute("spacePicturesVOs", spaceService.spacePictureList(vo));
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("reviewCntAvg", spaceService.spaceReviewCntAvg(vo));
		
		// qna 목록 불러오기
		params = new HashMap<String, Object>();

		PagingUtil qnaPu = new PagingUtil(spaceService.countQna(vo), 1, 5, 5);
		
		params.put("start", qnaPu.getStart() - 1);
		params.put("spacesVO", vo);
		
		List<SpaceQnaVO> qnaList = spaceService.qnaList(params);

		// 비공개 처리: 자신이 등록한 공간일 경우 모두 공개
		// 로그인 안 된 경우에는 비공개 글 모두 비공개
		// 일반 회원 로그인 된 경우에는 자신 글 빼고 비공개
		HostMembersVO hlogin = new HostMembersVO();
		if (request.getSession().getAttribute("hlogin") != null)  {
			hlogin = (HostMembersVO) request.getSession().getAttribute("hlogin");
		}
		
		if (vo.getHostIdx() != hlogin.getmIdx()) {
			if (request.getSession().getAttribute("login") == null) {
				Iterator<SpaceQnaVO> qnaIterator = qnaList.iterator();
				
				while(qnaIterator.hasNext()) {
					SpaceQnaVO qnaVO = qnaIterator.next();
					
					if (qnaVO.getPublicYN().equals("N")) {
						qnaVO.setContent("비공개 질문입니다.");
						if (qnaVO.getAnswer() != null) {
							qnaVO.setAnswer("비공개 답변입니다.");
						}
					}
					qnaVO.setContent(qnaVO.getContent().replaceAll("\r\n", "<br>"));
				}
			} else {
				GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
				
				Iterator<SpaceQnaVO> qnaIterator = qnaList.iterator();
				
				while(qnaIterator.hasNext()) {
					SpaceQnaVO qnaVO = qnaIterator.next();
					
					if (qnaVO.getPublicYN().equals("N") && qnaVO.getmIdx() != login.getmIdx()) {
						qnaVO.setContent("비공개 질문입니다.");
						if (qnaVO.getAnswer() != null) {
							qnaVO.setAnswer("비공개 답변입니다.");
						}
					}
					qnaVO.setContent(qnaVO.getContent().replaceAll("\r\n", "<br>"));
				}
			}
		}
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("qnaStartPage", qnaPu.getStartPage());
		model.addAttribute("qnaEndPage", qnaPu.getEndPage());
		model.addAttribute("qnaLastPage", qnaPu.getLastPage());
		
		return "space/details";
	}
	
	@RequestMapping(value = "loadReview.do")
	public String loadReview(Model model, Integer reviewPage, String orderType, SpacesVO vo) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("spacesVO", vo);
		params.put("orderType", orderType);
		
		PagingUtil reviewPu = new PagingUtil(
				Integer.parseInt(
						String.valueOf(
								spaceService.spaceReviewCntAvg(
										(SpacesVO) params.get("spacesVO")).get("count")))
				, reviewPage, 5, 10);
		
		params.put("start", reviewPu.getStart() - 1);

		List<SpaceReviewVO> reviewList = spaceService.spaceReviewList(params);
		
		Iterator<SpaceReviewVO> reviewIterator = reviewList.iterator();
		
		while(reviewIterator.hasNext()) {
			SpaceReviewVO reviewVO = reviewIterator.next();
			
			reviewVO.setContent(reviewVO.getContent().replaceAll("\r\n", "<br>"));
		}

		model.addAttribute("reviewLastPage", reviewPu.getLastPage());
		model.addAttribute("spacesVO", vo);
		model.addAttribute("spacePicturesVOs", spaceService.spacePictureList(vo));
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("reviewCntAvg", spaceService.spaceReviewCntAvg(vo));
		
		return "space/reviewpages";
	}

	@RequestMapping(value = "/delete.do")
	public String delete(Model model, HttpServletRequest request, SpacesVO vo) {
		
		if (request.getSession().getAttribute("hlogin") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/hlogin.do");
			
			return "alert";
		} else {
			
			vo = spaceService.details(vo);
			
			if (((HostMembersVO) request.getSession().getAttribute("hlogin")).getmIdx() == vo.getHostIdx()) {
				
				spaceService.delete(vo);
				
				return "redirect:/space/myspace.do";
			} else {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/space/details.do?idx=" + vo.getIdx());
				
				return "alert";
			}
		}
	}

	@RequestMapping(value = "/update.do", method = RequestMethod.GET)
	public String update(Model model, HttpServletRequest request, SpacesVO vo) {

		if (request.getSession().getAttribute("hlogin") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/hlogin.do");
			
			return "alert";
		} else {
			
			vo = spaceService.details(vo);
			
			if (((HostMembersVO) request.getSession().getAttribute("hlogin")).getmIdx() == vo.getHostIdx()) {
				
				// 작은따옴표가 들어가면 깨져서 이스케이프 문자로 치환
				vo.setName(vo.getName().replaceAll("'", "\\\\'"));
				vo.setAddressDetail(vo.getAddressDetail().replaceAll("'", "\\\\'"));
				vo.setInfo(vo.getInfo().replaceAll("'", "\\\\'"));
				vo.setFacility(vo.getFacility().replaceAll("'", "\\\\'"));
				vo.setCaution(vo.getCaution().replaceAll("'", "\\\\'"));
				
				model.addAttribute("spacesVO", vo);
				model.addAttribute("spacePicturesVOs", spaceService.spacePictureList(vo));
				
				return "space/update";
			} else {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/space/details.do?idx=" + vo.getIdx());
				
				return "alert";
			}
		}
	}

	@RequestMapping(value = "/getlikedstatus.do")
	@ResponseBody
	public int getLikedStatus(LikedSpacesVO vo) {
		return spaceService.getLikedStatus(vo);
	}

	@RequestMapping(value = "/likespace.do")
	@ResponseBody
	public int likeSpace(LikedSpacesVO vo) {
		return spaceService.likeSpace(vo);
	}

	@RequestMapping(value = "/unlikespace.do")
	@ResponseBody
	public int unlikeSpace(LikedSpacesVO vo) {
		return spaceService.unlikeSpace(vo);
	}
	
	@RequestMapping(value = "/acceptSpace.do")
	public String acceptSpace(HttpServletRequest request, Model model, SpacesVO vo) {
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		} else {
			
			if (((GeneralMembersVO) request.getSession().getAttribute("login")).getAuth() == 3) {
				
				spaceService.acceptSpace(vo);
				
				return "redirect:/space/details.do?idx=" + vo.getIdx();
			} else {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/space/details.do?idx=" + vo.getIdx());
				
				return "alert";
			}
		}
	}

	@RequestMapping(value = "/refuseSpace.do")
	public String refuseSpace(HttpServletRequest request, Model model, SpacesVO vo) {
		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		} else {
			
			if (((GeneralMembersVO) request.getSession().getAttribute("login")).getAuth() == 3) {
				
				spaceService.refuseSpace(vo);
				
				return "redirect:/space/details.do?idx=" + vo.getIdx();
			} else {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/space/details.do?idx=" + vo.getIdx());
				
				return "alert";
			}
		}
	}

	@RequestMapping(value = "/requestaccept.do")
	public String requestAccpet(Model model, HttpServletRequest request, SpacesVO vo) {
		
		if (request.getSession().getAttribute("hlogin") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/hlogin.do");
			
			return "alert";
		} else {
			
			vo = spaceService.details(vo);
			
			if (((HostMembersVO) request.getSession().getAttribute("hlogin")).getmIdx() == vo.getHostIdx()) {
				
				spaceService.requestAccpet(vo);
				
				return  "redirect:/space/details.do?idx=" + vo.getIdx();
			} else {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/space/details.do?idx=" + vo.getIdx());
				
				return "alert";
			}
		}
	}
	
	@RequestMapping(value = "/list.do")
	public String list(Model model, HttpServletRequest request, Integer page, Integer search, String orderType, Integer liked, SpacesVO vo) {
		
		Map<String, Object> params = new HashMap<>();
		if (page == null) {
			page = 1;
		}
		int start = page * 12 - 12;
		
		if (search != null) {
			params.put("vo", vo);
		}
		params.put("start", start);
		
		params.put("likedMidx", 0);
		if (request.getSession().getAttribute("login") != null) {
			params.put("likedMidx", ((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
		}
		
		if (orderType == null) {
			orderType = "review";
		}
		params.put("orderType", orderType);
		
		if (liked == null) {
			liked = 0;
		}
		params.put("liked", liked);
		
		List<SpacesVO> spaceList = spaceService.spaceList(params);
		model.addAttribute("spaceList", spaceList);
		
		return "space/list";
	}
	
	@RequestMapping(value = "addlist.do")
	public String addList(Model model, HttpServletRequest request, Integer page, Integer search, String orderType, Integer liked, SpacesVO vo) {

		Map<String, Object> params = new HashMap<>();
		if (page == null) {
			page = 1;
		}
		int start = page * 12 - 12;
		
		if (search != null) {
			params.put("vo", vo);
		}
		params.put("start", start);
		
		params.put("likedMidx", 0);
		if (request.getSession().getAttribute("login") != null) {
			params.put("likedMidx", ((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
		}
		
		params.put("orderType", orderType);
		params.put("liked", liked);
		
		List<SpacesVO> spaceList = spaceService.spaceList(params);
		model.addAttribute("spaceList", spaceList);
		
		return "space/listpages";
	}
	
	@RequestMapping(value = "/payment.do", method = RequestMethod.POST)
	public String payment(Model model, HttpServletRequest request, ReservationsVO rsvVO) {

		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		} else {
			
			SpacesVO spacesVO = new SpacesVO();
			spacesVO.setIdx(rsvVO.getSpaceIdx());
			spacesVO = spaceService.details(spacesVO);
			HostMembersVO hostVO = new HostMembersVO();
			hostVO.setmIdx(spacesVO.getHostIdx());
			hostVO = memberService.getHostMember(hostVO);
			rsvVO.setmIdx(((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
			
			request.getSession().setAttribute("login", memberService.oneMemberInfo(
					(GeneralMembersVO) request.getSession().getAttribute("login")));
			
			model.addAttribute("spacesVO", spacesVO);
			model.addAttribute("hostVO", hostVO);
			model.addAttribute("rsvVO", rsvVO);
			
			return "space/payment";
		}		
	}
	
	@RequestMapping(value = "paysuccess.do", method = RequestMethod.POST)
	public String paySuccess(Model model, HttpServletRequest request, ReservationsVO rsvVO) {
		GeneralMembersVO gMemberVO = (GeneralMembersVO) request.getSession().getAttribute("login");
		
		if (spaceService.validateRsv(rsvVO) != 0) {

			model.addAttribute("msg", "이미 예약된 시간대입니다.");
			model.addAttribute("url", "/space/details.do?idx=" + rsvVO.getSpaceIdx());
			
			return "alert";
		}
		
		rsvVO = spaceService.insertRsv(rsvVO);

		SpacesVO spacesVO = new SpacesVO();
		spacesVO.setIdx(rsvVO.getSpaceIdx());
		spacesVO = spaceService.details(spacesVO);
		HostMembersVO hostVO = new HostMembersVO();
		hostVO.setmIdx(spacesVO.getHostIdx());
		hostVO = memberService.getHostMember(hostVO);


		// 포인트 사용 내역
		PointsVO pointsVO = new PointsVO();
		pointsVO.setAmount(-rsvVO.getUsedPoint());
		if (pointsVO.getAmount() != 0) {
			pointsVO.setBalance(gMemberVO.getPoint() + pointsVO.getAmount());
			pointsVO.setContent("공간 예약 사용_" + spacesVO.getName());
			pointsVO.setmIdx(gMemberVO.getmIdx());
			pointsVO.setResIdx(rsvVO.getResIdx());
			spaceService.insertPoint(pointsVO);
			memberService.setPoint(pointsVO);
			gMemberVO = memberService.oneMemberInfo(gMemberVO);
		}
		
		// 포인트 적립 내역
		pointsVO = new PointsVO();
		pointsVO.setAmount((int) Math.round(rsvVO.getTotalCost() * 0.01));
		if (pointsVO.getAmount() != 0) {
			pointsVO.setBalance(gMemberVO.getPoint() + pointsVO.getAmount());
			pointsVO.setContent("공간 예약 적립_" + spacesVO.getName());
			pointsVO.setmIdx(gMemberVO.getmIdx());
			pointsVO.setResIdx(rsvVO.getResIdx());
			spaceService.insertPoint(pointsVO);
			memberService.setPoint(pointsVO);
			gMemberVO = memberService.oneMemberInfo(gMemberVO);
		}

		request.getSession().setAttribute("login", memberService.oneMemberInfo(
				(GeneralMembersVO) request.getSession().getAttribute("login")));
				
		return "redirect:/space/paysuccess.do?resIdx=" + rsvVO.getResIdx();
	}
	
	@RequestMapping(value = "paysuccess.do", method = RequestMethod.GET)
	public String paySuccess(Model model, HttpServletRequest request, int resIdx) {
		GeneralMembersVO gMemberVO = (GeneralMembersVO) request.getSession().getAttribute("login");

		ReservationsVO rsvVO = new ReservationsVO();
		rsvVO.setResIdx(resIdx);
		rsvVO = spaceService.getRSV(rsvVO);
		
		SpacesVO spacesVO = new SpacesVO();
		spacesVO.setIdx(rsvVO.getSpaceIdx());
		spacesVO = spaceService.details(spacesVO);
		HostMembersVO hostVO = new HostMembersVO();
		hostVO.setmIdx(spacesVO.getHostIdx());
		hostVO = memberService.getHostMember(hostVO);

		request.getSession().setAttribute("login", gMemberVO);
		
		model.addAttribute("spacesVO", spacesVO);
		model.addAttribute("hostVO", hostVO);
		model.addAttribute("rsvVO", rsvVO);
		
		return "space/paysuccess";
	}
	
	@RequestMapping(value = "test.do")
	public String test(Model model, ReservationsVO vo) {
		
		vo = spaceService.getRSV(vo);
		
		model.addAttribute("rsvVO", vo);
		
		return "space/test";
	}
	
	@RequestMapping(value="getrsvfulldates.do")
	@ResponseBody
	public List<String> getRsvFullDates(String spaceIdx, String nowDate, String afterMonth) {
		
		Map<String, String> params = new HashMap<String, String>();
		params.put("spaceIdx", spaceIdx);
		params.put("nowDate", nowDate);
		params.put("afterMonth", afterMonth);
		
		return spaceService.getRsvFullDates(params);
	}
	
	@RequestMapping(value = "getrsvhours.do")
	@ResponseBody
	public List<Map<String, String>> getRsvHours(@RequestParam Map<String, String> date) {
		
		return spaceService.getRsvHours(date);
	}
	
	@RequestMapping(value = "myrsv.do")
	public String mySpaceRsv(Model model, String dateType, String dateRange, HttpServletRequest request) {

		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		} else {
			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
			model.addAttribute("currentRsv", spaceService.getCurrentRsv(login));
			
			PagingUtil pastRsvPu = new PagingUtil(spaceService.countPastRsv(login, dateType, dateRange), 1, 10, 5);
			
			List<ReservationsVO> pastRsv = spaceService.getPastRsv(login, dateType, dateRange, pastRsvPu.getStart() - 1);
			Map<Integer, Integer> reviewed = new HashMap<Integer, Integer>();
			Iterator<ReservationsVO> iterator = pastRsv.iterator();
			while(iterator.hasNext()) {
				ReservationsVO rsvVO = iterator.next();
				reviewed.put(rsvVO.getResIdx(), spaceService.isReviewExist(rsvVO));
			}
			model.addAttribute("pastRsv", pastRsv);
			model.addAttribute("reviewed", reviewed);
			model.addAttribute("startPage", pastRsvPu.getStartPage());
			model.addAttribute("endPage", pastRsvPu.getEndPage());
			model.addAttribute("lastPage", pastRsvPu.getLastPage());
			model.addAttribute("today", new Date());
			return "space/myrsv";
		}
	}
	
	@RequestMapping(value = "loadMyRsv.do")
	@ResponseBody
	public Map<String, Object> loadMyRsv(int page, String dateType, String dateRange, HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if (request.getSession().getAttribute("login") == null) {
			return null;
			
		} else {
			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");

			PagingUtil pastRsvPu = new PagingUtil(spaceService.countPastRsv(login, dateType, dateRange), page, 10, 5);
			
			List<ReservationsVO> pastRsv = spaceService.getPastRsv(login, dateType, dateRange, pastRsvPu.getStart() - 1);
			Map<Integer, Integer> reviewed = new HashMap<Integer, Integer>();
			Iterator<ReservationsVO> iterator = pastRsv.iterator();
			while(iterator.hasNext()) {
				ReservationsVO rsvVO = iterator.next();
				reviewed.put(rsvVO.getResIdx(), spaceService.isReviewExist(rsvVO));
			}
			result.put("pastRsv", pastRsv);
			result.put("reviewed", reviewed);
			result.put("startPage", pastRsvPu.getStartPage());
			result.put("endPage", pastRsvPu.getEndPage());
			result.put("lastPage", pastRsvPu.getLastPage());
			result.put("today", new Date());

			return result;
		}
		
	}
	
	@RequestMapping(value = "rsvdetails.do")
	public String resDetails(Model model, HttpServletRequest request, int resIdx) {
		
		GeneralMembersVO gMemberVO = new GeneralMembersVO();
		HostMembersVO hMemberVO = new HostMembersVO();
		
		ReservationsVO rsvVO = new ReservationsVO();
		rsvVO.setResIdx(resIdx);
		rsvVO = spaceService.getRSV(rsvVO);
		
		SpacesVO spacesVO = new SpacesVO();
		spacesVO.setIdx(rsvVO.getSpaceIdx());
		spacesVO = spaceService.details(spacesVO);
		
		HostMembersVO hostVO = new HostMembersVO();
		hostVO.setmIdx(spacesVO.getHostIdx());
		hostVO = memberService.getHostMember(hostVO);


		if (request.getSession().getAttribute("login") == null && request.getSession().getAttribute("hlogin") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		} else if (request.getSession().getAttribute("login") != null) {
			
			gMemberVO = (GeneralMembersVO) request.getSession().getAttribute("login");
			model.addAttribute("gMemberVO", gMemberVO);

		} else if (request.getSession().getAttribute("hlogin") != null) {
			
			hMemberVO = (HostMembersVO) request.getSession().getAttribute("hlogin");
			gMemberVO.setmIdx(rsvVO.getmIdx());
			gMemberVO = memberService.oneMemberInfo(gMemberVO);
			model.addAttribute("gMemberVO", gMemberVO);
		}
		
		if (gMemberVO.getmIdx() != rsvVO.getmIdx() && gMemberVO.getAuth() != 3 && hMemberVO.getmIdx() != spacesVO.getHostIdx()) {

			model.addAttribute("msg", "권한이 없습니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DATE, 1);
		Date nextDay = cal.getTime();
		
		model.addAttribute("spacesVO", spacesVO);
		model.addAttribute("hostVO", hostVO);
		model.addAttribute("rsvVO", rsvVO);
		model.addAttribute("nextDay", nextDay);
		model.addAttribute("today", new Date());
		
		return "space/rsvdetails";
		
	}
	
	@RequestMapping(value = "review.do", method = RequestMethod.GET)
	public String spaceReview(Model model, ReservationsVO vo, HttpServletRequest request) {
		
		model.addAttribute("rsvVO", spaceService.getRSV(vo));
		return "space/review";
	}
	
	@RequestMapping(value = "review.do", method = RequestMethod.POST, headers = ("content-type=multipart/*"))
	@ResponseBody
	public int spaceReview(SpaceReviewVO vo, @RequestParam(value = "picture") MultipartFile picture, HttpServletRequest request) throws Exception {
		
		if (request.getSession().getAttribute("login") == null) {
			return 1; // 로그인 안 됨
		} else {
			
			if (picture.getSize() != 0) {

				Map<String, String> pictureSrc = uploadPicture(request, picture, 200, 200);
				
			  vo.setPictureSrc(pictureSrc.get("original"));
			  vo.setThumbSrc(pictureSrc.get("thumb"));
			  
			}
			
		  GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
		  
		  vo.setmIdx(login.getmIdx());
		  vo.setmNickname(login.getNickname());

		  int result = spaceService.insertReview(vo);
		  
		  if (result > 0) {
		  	return 0; // 정상 입력		  	
		  } else {
		  	return 2; // 입력 오류
		  }
		}
	}
	
	@RequestMapping(value="insertqnaq.do")
	@ResponseBody
	public int insertQnaQ(SpaceQnaVO vo, Integer privateChecked, HttpServletRequest request) {
		
		if (request.getSession().getAttribute("login") == null) {
			return 1; // 로그인 안 됨
		} else {
			
			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
			
			vo.setmIdx(login.getmIdx());
			vo.setmNickname(login.getNickname());
			
			if (privateChecked != null) {
				vo.setPublicYN("N");
			} else {
				vo.setPublicYN("Y");
			}
			
			int result = spaceService.insertQnaQ(vo);
			
			if (result > 0) {
				return 0; // 정상 입력
			} else {
				return 2; // 입력 오류
			}
			
		}
	}
	
	@RequestMapping(value = "qnalist.do")
	public String qnaList(Model model, HttpServletRequest request, Integer page, SpacesVO spacesVO) {
		
		spacesVO = spaceService.details(spacesVO);
		Map<String, Object> params = new HashMap<String, Object>();

		PagingUtil qnaPu = new PagingUtil(spaceService.countQna(spacesVO), page, 5, 5);
		
		params.put("start", qnaPu.getStart() - 1);
		params.put("spacesVO", spacesVO);
		
		List<SpaceQnaVO> qnaList = spaceService.qnaList(params);
		
		
		// 비공개 처리: 자신이 등록한 공간일 경우 모두 공개
		// 로그인 안 된 경우에는 비공개 글 모두 비공개
		// 일반 회원 로그인 된 경우에는 자신 글 빼고 비공개
		HostMembersVO hlogin = new HostMembersVO();
		if (request.getSession().getAttribute("hlogin") != null)  {
			hlogin = (HostMembersVO) request.getSession().getAttribute("hlogin");
		}
		
		if (spacesVO.getHostIdx() != hlogin.getmIdx()) {
			if (request.getSession().getAttribute("login") == null) {
				Iterator<SpaceQnaVO> qnaIterator = qnaList.iterator();
				
				while(qnaIterator.hasNext()) {
					SpaceQnaVO qnaVO = qnaIterator.next();
					
					if (qnaVO.getPublicYN().equals("N")) {
						qnaVO.setContent("비공개 질문입니다.");
						if (qnaVO.getAnswer() != null) {
							qnaVO.setAnswer("비공개 답변입니다.");
						}
					}
					
					qnaVO.setContent(qnaVO.getContent().replaceAll("\r\n", "<br>"));
					
				}
			} else {
				GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
				
				Iterator<SpaceQnaVO> qnaIterator = qnaList.iterator();
				
				while(qnaIterator.hasNext()) {
					SpaceQnaVO qnaVO = qnaIterator.next();
					
					if (qnaVO.getPublicYN().equals("N") && qnaVO.getmIdx() != login.getmIdx()) {
						qnaVO.setContent("비공개 질문입니다.");
						if (qnaVO.getAnswer() != null) {
							qnaVO.setAnswer("비공개 답변입니다.");
						}
					}

					qnaVO.setContent(qnaVO.getContent().replaceAll("\r\n", "<br>"));
				}
			}
		}
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("qnaNowPage", qnaPu.getNowPage());
		model.addAttribute("qnaStartPage", qnaPu.getStartPage());
		model.addAttribute("qnaEndPage", qnaPu.getEndPage());
		model.addAttribute("qnaLastPage", qnaPu.getLastPage());
		
		return "space/qnapages";
	}
	
	@RequestMapping(value = "insertqnaanswer.do")
	@ResponseBody
	public int insertQnaAnswer(SpaceQnaVO qnaVO, HttpServletRequest request) {
		
		SpacesVO spacesVO = new SpacesVO();
		spacesVO.setIdx(qnaVO.getSpaceIdx());
		spacesVO = spaceService.details(spacesVO);
		
		if (request.getSession().getAttribute("hlogin") == null)  {
			return 1; // 로그인 안 됨
		}
		
		int hostIdx = ((HostMembersVO) request.getSession().getAttribute("hlogin")).getmIdx();
		
		if (spacesVO.getHostIdx() != hostIdx) {
			return 2; // 권한 없음
		} 
		
		int result = spaceService.insertQnaA(qnaVO);
		
		if (result > 0) {
			return 0; // 정상 등록
		} else {
			return 3; // 등록 오류
		}
	}
	

	@RequestMapping(value = "deleteqnaanswer.do")
	@ResponseBody
	public int deleteQnaAnswer(SpaceQnaVO qnaVO, HttpServletRequest request) {
		
		SpacesVO spacesVO = new SpacesVO();
		spacesVO.setIdx(qnaVO.getSpaceIdx());
		spacesVO = spaceService.details(spacesVO);
		
		if (request.getSession().getAttribute("hlogin") == null)  {
			return 1; // 로그인 안 됨
		}
		
		int hostIdx = ((HostMembersVO) request.getSession().getAttribute("hlogin")).getmIdx();
		
		if (spacesVO.getHostIdx() != hostIdx) {
			return 2; // 권한 없음
		} 
		
		int result = spaceService.deleteQnaA(qnaVO);
		
		if (result > 0) {
			return 0; // 정상 등록
		} else {
			return 3; // 등록 오류
		}
	}
	
	@RequestMapping (value = "deleteqna.do")
	@ResponseBody
	public int deleteQna(SpaceQnaVO qnaVO, HttpServletRequest request) {
		
		qnaVO = spaceService.qnaInfo(qnaVO);

		if (request.getSession().getAttribute("login") == null)  {
			return 1; // 로그인 안 됨
		}
		
		int loginIdx = ((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx();
		
		if (qnaVO.getmIdx() != loginIdx) {
			return 2; // 권한 없음
		}
		
		int result = spaceService.deleteQna(qnaVO);

		if (result > 0) {
			return 0; // 정상 등록
		} else {
			return 3; // 등록 오류
		}
	}
	

	@RequestMapping(value="updateqnaq.do")
	@ResponseBody
	public int updateQnaQ(SpaceQnaVO vo, Integer privateChecked, HttpServletRequest request) {
		
		if (request.getSession().getAttribute("login") == null) {
			return 1; // 로그인 안 됨
		} else {

			int loginIdx = ((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx();
			
			SpaceQnaVO original = spaceService.qnaInfo(vo);
			
			if (original.getmIdx() != loginIdx) {
				return 2; // 권한 없음
			}
			
			if (privateChecked != null) {
				vo.setPublicYN("N");
			} else {
				vo.setPublicYN("Y");
			}
			
			int result = spaceService.updateQnaQ(vo);
			
			if (result > 0) {
				return 0; // 정상 입력
			} else {
				return 3; // 입력 오류
			}
			
		}
	}
	
	@RequestMapping(value = "deletereview.do")
	@ResponseBody
	public int deleteReview(SpaceReviewVO vo, HttpServletRequest request) {
		
		vo = spaceService.getReviewInfo(vo);
		
		if (request.getSession().getAttribute("login") == null) {
			return 1; // 로그인 안 됨
		} else {

			int loginIdx = ((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx();
			
			if (vo.getmIdx() != loginIdx) {
				return 2; // 권한 없음
			}
			
			int result = spaceService.deleteReview(vo);
			
			if (result > 0) {
				return 0; // 정상 입력
			} else {
				return 3; // 삭제 오류
			}
		}
	}
	
	@RequestMapping(value = "reviewupdate.do", method = RequestMethod.GET)
	public String reviewUpdate(Model model, ReservationsVO vo, HttpServletRequest request) {
		SpaceReviewVO reviewVO = new SpaceReviewVO();
		reviewVO.setResIdx(vo.getResIdx());
		model.addAttribute("reviewVO", spaceService.getReviewInfo(reviewVO));
		model.addAttribute("rsvVO", spaceService.getRSV(vo));
		return "space/reviewupdate";
	}
	
	@RequestMapping(value = "reviewupdate.do", method = RequestMethod.POST)
	@ResponseBody
	public int reviewUpdate(SpaceReviewVO vo, @RequestParam(value = "picture") MultipartFile picture, int fileChanged, HttpServletRequest request) throws Exception {
		
		SpaceReviewVO original = spaceService.getReviewInfo(vo);
		
		vo.setPictureSrc(original.getPictureSrc());
		vo.setThumbSrc(original.getThumbSrc());
		
		if (request.getSession().getAttribute("login") == null) {
			return 1; // 로그인 안 됨
		} else {

			int loginIdx = ((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx();
			
			if (original.getmIdx() != loginIdx) {
				return 2; // 권한 없음
			}
			
			if (fileChanged == 1) {
				
				if (picture.getSize() != 0) {
	
					Map<String, String> pictureSrc = uploadPicture(request, picture, 200, 200);
					
				  vo.setPictureSrc(pictureSrc.get("original"));
				  vo.setThumbSrc(pictureSrc.get("thumb"));
				  
				} else {
				  vo.setPictureSrc(null);
				  vo.setThumbSrc(null);
				}
			
			}
			
		  GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
		  
		  vo.setmIdx(login.getmIdx());
		  vo.setmNickname(login.getNickname());

		  int result = spaceService.updateReview(vo);
		  
		  if (result > 0) {
		  	return 0; // 정상 입력		  	
		  } else {
		  	return 3; // 입력 오류
		  }
		}
	}
	
	@RequestMapping(value = "myspacersv.do")
	public String mySpaceRsv(Model model, SpacesVO vo, String dateType, String dateRange, HttpServletRequest request) {
		
		vo = spaceService.details(vo);

		GeneralMembersVO glogin = new GeneralMembersVO();
		HostMembersVO hlogin = new HostMembersVO();
		
		if (request.getSession().getAttribute("login") != null) {
			glogin = (GeneralMembersVO) request.getSession().getAttribute("login");
		}
		
		if (request.getSession().getAttribute("hlogin") != null) {
			hlogin = (HostMembersVO) request.getSession().getAttribute("hlogin");
		}
		
		boolean auth = false;
		
		if (glogin.getAuth() == 3) {
			auth = true;
		}
		
		if (hlogin.getmIdx() == vo.getHostIdx()) {
			auth = true;
		}
		
		if (auth) {
			PagingUtil pastRsvPu = new PagingUtil(spaceService.countRsvBySpace(vo, dateType, dateRange), 1, 10, 5);
			
			List<ReservationsVO> pastRsv = spaceService.getRsvBySpace(vo, dateType, dateRange, pastRsvPu.getStart() - 1);

			Iterator<ReservationsVO> rsvIterator = pastRsv.iterator();
			
			Map<Integer, GeneralMembersVO> gmVOList = new HashMap<Integer, GeneralMembersVO>();
			
			while (rsvIterator.hasNext()) {
				ReservationsVO rsvVO = rsvIterator.next();
				GeneralMembersVO gmVO = new GeneralMembersVO();
				gmVO.setmIdx(rsvVO.getmIdx());
				gmVOList.put(rsvVO.getResIdx(), memberService.oneMemberInfo(gmVO));
			}
			
			model.addAttribute("pastRsv", pastRsv);
			model.addAttribute("startPage", pastRsvPu.getStartPage());
			model.addAttribute("endPage", pastRsvPu.getEndPage());
			model.addAttribute("lastPage", pastRsvPu.getLastPage());
			model.addAttribute("gmVOList", gmVOList);
			model.addAttribute("today", new Date());
			return "space/myspacersv";
		} else {
			model.addAttribute("msg", "조회 권한이 없습니다.");
			model.addAttribute("url", "/member/hlogin.do");
			
			return "alert";
		}
	}
	
	@RequestMapping(value = "loadMySpaceRsv.do")
	@ResponseBody
	public Map<String, Object> loadMySpaceRsv(int page, SpacesVO vo, String dateType, String dateRange, HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<String, Object>();
	
		PagingUtil pastRsvPu = new PagingUtil(spaceService.countRsvBySpace(vo, dateType, dateRange), page, 10, 5);
		
		List<ReservationsVO> pastRsv = spaceService.getRsvBySpace(vo, dateType, dateRange, pastRsvPu.getStart() - 1);

		Iterator<ReservationsVO> rsvIterator = pastRsv.iterator();
		
		Map<Integer, GeneralMembersVO> gmVOList = new HashMap<Integer, GeneralMembersVO>();
		
		while (rsvIterator.hasNext()) {
			ReservationsVO rsvVO = rsvIterator.next();
			GeneralMembersVO gmVO = new GeneralMembersVO();
			gmVO.setmIdx(rsvVO.getmIdx());
			gmVOList.put(rsvVO.getResIdx(), memberService.oneMemberInfo(gmVO));
		}
		
		result.put("pastRsv", pastRsv);
		result.put("startPage", pastRsvPu.getStartPage());
		result.put("endPage", pastRsvPu.getEndPage());
		result.put("lastPage", pastRsvPu.getLastPage());
		result.put("gmVOList", gmVOList);
		result.put("today", new Date());
	
		return result;
	}
	
	@RequestMapping(value = "mypoint.do")
	public String myPoint(Model model, HttpServletRequest request, String dateRange) {

		if (request.getSession().getAttribute("login") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		} else {
			GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
			PagingUtil pu = new PagingUtil(spaceService.countPointHistory(login, dateRange), 1, 10, 5);
			
			model.addAttribute("pointVO", spaceService.pointHistory(login, dateRange, pu.getStart() - 1));
			model.addAttribute("startPage", pu.getStartPage());
			model.addAttribute("endPage", pu.getEndPage());
			model.addAttribute("lastPage", pu.getLastPage());
			
			return "space/mypoint";
		}
	}
	
	@RequestMapping(value = "loadmypoint.do")
	@ResponseBody
	public Map<String, Object> loadMyPoint(HttpServletRequest request, Integer page, String dateRange) {
		
		Map<String, Object> data = new HashMap<String, Object>();

		GeneralMembersVO login = (GeneralMembersVO) request.getSession().getAttribute("login");
		PagingUtil pu = new PagingUtil(spaceService.countPointHistory(login, dateRange), page, 10, 5);
		
		data.put("pointVO", spaceService.pointHistory(login, dateRange, pu.getStart() - 1));
		data.put("startPage", pu.getStartPage());
		data.put("endPage", pu.getEndPage());
		data.put("lastPage", pu.getLastPage());
		
		return data;
		
	}
	
	public String calculation(Model model, HostMembersVO hMemberVO, HttpServletRequest request) {

		GeneralMembersVO gMemberVO = new GeneralMembersVO();

		if (request.getSession().getAttribute("login") == null && request.getSession().getAttribute("hlogin") == null) {

			model.addAttribute("msg", "로그인이 필요합니다.");
			model.addAttribute("url", "/member/glogin.do");
			
			return "alert";
		} else if (request.getSession().getAttribute("login") != null) {
			
			gMemberVO = (GeneralMembersVO) request.getSession().getAttribute("login");
			request.getSession().setAttribute("login", memberService.oneMemberInfo((GeneralMembersVO) request.getSession().getAttribute("login")));
			
			if (gMemberVO.getAuth() != 3) {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/");
				
				return "alert";
			}

		} else if (request.getSession().getAttribute("hlogin") != null) {
			
			HostMembersVO hlogin = (HostMembersVO) request.getSession().getAttribute("hlogin");
			if (hMemberVO.getmIdx() != hlogin.getmIdx()) {

				model.addAttribute("msg", "권한이 없습니다.");
				model.addAttribute("url", "/");
				
				return "alert";
			}
			
		}
		
		return "space/calculation";
	}
	
	@RequestMapping(value = "cancelRsv.do", method = RequestMethod.POST)
	@ResponseBody
	public int cancelRsv(HttpServletRequest request, ReservationsVO rsvVO) {

		GeneralMembersVO gLogin = new GeneralMembersVO();
		rsvVO = spaceService.getRSV(rsvVO);
		
		if (request.getSession().getAttribute("login") == null && request.getSession().getAttribute("hlogin") == null) {
			return 1; // 로그인 안 됨
		} else if (request.getSession().getAttribute("login") != null) {
			gLogin = (GeneralMembersVO) request.getSession().getAttribute("login");
			if (rsvVO.getmIdx() != gLogin.getmIdx() && gLogin.getAuth() != 3) {
				return 2; // 권한 없음
			}
		} else if (request.getSession().getAttribute("hlogin") != null) {
			HostMembersVO hLogin = (HostMembersVO) request.getSession().getAttribute("hlogin");
			if (rsvVO.getHostIdx() != hLogin.getmIdx()) {
				return 2; // 권한 없음
			}
		}
		
		
		List<PointsVO> pointList = spaceService.pointInfo(rsvVO);
		
		Iterator<PointsVO> pointIterator = pointList.iterator();
		
		
		while(pointIterator.hasNext()) {
			GeneralMembersVO resMember = new GeneralMembersVO();
			resMember.setmIdx(rsvVO.getmIdx());
			resMember = memberService.oneMemberInfo(resMember);
			
			PointsVO pointsVO = pointIterator.next();
			PointsVO refund = new PointsVO();
			refund.setResIdx(rsvVO.getResIdx());
			refund.setmIdx(rsvVO.getmIdx());
						
			refund.setContent("공간 예약 취소_" + rsvVO.getName());
			refund.setAmount(- pointsVO.getAmount());
			refund.setBalance(resMember.getPoint() + refund.getAmount());
			
			spaceService.insertPoint(refund);
			memberService.setPoint(refund);
			
		}
		
		spaceService.cancelRsv(rsvVO);
		
		return 0; // 정상 취소
	}
	
	/*
	@RequestMapping(value="setlist.do")
	public String setListData() {
		SpacesVO vo = new SpacesVO();
		String[] thumbSrc = {"THUMB_3896211e-5540-43e4-9a6b-17fac70d9da3.jpg"};
		String[] src = {"3896211e-5540-43e4-9a6b-17fac70d9da3.jpg"};
		
		int result = 0;
		
		// 랜덤값 넣기
		//타입
		String[] type = {"녹음실", "밴드연습실", "댄스연습실"};
		
		//주소
		LocationsVO loc = new LocationsVO();
		List<String> addr1s = spaceService.getAddr1();
		
		for (int i = 0; i < 100; i++) {
			
			vo.setType(type[(int) (Math.random() * type.length)]);
			vo.setName("테스트용 공간");
			
			String addr1 = addr1s.get((int) (Math.random() * addr1s.size()));
			loc.setAddr1(addr1);
			List<String> addr2s = spaceService.getAddr2(loc);
			String addr2 = addr2s.get((int) (Math.random() * addr2s.size()));
			
			vo.setAddress(addr1 + " " + addr2);
			vo.setAddr1(addr1);
			vo.setAddr2(addr2);
			vo.setInfo("테스트용 공간의 기본정보입니다.");
			vo.setCaution("테스트용 공간의 주의사항입니다.");
			vo.setFacility("테스트용 공간의 시설정보입니다.");
			vo.setCost(5000);
			vo.setHostIdx(1);
			

			if (thumbSrc != null && thumbSrc.length != 0) {
				vo.setThumb(thumbSrc[0]);
			}
			
			result = spaceService.spaceReg(vo, src, thumbSrc);
			System.out.println(result);
		}
		
		return "redirect:/";
		
	}
	*/
}
