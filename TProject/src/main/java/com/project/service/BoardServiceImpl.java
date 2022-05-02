package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.dao.BoardDAO;
import com.project.vo.ArticlesVO;
import com.project.vo.ServiceInfoVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<ArticlesVO> list(Integer bidx,String searchtitle) {
		if(searchtitle == null) searchtitle="";
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("searchtitle", searchtitle);
		map.put("bidx", bidx);
		
		return dao.list(map);
	}

	@Override
	public int insertArticlesVO(ArticlesVO vo) {
		
		return dao.insertArticlesVO(vo);
	}

	@Override
	public ServiceInfoVO selectOneServiceInfo(int idx) {
		
		
		return dao.selectOneServiceInfoVO(idx);
	}

	@Override
	public int updateServiceInfo(ServiceInfoVO vo) {
		
		return dao.modifyServiceInfo(vo);
	}
	
	@Override
	public ArticlesVO selectArticles(ArticlesVO vo) {
		
		return dao.selectArticles(vo);
	}

	@Override
	public void readCount(ArticlesVO vo) {
		
		dao.readcount(vo);
	}

	@Override
	public int serlistModify(ArticlesVO vo) {
		
		return dao.serlistModify(vo);
	}

	@Override
	public int serlistDelete(ArticlesVO vo) {
		
		return dao.serlistDelete(vo);
	}

}
