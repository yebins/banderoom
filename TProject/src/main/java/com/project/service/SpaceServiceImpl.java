package com.project.service;

import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.SpaceDAO;
import com.project.vo.*;

@Service
public class SpaceServiceImpl implements SpaceService {
	
	@Autowired
	private SpaceDAO dao;

	@Override
	public int spaceReg(SpacesVO vo, String[] src, String[] thumbSrc) {
		return dao.spaceReg(vo, src, thumbSrc);
	}

	@Override
	public int update(SpacesVO vo, String[] src, String[] thumbSrc) {
		return dao.update(vo, src, thumbSrc);
	}

	@Override
	public List<LocationsVO> getLocations() {
		return dao.getLocations();
	}

	@Override
	public List<SpacesVO> getSpaceList(int hostIdx) {
		return dao.getSpaceList(hostIdx);
	}

	@Override
	public SpacesVO details(SpacesVO vo) {
		return dao.details(vo);
	}

	@Override
	public List<SpacePicturesVO> spacePictureList(SpacesVO vo) {
		return dao.spacePictureList(vo);
	}

	@Override
	public int delete(SpacesVO vo) {
		return dao.delete(vo);
	}

	@Override
	public int getLikedStatus(LikedSpacesVO vo) {
		return dao.getLikedStatus(vo);
	}

	@Override
	public int likeSpace(LikedSpacesVO vo) {
		if (dao.getLikedStatus(vo) == 1) {
			return -1; // 이미 찜했음
		} else {
			return dao.likeSpace(vo);
		}
	}

	@Override
	public int unlikeSpace(LikedSpacesVO vo) {
		if (dao.getLikedStatus(vo) == 0) {
			return -1; // 찜하지 않았음
		} else {
			return dao.unlikeSpace(vo);
		}
	}

	@Override
	public int acceptSpace(SpacesVO vo) {
		return dao.acceptSpace(vo);
	}

	@Override
	public int refuseSpace(SpacesVO vo) {
		return dao.refuseSpace(vo);
	}

	@Override
	public int requestAccpet(SpacesVO vo) {
		return dao.requestAccept(vo);
	}

	@Override
	public List<SpacesVO> spaceList(Map<String, Object> params) {
		return dao.spaceList(params);
	}

	@Override
	public List<SpaceReviewVO> spaceReviewList(Map<String, Object> params) {
		return dao.spaceReviewList(params);
	}
	
	@Override
	public Map<String, Object> spaceReviewCntAvg(SpacesVO vo) {
		Map<String, Object> result = dao.spaceReviewCntAvg(vo);

		if (result == null) {
			result = new HashMap<String, Object>();
			
			result.put("count", 0);
			result.put("avg", 0.0);
			result.put("spaceidx", vo.getIdx());
			
		}
		
		return result;
	}
	
	//테스트용
	public List<String> getAddr1() {
		return dao.getAddr1();
	}
	public List<String> getAddr2(LocationsVO vo) {
		return dao.getAddr2(vo);
	}

	@Override
	public int validateRsv(ReservationsVO vo) {
		return dao.validateRsv(vo);
	}
	
	@Override
	public ReservationsVO insertRsv(ReservationsVO rsvVO) {
		return dao.getRSV(dao.insertRsv(rsvVO));
	}

	@Override
	public int insertPoint(PointsVO vo) {
		return dao.insertPoint(vo);		
	}

	@Override
	public ReservationsVO getRSV(ReservationsVO vo) {
		return dao.getRSV(vo);
	}

	@Override
	public List<String> getRsvFullDates(Map<String, String> params) {
		return dao.getRsvFullDates(params);
	}

	@Override
	public List<Map<String, String>> getRsvHours(Map<String, String> date) {
		
		List<Map<String, String>> result = new ArrayList<Map<String,String>>();
		
		List<Map<String, Date>> rsvHours = dao.getRsvHours(date);
		SimpleDateFormat sdf = new SimpleDateFormat("HH");
		
		Iterator<Map<String, Date>> iterator = rsvHours.iterator();
		
		while (iterator.hasNext()) {
			Map<String, Date> element = iterator.next();
			Map<String, String> resultElement = new HashMap<String, String>();
			
			resultElement.put("start", sdf.format(element.get("startDate")));
			resultElement.put("end", sdf.format(element.get("endDate")));
			
			result.add(resultElement);
		}
		
		return result;
	}

	@Override
	public List<ReservationsVO> getCurrentRsv(GeneralMembersVO vo) {
		return dao.getCurrentRsv(vo);
	}

	@Override
	public int countPastRsv(GeneralMembersVO vo, String dateType, String dateRange) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("mIdx", vo.getmIdx());
		
		try {
			String[] dates = dateRange.split(" ~ ");
			params.put("dateType", dateType);
			params.put("start", dates[0]);
			params.put("end", dates[1]);
		} catch (Exception e) {
		}
		return dao.countPastRsv(params);
	}

	@Override
	public List<ReservationsVO> getPastRsv(GeneralMembersVO vo, String dateType, String dateRange, int start) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("startRow", start);
		params.put("mIdx", vo.getmIdx());
		
		try {
			String[] dates = dateRange.split(" ~ ");
			params.put("dateType", dateType);
			params.put("start", dates[0]);
			params.put("end", dates[1]);
		} catch (Exception e) {
		}
		return dao.getPastRsv(params);
	}

	@Override
	public int isReviewExist(ReservationsVO vo) {
		return dao.isReviewExist(vo);
	}

	@Override
	public int insertReview(SpaceReviewVO vo) {
		return dao.insertReview(vo);
	}
	
	@Override
	public SpaceReviewVO getReviewInfo(SpaceReviewVO vo) {
		return dao.getReviewInfo(vo);
	}
	
	@Override
	public int deleteReview(SpaceReviewVO vo) {
		return dao.deleteReview(vo);
	}
	
	@Override
	public int updateReview(SpaceReviewVO vo) {
		return dao.updateReview(vo);
	}

	@Override
	public int countQna(SpacesVO vo) {
		return dao.countQna(vo);
	}

	@Override
	public int insertQnaQ(SpaceQnaVO vo) {
		return dao.insertQnaQ(vo);
	}

	@Override
	public List<SpaceQnaVO> qnaList(Map<String, Object> params) {
		return dao.qnaList(params);
	}

	@Override
	public int insertQnaA(SpaceQnaVO vo) {
		return dao.insertQnaA(vo);
	}

	@Override
	public int deleteQnaA(SpaceQnaVO vo) {
		return dao.deleteQnaA(vo);
	}

	@Override
	public SpaceQnaVO qnaInfo(SpaceQnaVO vo) {
		return dao.qnaInfo(vo);
	}

	@Override
	public int deleteQna(SpaceQnaVO vo) {
		return dao.deleteQna(vo);
	}
	
	@Override
	public int updateQnaQ(SpaceQnaVO vo) {
		return dao.updateQnaQ(vo);
	}

	@Override
	public int countRsvBySpace(SpacesVO vo, String dateType, String dateRange) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("spaceIdx", vo.getIdx());
		
		try {
			String[] dates = dateRange.split(" ~ ");
			System.out.println(Arrays.toString(dates));
			params.put("dateType", dateType);
			params.put("start", dates[0]);
			params.put("end", dates[1]);
		} catch (Exception e) {
		}
		return dao.countRsvBySpace(params);
	}

	@Override
	public List<ReservationsVO> getRsvBySpace(SpacesVO vo, String dateType, String dateRange, int start) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("startRow", start);
		params.put("spaceIdx", vo.getIdx());
		
		try {
			String[] dates = dateRange.split(" ~ ");
			System.out.println(Arrays.toString(dates));
			params.put("dateType", dateType);
			params.put("start", dates[0]);
			params.put("end", dates[1]);
		} catch (Exception e) {
		}
		return dao.getRsvBySpace(params);
	}

	@Override
	public int countPointHistory(GeneralMembersVO login, String dateRange) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mIdx", login.getmIdx());

		try {
			String[] dates = dateRange.split(" ~ ");
			System.out.println(Arrays.toString(dates));
			params.put("start", dates[0]);
			params.put("end", dates[1]);
		} catch (Exception e) {
		}
		
		return dao.countPointHistory(params);
	}
	
	@Override
	public List<PointsVO> pointHistory(GeneralMembersVO login, String dateRange, int start) {
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("startRow", start);
		params.put("mIdx", login.getmIdx());

		try {
			String[] dates = dateRange.split(" ~ ");
			System.out.println(Arrays.toString(dates));
			params.put("start", dates[0]);
			params.put("end", dates[1]);
		} catch (Exception e) {
		}
		
		return dao.pointHistory(params);
	}
	
	@Override
	public List<PointsVO> pointInfo(ReservationsVO vo) {
		return dao.pointInfo(vo);
	}
	
	@Override
	public int cancelRsv(ReservationsVO vo) {
		return dao.cancelRsv(vo);
	}
	
	@Override
	public List<SpaceReviewVO> recentReview() {
		return dao.recentReview();
	}
	
	@Override
	public List<Map<String, Object>> calculation(Map<String, Object> params) {
		return dao.calculation(params);
	}
	
	@Override
	public int insertSettled(SettledVO vo) {
		return dao.insertSettled(vo);
	}
	
	@Override
	public int ifSettled(SettledVO vo) {
		return dao.ifSettled(vo);
	}
}
