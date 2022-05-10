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
	public List<SpaceReviewVO> spaceReviewList(SpacesVO vo) {
		return dao.spaceReviewList(vo);
	}
	
	@Override
	public Map<String, Object> spaceReviewCntAvg(SpacesVO vo) {
		return dao.spaceReviewCntAvg(vo);
	}
	
	//테스트용
	public List<String> getAddr1() {
		return dao.getAddr1();
	}
	public List<String> getAddr2(LocationsVO vo) {
		return dao.getAddr2(vo);
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
	
	

}
