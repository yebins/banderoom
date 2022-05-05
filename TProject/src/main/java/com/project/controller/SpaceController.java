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
	public Map<String, String> profileUpload(HttpServletRequest request, @RequestParam("picture") MultipartFile file) throws Exception {
		
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

    makeThumbnail(target.getAbsolutePath(), uuid.toString(), extension.substring(1), path, 200, 150);
    
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
	public String details(Model model, SpacesVO vo) {
		model.addAttribute("spacesVO", spaceService.details(vo));
		model.addAttribute("spacePicturesVOs", spaceService.spacePictureList(vo));
		
		return "space/details";
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
	public String list(Model model, HttpServletRequest request, Integer page, Integer search, SpacesVO vo) {
		
		Map<String, Object> params = new HashMap<>();
		if (page == null) {
			page = 1;
		}
		int start = page * 12 - 11;
		int end = page * 12;
		
		if (search != null) {
			params.put("vo", vo);
		}
		params.put("start", start);
		params.put("end", end);
		
		
		List<SpacesVO> spaceList = spaceService.spaceList(params);
		model.addAttribute("spaceList", spaceList);
		
		Map<Integer, Integer> reviewCount = new HashMap<>();
		
		Iterator<SpacesVO> iterator = spaceList.iterator();
		Map<Integer, Double> reviewAvg = new HashMap<>();
		List<SpaceReviewVO> reviewList = new ArrayList<SpaceReviewVO>();
		
		Map<Integer, Integer> likedStatus = new HashMap<>();
		
		while (iterator.hasNext()) {
			
			SpacesVO spacesVO = iterator.next(); 
			reviewList = spaceService.spaceReviewList(spacesVO);
			reviewCount.put(spacesVO.getIdx(), reviewList.size());
			
			double sum = 0;
			double avg = 0;
			
			Iterator<SpaceReviewVO> reviewIterator = reviewList.iterator();
			
			if (reviewList.size() != 0) {
				while (iterator.hasNext()) {
					
					sum += reviewIterator.next().getScore();
				}
				
				avg = sum / reviewList.size();
			} else {
				avg = 0;
			}

			reviewAvg.put(spacesVO.getIdx(), avg);
			
			LikedSpacesVO liked = new LikedSpacesVO();
			
			if ((GeneralMembersVO) request.getSession().getAttribute("login") != null) {
				liked.setmIdx(((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
				liked.setSpaceIdx(spacesVO.getIdx());
				likedStatus.put(spacesVO.getIdx(), spaceService.getLikedStatus(liked));
			} else {
				likedStatus.put(spacesVO.getIdx(), 0);
			}
		}
		
		model.addAttribute("reviewCount", reviewCount);
		model.addAttribute("reviewAvg", reviewAvg);
		model.addAttribute("likedStatus", likedStatus);
		
		return "space/list";
	}
	
	@RequestMapping(value = "addlist.do")
	@ResponseBody
	public Map<String, Object> addList(HttpServletRequest request, Integer page, Integer search, SpacesVO vo) {
		
		Map<String, Object> map = new HashMap<>();

		Map<String, Object> params = new HashMap<>();
		if (page == null) {
			page = 1;
		}
		int start = page * 12 - 11;
		int end = page * 12;
		
		if (search != null) {
			params.put("vo", vo);
		}
		
		params.put("start", start);
		params.put("end", end);
		
		
		List<SpacesVO> spaceList = spaceService.spaceList(params);
		map.put("spaceList", spaceList);
		
		Map<Integer, Integer> reviewCount = new HashMap<>();
		
		Iterator<SpacesVO> iterator = spaceList.iterator();
		Map<Integer, Double> reviewAvg = new HashMap<>();
		List<SpaceReviewVO> reviewList = new ArrayList<SpaceReviewVO>();
		
		Map<Integer, Integer> likedStatus = new HashMap<>();
		
		while (iterator.hasNext()) {
			
			SpacesVO spacesVO = iterator.next(); 
			reviewList = spaceService.spaceReviewList(spacesVO);
			reviewCount.put(spacesVO.getIdx(), reviewList.size());
			
			double sum = 0;
			double avg = 0;
			
			Iterator<SpaceReviewVO> reviewIterator = reviewList.iterator();
			
			if (reviewList.size() != 0) {
				while (iterator.hasNext()) {
					
					sum += reviewIterator.next().getScore();
				}
				
				avg = sum / reviewList.size();
			} else {
				avg = 0;
			}

			reviewAvg.put(spacesVO.getIdx(), avg);
			
			LikedSpacesVO liked = new LikedSpacesVO();
			
			if ((GeneralMembersVO) request.getSession().getAttribute("login") != null) {
				liked.setmIdx(((GeneralMembersVO) request.getSession().getAttribute("login")).getmIdx());
				liked.setSpaceIdx(spacesVO.getIdx());
				likedStatus.put(spacesVO.getIdx(), spaceService.getLikedStatus(liked));
			} else {
				likedStatus.put(spacesVO.getIdx(), 0);
			}
		}
		
		map.put("reviewCount", reviewCount);
		map.put("reviewAvg", reviewAvg);
		map.put("likedStatus", likedStatus);
		
		return map;
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
			
			request.getSession().setAttribute("login", memberService.gLogin(
					(GeneralMembersVO) request.getSession().getAttribute("login")));
			
			model.addAttribute("spacesVO", spacesVO);
			model.addAttribute("hostVO", hostVO);
			model.addAttribute("rsvVO", rsvVO);
			
			return "space/payment";
		}		
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
