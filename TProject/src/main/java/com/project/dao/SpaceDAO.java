package com.project.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.SpacePicturesVO;
import com.project.vo.SpacesVO;

@Repository
public class SpaceDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int spaceReg(SpacesVO vo, String[] spacePictureSrc) {
		
		int result = 0;
		sqlSession.insert("com.project.mapper.spaceMapper.spaceReg", vo);
		
		SpacePicturesVO spacePicturesVO = new SpacePicturesVO();
		
		spacePicturesVO.setSpaceIdx(vo.getIdx());
		for (String src : spacePictureSrc) {
			spacePicturesVO.setSrc(src);
			result = sqlSession.insert("com.project.mapper.spaceMapper.insertSpacePictures", spacePicturesVO);
		}
		
		return result;
	}
	
}
