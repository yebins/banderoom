package com.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.ArticlesVO;
import com.project.vo.ServiceInfoVO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<ArticlesVO> list(Map map){
		
		return sqlSession.selectList("com.project.mapper.boardMapper.list",map);
	}
	
	public int insertArticlesVO(ArticlesVO vo) {
		
		return sqlSession.insert("com.project.mapper.boardMapper.insertArticles",vo);
	}
	
	public ServiceInfoVO selectOneServiceInfoVO(int idx) {
		return sqlSession.selectOne("com.project.mapper.boardMapper.infoOne",idx);
	}
	
	public int modifyServiceInfo(ServiceInfoVO vo) {
		System.out.println(vo.getContent());
		
		return sqlSession.update("com.project.mapper.boardMapper.infoModify",vo);
	}

	public ArticlesVO selectArticles(ArticlesVO vo) {
		
		return sqlSession.selectOne("com.project.mapper.boardMapper.selectArticles", vo);
	}
	
	public void readcount(ArticlesVO vo) {
		
		sqlSession.update("com.project.mapper.boardMapper.readCount", vo);
	}
	
}
