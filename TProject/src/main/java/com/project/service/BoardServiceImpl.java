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
import com.project.vo.CommentRepliesVO;
import com.project.vo.CommentsVO;
import com.project.vo.LikedArticlesVO;
import com.project.vo.ServiceInfoVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	@Override
	public List<ArticlesVO> list(Map<String, Object> map, HttpServletRequest request) {
		
		int page = map.get("page") == null ? 1 : Integer.parseInt(map.get("page").toString());
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
	public List<ArticlesVO> pageCount(Map<String, Object> map) {
		
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
		//System.out.println(map.toString());
		//System.out.println(count);
		
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
		int onlyCommentCount=dao.onlyCommentTotal(map);
		int page=(int) Math.ceil((double)onlyCommentCount/10);
		System.out.println("write"+page);
		
		Map<String, Object> map2 = new HashMap<>();
		
		map2.put("result",dao.commentWrite(vo));
		map2.put("lastPage", page);
		
		return map2;
	}

	@Override
	public List<CommentsVO> commentList(Map<String, Object> map,HttpServletRequest request) {
		int TotalCount=dao.commentCount(map);
		int onlyCommentCount=dao.onlyCommentTotal(map);
		//System.out.println("댓글개수"+TotalCount);
		
		int a=(int) Math.ceil((double)onlyCommentCount/10);
		//System.out.println("올림페이지"+a);
		
		int page = map.get("page") == null ? a : Integer.parseInt(map.get("page").toString());
		
		request.setAttribute("count", TotalCount);
		request.setAttribute("page", page);
		request.setAttribute("oCCount", onlyCommentCount);
		
		int start = page+(page-1)*9;
		int end=page*10;
		
		map.put("start", start);
		map.put("end", end);

		return dao.commentList(map);
	}

	@Override
	public List<ArticlesVO> bestArticles() {
		return dao.bestArticles();
	}
	
	public int commentUpdate(CommentsVO vo) {
		
		return dao.commentUpdate(vo);
	}

	@Override
	public int commentDelete(CommentsVO vo) {
		// TODO Auto-generated method stub
		return dao.commentDelete(vo);
	}

	@Override
	public int commentCount(int aIdx) {
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("aIdx",aIdx);
		//System.out.println(aIdx);
		
		//System.out.println(aIdx+"게시물에 댓글개수"+dao.commentCount(map));
		
		return dao.commentCount(map);
	}

	@Override
	public int replyWrite(CommentRepliesVO vo) {
		
		return dao.replyWrite(vo);
	}

	@Override
	public int replyDelete(CommentRepliesVO vo) {
		
		return dao.replyDelete(vo);
	}

	@Override
	public List<CommentRepliesVO> replylist(int cIdx) {
		
		return dao.replyList(cIdx);
	}

	@Override
	public List<ArticlesVO> prevList(ArticlesVO vo) {
		
		return dao.prevList(vo);
	}

	@Override
	public List<ArticlesVO> nextList(ArticlesVO vo) {
		
		return dao.nextList(vo);
	}

	@Override
	public Map<String, Integer> twoinone(int aIdx) {
		
		return dao.twoinone(aIdx);
	}
		
}
