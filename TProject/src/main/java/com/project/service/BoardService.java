package com.project.service;

import java.util.List;

import org.springframework.ui.Model;

import com.project.vo.ArticlesVO;
import com.project.vo.ServiceInfoVO;

public interface BoardService {
	
	List<ArticlesVO> list(Integer bidx,String searchtitle);
	int insertArticlesVO(ArticlesVO vo);
	ServiceInfoVO selectOneServiceInfo(int idx);
	int updateServiceInfo(ServiceInfoVO vo);
	ArticlesVO  selectArticles(ArticlesVO vo);
	void readCount(ArticlesVO vo);
	int serlistModify(ArticlesVO vo);
	int serlistDelete(ArticlesVO vo);
}
