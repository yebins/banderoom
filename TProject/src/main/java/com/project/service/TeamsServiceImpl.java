package com.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.TeamsDAO;
import com.project.vo.ApplicationsVO;
import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

@Service
public class TeamsServiceImpl implements TeamsService{

	@Autowired
	private TeamsDAO dao;
	
	@Override
	public List<TeamsVO> selectList(Map<String, Object> searchMap) {
		return dao.selectList(searchMap);
	}
	
	@Override
	public List<PartsVO> selectParts(int teamIdx) {
		return dao.selectParts(teamIdx);
	}
	
	@Override
	public int register(TeamsVO vo, List<PartsVO> partsVOlist) {
		return dao.register(vo, partsVOlist);
	}

	@Override
	public TeamsVO details(int teamIdx) {
		return dao.details(teamIdx);
	}

	@Override
	public int appNum(Map<String, Object> appNumMap) {
		return dao.appNum(appNumMap);
	}

	
	@Override
	public int apply(ApplicationsVO vo) {
		return dao.apply(vo);
	}

	@Override
	public int delete(int teamIdx) {
		return dao.delete(teamIdx);
	}

	@Override
	public int update(TeamsVO vo) {
		return dao.update(vo);
	}

	@Override
	public List<TeamsVO> reglist(Map<String, Integer> endMap) {
		return dao.reglist(endMap);
	}

	@Override
	public int reglistCount(Map<String, Integer> endMap) {
		// TODO Auto-generated method stub
		return dao.reglistCount(endMap);
	}
	
	@Override
	public List<ApplicationsVO> applist(Map<String, Integer> appMap) {
		return dao.applist(appMap);
	}
	
	@Override
	public int applistCount(int mIdx) {
		return dao.applistCount(mIdx);
	}


	@Override
	public int finish(int teamIdx) {
		return dao.finish(teamIdx);
	}

	@Override
	public List<ApplicationsVO> myapp(int teamIdx) {
		return dao.myapp(teamIdx);
	}
	
	@Override
	public int myappCount(int teamIdx) {
		return dao.myappCount(teamIdx);
	}

	@Override
	public void updateStatus() {
		dao.updateStatus();
	}

	@Override
	public int updateApp(ApplicationsVO vo) {
		return dao.updateApp(vo);
	}

	@Override
	public int deleteApp(int appIdx) {
		return dao.deleteApp(appIdx);
	}


	

	
}
