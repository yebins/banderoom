package com.project.service;

import java.util.List;

import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

public interface TeamsService {

	List<TeamsVO> selectList();
	List<PartsVO> selectParts(int teamIdx);
	int register(TeamsVO vo, List<PartsVO> partsVOlist);
	
}
