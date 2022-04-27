package com.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.SpaceDAO;
import com.project.vo.SpacesVO;

@Service
public class SpaceServiceImpl implements SpaceService {
	
	@Autowired
	private SpaceDAO dao;

	@Override
	public int spaceReg(SpacesVO vo) {
		return dao.spaceReg(vo);
	}

}
