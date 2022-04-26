package com.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.dao.BoardDAO;
import com.project.vo.ArticlesVO;

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
}
