package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.BoardDAO;
import com.project.util.PagingUtil;
import com.project.vo.ArticlesVO;
import com.project.vo.CommentsVO;
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
		
		PagingUtil pu = new PagingUtil(dao.pageCount(map).size(), page, 10, 10);
		
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
		
		return dao.pageCount(map);
	}
	
	public List<ArticlesVO> Jlist(Map<String, Object> map,HttpServletRequest request) {
		//page+(page-1)*5;
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());
		int start = page+(page-1)*5;
		int end=page*6;
		//if(searchtitle == null) searchtitle ="";
		
		/*
		 * jlist.put("searchtitle",searchtitle); jlist.put("start",start);
		 * jlist.put("end",end);
		 */
		
		/*
		 * if(status == null) { status=0; }
		 */
		//jlist.put("status", status);
		//System.out.println(jlist.toString());
		int count=dao.jlistCount(map);
		map.put("start", start);
		map.put("end", end);
		map.put("articlesCount", count);
		System.out.println(map.toString());
		System.out.println(count);
		
		request.setAttribute("count", count);
				
		return dao.jlist(map);	
	}



	@Override
	public int listDelete(ArticlesVO vo) {
		
		return dao.listDelete(vo);
	}
	
	public Map<String, Object> jlistOneArticle(Map<String, Object> map,HttpServletRequest request) {
		
		int count=dao.commentCount(map); // 댓글총개수
		request.setAttribute("cmtCount", count);
		
		return dao.jlistOneArticle(map);
	}

	@Override
	public Map<String, Object> commentWrite(CommentsVO vo) {
		Map<String, Object> map = new HashMap<>();
		map.put("bIdx", vo.getbIdx());
		map.put("aIdx", vo.getaIdx());
		
		int count=dao.commentCount(map);
		int page=(int) Math.ceil((double)count/10);
		System.out.println("write"+page);
		
		Map<String, Object> map2 = new HashMap<>();
		
		map2.put("result",dao.commentWrite(vo));
		map2.put("lastPage", page);
		
		return map2;
	}

	@Override
	public List<CommentsVO> commentList(Map<String, Object> map,HttpServletRequest request) {
		int count=dao.commentCount(map);
		System.out.println("댓글개수"+count);
		int a=(int) Math.ceil((double)count/10);
		System.out.println("올림페이지"+a);
		
		int page = map.get("page") == null ? a : Integer.parseInt(map.get("page").toString());
		
		request.setAttribute("count", count);
		request.setAttribute("page", page);
		
		int start = page+(page-1)*9;
		int end=page*10;
		
		map.put("start", start);
		map.put("end", end);

		System.out.println(map.toString());
		System.out.println("댓글개수"+dao.commentList(map).size());
		
		return dao.commentList(map);
	}
	
	
		
}
