package com.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.TeamsDAO;
import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

@Service
public class TeamsServiceImpl implements TeamsService{

	@Autowired
	private TeamsDAO dao;
	
	@Override
	public List<TeamsVO> selectList() {
		return dao.selectList();
	}
	
	@Override
	public List<PartsVO> selectParts(int teamIdx) {
		return dao.selectParts(teamIdx);
	}
	
	@Override
	public int register(TeamsVO vo, List<PartsVO> partsVOlist) {
		return dao.register(vo, partsVOlist);
	}

	

	
	
	
}
