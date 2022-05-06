package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.project.dao.BoardDAO;
import com.project.util.PagingUtil;
import com.project.vo.ArticlesVO;
import com.project.vo.LikedArticlesVO;
import com.project.vo.ServiceInfoVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<ArticlesVO> list(int bIdx, String searchtitle, int page) {
		if(searchtitle == null) searchtitle="";
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("searchtitle", searchtitle);
		map.put("bIdx", bIdx);
		
		PagingUtil pu = new PagingUtil(dao.pageCount(map).size(), page, 10);
		
		map.put("start", pu.getStart());
		map.put("end", pu.getEnd());
		
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

	@Override
	public int boardUpdate(ArticlesVO vo) {
		
		return dao.boardUpdate(vo);
	}

	@Override
	public int likedStatus(LikedArticlesVO vo) {
		
		return dao.likedStatus(vo);
	}

	@Override
	public int likedAtricles(LikedArticlesVO vo) {
		if(dao.likedStatus(vo)==1) {
			return -1;
		}else {
			return dao.likedAtricles(vo);
		}
	}

	@Override
	public int unLikedArticles(LikedArticlesVO vo) {
		if(dao.likedStatus(vo)==0) {
			return -1;
		}else {
			return dao.unLikedArticles(vo);
		}
	}

	@Override
	public int likeCount(int aIdx) {
		
		return dao.likeCount(aIdx);
	}

	@Override
	public List<ArticlesVO> pageCount(int bIdx, String searchtitle) {
		if(searchtitle == null) searchtitle="";
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("searchtitle", searchtitle);
		map.put("bIdx", bIdx);
		
		System.out.println(dao.pageCount(map).size());
		return dao.pageCount(map);
	}
		
	
}
