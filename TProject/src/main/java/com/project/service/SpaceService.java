package com.project.service;

import java.util.*;

import com.project.vo.*;

public interface SpaceService {
	int spaceReg(SpacesVO vo, String[] src, String[] thumbSrc);
	int update(SpacesVO vo, String[] src, String[] thumbSrc);
	List<LocationsVO> getLocations();
	List<SpacesVO> getSpaceList(int hostIdx);
	SpacesVO details(SpacesVO vo);
	List<SpacePicturesVO> spacePictureList(SpacesVO vo);
	int delete(SpacesVO vo);
	int getLikedStatus(LikedSpacesVO vo);
	int likeSpace(LikedSpacesVO vo);
	int unlikeSpace(LikedSpacesVO vo);
	int acceptSpace(SpacesVO vo);
	int refuseSpace(SpacesVO vo);
	int requestAccpet(SpacesVO vo);
	List<SpacesVO> spaceList(Map<String, Object> params);
	List<SpaceReviewVO> spaceReviewList(SpacesVO vo);
	ReservationsVO insertRsv(ReservationsVO vo);
	int insertPoint(PointsVO vo);
	ReservationsVO getRSV(ReservationsVO vo);
	List<String> getRsvFullDates(Map<String, String> params);
	List<Map<String, String>> getRsvHours(Map<String, String> date);

	//테스트용
	public List<String> getAddr1();
	public List<String> getAddr2(LocationsVO vo);
}
