package com.project.service;

import java.util.List;

import com.project.vo.*;

public interface SpaceService {
	int spaceReg(SpacesVO vo, String[] spacePictureSrc);
	List<LocationsVO> getLocations();
	List<SpacesVO> getSpaceList(int hostIdx);
	SpacesVO details(SpacesVO vo);
	List<SpacePicturesVO> spacePictureList(SpacesVO vo);
}
