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
	List<SpaceReviewVO> spaceReviewList(Map<String, Object> params);
	Map<String, Object> spaceReviewCntAvg(SpacesVO vo);
	int validateRsv(ReservationsVO vo);
	ReservationsVO insertRsv(ReservationsVO vo);
	int insertPoint(PointsVO vo);
	ReservationsVO getRSV(ReservationsVO vo);
	List<String> getRsvFullDates(Map<String, String> params);
	List<Map<String, String>> getRsvHours(Map<String, String> date);
	List<ReservationsVO> getCurrentRsv(GeneralMembersVO vo);
	int countPastRsv(GeneralMembersVO vo, String dateType, String dateRange);
	List<ReservationsVO> getPastRsv(GeneralMembersVO vo, String dateType, String dateRange, int start);
	int isReviewExist(ReservationsVO vo);
	int insertReview(SpaceReviewVO vo);
	SpaceReviewVO getReviewInfo(SpaceReviewVO vo);
	int deleteReview(SpaceReviewVO vo);
	int updateReview(SpaceReviewVO vo);
	int insertQnaQ(SpaceQnaVO vo);
	int countQna(SpacesVO vo);
	List<SpaceQnaVO> qnaList(Map<String, Object> params);
	int insertQnaA(SpaceQnaVO vo);
	int deleteQnaA(SpaceQnaVO vo);
	SpaceQnaVO qnaInfo(SpaceQnaVO vo);
	int deleteQna(SpaceQnaVO vo);
	int updateQnaQ(SpaceQnaVO vo);
	int countRsvBySpace(SpacesVO vo, String dateType, String dateRange);
	List<ReservationsVO> getRsvBySpace(SpacesVO vo, String dateType, String dateRange, int start);
	int countPointHistory(GeneralMembersVO login, String dateRange);
	List<PointsVO> pointHistory(GeneralMembersVO login, String dateRange, int start);
	List<PointsVO> pointInfo(ReservationsVO vo);
	int cancelRsv(ReservationsVO vo);

	//테스트용
	public List<String> getAddr1();
	public List<String> getAddr2(LocationsVO vo);
}
