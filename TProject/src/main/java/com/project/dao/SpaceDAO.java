package com.project.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.SpacesVO;

@Repository
public class SpaceDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int spaceReg(SpacesVO vo) {
		return sqlSession.insert("com.project.mapper.spaceMapper.spaceReg", vo);
	}
	
}
