package com.project.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

@Repository
public class TeamsDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public List<TeamsVO> selectList(){
		return sqlSession.selectList("com.project.mapper.teamsMapper.selectList");
	}
	
	public List<PartsVO> selectParts(int teamIdx){
		return sqlSession.selectList("com.project.mapper.teamsMapper.selectParts", teamIdx);
	}

	public int register(TeamsVO vo, List<PartsVO> partsVOlist) {
		int result = 0;
		
		result = sqlSession.insert("com.project.mapper.teamsMapper.register", vo);
		
		
		if(partsVOlist != null && partsVOlist.size() != 0) {
			for(int i=0; i<partsVOlist.size(); i++) {
				partsVOlist.get(i).setTeamIdx(vo.getTeamIdx());
			}
			result = sqlSession.insert("com.project.mapper.teamsMapper.insertPart", partsVOlist);
		}
		
		return result; 
	}
}
