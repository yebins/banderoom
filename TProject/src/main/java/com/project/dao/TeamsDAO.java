package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.ApplicationsVO;
import com.project.vo.PartsVO;
import com.project.vo.TeamsVO;

@Repository
public class TeamsDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public List<TeamsVO> selectList(Map<String, Object> searchMap){
		return sqlSession.selectList("com.project.mapper.teamsMapper.selectList", searchMap);
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
	
	public TeamsVO details(int teamIdx) {
		return sqlSession.selectOne("com.project.mapper.teamsMapper.details", teamIdx);
	}
	
	public int apply(ApplicationsVO vo) {
		return sqlSession.insert("com.project.mapper.teamsMapper.apply", vo);
	}
	
	public int delete(int teamIdx) {
		return sqlSession.update("com.project.mapper.teamsMapper.delete", teamIdx);
	}
	
	public int update(TeamsVO vo) {
		return sqlSession.update("com.project.mapper.teamsMapper.update", vo);
	}
}
