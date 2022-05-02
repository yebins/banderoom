package com.project.service;

import java.util.List;

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
}
