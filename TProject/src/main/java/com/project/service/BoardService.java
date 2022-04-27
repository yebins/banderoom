package com.project.service;

import java.util.List;

import com.project.vo.ArticlesVO;

public interface BoardService {
	
	List<ArticlesVO> list(Integer bidx,String searchtitle);
	int insertArticlesVO(ArticlesVO vo);
}
