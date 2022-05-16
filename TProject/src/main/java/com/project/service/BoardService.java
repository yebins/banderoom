package com.project.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.project.vo.ArticlesVO;
import com.project.vo.CommentRepliesVO;
import com.project.vo.CommentsVO;
import com.project.vo.LikedArticlesVO;
import com.project.vo.ServiceInfoVO;

public interface BoardService {
	
	int insertArticlesVO(ArticlesVO vo);
	ServiceInfoVO selectOneServiceInfo(int idx);
	int updateServiceInfo(ServiceInfoVO vo);
	ArticlesVO  selectArticles(ArticlesVO vo);
	void readCount(ArticlesVO vo);
	int serlistModify(ArticlesVO vo);
	int serlistDelete(ArticlesVO vo);
	int listDelete(ArticlesVO vo);
	int boardUpdate(ArticlesVO vo);
	int likedStatus(LikedArticlesVO vo);
	int likedAtricles(LikedArticlesVO vo);
	int unLikedArticles(LikedArticlesVO vo);
	int likeCount(int aIdx);
	List<ArticlesVO> Jlist(Map<String, Object> map,HttpServletRequest request);
	Map<String,Object> jlistOneArticle(Map<String, Object> map,HttpServletRequest request);
	Map<String, Object> commentWrite(CommentsVO vo);
	List<CommentsVO> commentList(Map<String, Object> params,HttpServletRequest request);
	List<ArticlesVO> bestArticles();
	List<ArticlesVO> pageCount(Map<String, Object> map);
	List<ArticlesVO> list(Map<String, Object> map, HttpServletRequest request);
	int commentUpdate(CommentsVO vo);
	int commentDelete(CommentsVO vo);
	int commentCount(int aIdx);
	int replyWrite(CommentRepliesVO vo);
	List<CommentRepliesVO> replylist(int cIdx);
}
