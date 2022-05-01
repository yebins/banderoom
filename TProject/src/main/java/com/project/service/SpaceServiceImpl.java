package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.SpaceDAO;
import com.project.vo.*;

@Service
public class SpaceServiceImpl implements SpaceService {
	
	@Autowired
	private SpaceDAO dao;

	@Override
	public int spaceReg(SpacesVO vo, String[] spacePictureSrc) {
		return dao.spaceReg(vo, spacePictureSrc);
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


}
