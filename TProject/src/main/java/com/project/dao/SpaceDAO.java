package com.project.dao;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.vo.*;

@Repository
public class SpaceDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int spaceReg(SpacesVO vo, String[] src, String[] thumbSrc) {
		
		
		int result = sqlSession.insert("com.project.mapper.spaceMapper.spaceReg", vo);
		
		SpacePicturesVO spacePicturesVO = new SpacePicturesVO();
		
		spacePicturesVO.setSpaceIdx(vo.getIdx());
		
		if (src != null && src.length != 0) {
			for (int i = 0; i < src.length; i++) {
				spacePicturesVO.setSrc(src[i]);
				spacePicturesVO.setThumbSrc(thumbSrc[i]);
				result = sqlSession.insert("com.project.mapper.spaceMapper.insertSpacePictures", spacePicturesVO);
			}
		}
		
		return result;
	}

	public int update(SpacesVO vo, String[] src, String[] thumbSrc) {
		
		int result = sqlSession.update("com.project.mapper.spaceMapper.update", vo);
		
		result = sqlSession.delete("com.project.mapper.spaceMapper.deleteSpacePictrues", vo);

		SpacePicturesVO spacePicturesVO = new SpacePicturesVO();
		
		spacePicturesVO.setSpaceIdx(vo.getIdx());
		
		if (src != null && src.length != 0) {
			for (int i = 0; i < src.length; i++) {
				spacePicturesVO.setSrc(src[i]);
				spacePicturesVO.setThumbSrc(thumbSrc[i]);
				result = sqlSession.insert("com.project.mapper.spaceMapper.insertSpacePictures", spacePicturesVO);
			}
		}
		
		return result;
		
	}
	
	public List<LocationsVO> getLocations() {
		return sqlSession.selectList("com.project.mapper.spaceMapper.getLocations");
	}
	
	public List<SpacesVO> getSpaceList(int hostIdx) {
		SpacesVO vo = new SpacesVO();
		vo.setHostIdx(hostIdx);
		return sqlSession.selectList("com.project.mapper.spaceMapper.getSpaceList", vo);
	}
	
	public SpacesVO details(SpacesVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.details", vo);
	}
	
	public List<SpacePicturesVO> spacePictureList(SpacesVO vo) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.spacePictureList", vo);
	}
	
	public int delete(SpacesVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.delete", vo);
	}
	
	public List<LikedSpacesVO> likedSpacesList(SpacesVO vo) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.likedSpacesList", vo);
	}
	
	public int getLikedStatus(LikedSpacesVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.getLikedStatus", vo);
	}
	
	public int likeSpace(LikedSpacesVO vo) {
		return sqlSession.insert("com.project.mapper.spaceMapper.likeSpace", vo);
	}
	
	public int unlikeSpace(LikedSpacesVO vo) {
		return sqlSession.delete("com.project.mapper.spaceMapper.unlikeSpace", vo);
	}
	
	public int acceptSpace(SpacesVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.acceptSpace", vo);
	}
	
	public int refuseSpace(SpacesVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.refuseSpace", vo);
	}
	
	public int requestAccept(SpacesVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.requestAccept", vo);
	}
	
	public List<SpacesVO> spaceList(Map<String, Object> params) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.spaceList", params);
	}
	
	public Map<String, Object> spaceReviewCntAvg(SpacesVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.spaceReviewCntAvg", vo);
	}
	
	public List<SpaceReviewVO> spaceReviewList(Map<String, Object> params) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.spaceReviewList", params);
	}
	
	// 테스트용
	public List<String> getAddr1() {
		return sqlSession.selectList("com.project.mapper.spaceMapper.getAddr1");
	}
	public List<String> getAddr2(LocationsVO vo) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.getAddr2", vo);		
	} //
	
	public ReservationsVO insertRsv(ReservationsVO vo) {
		sqlSession.insert("com.project.mapper.spaceMapper.insertRsv", vo);
		
		return vo;
	}
	
	public int insertPoint(PointsVO vo) {
		return sqlSession.insert("com.project.mapper.spaceMapper.insertPoint", vo);
	}
	
	public ReservationsVO getRSV(ReservationsVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.getRSV", vo);
	}
	
	public List<String> getRsvFullDates(Map<String, String> params) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.getRsvFullDates", params);
	}
	
	public List<Map<String, Date>> getRsvHours(Map<String, String> date) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.getRsvHours", date);
	}
	
	public List<ReservationsVO> getCurrentRsv(GeneralMembersVO vo) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.getCurrentRsv", vo);
	}
	
	public int countPastRsv(Map<String, Object> params) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.countPastRsv", params);
	}
	
	public List<ReservationsVO> getPastRsv(Map<String, Object> params) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.getPastRsv", params);
	}
	
	public int isReviewExist(ReservationsVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.isReviewExist", vo);
	}
	
	public int insertReview(SpaceReviewVO vo) {
		return sqlSession.insert("com.project.mapper.spaceMapper.insertReview", vo);
	}
	
	public SpaceReviewVO getReviewInfo(SpaceReviewVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.getReviewInfo", vo);
	}
	
	public int deleteReview(SpaceReviewVO vo) {
		return sqlSession.delete("com.project.mapper.spaceMapper.deleteReview", vo);
	}
	
	public int updateReview(SpaceReviewVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.updateReview", vo);
	}
	
	public int insertQnaQ(SpaceQnaVO vo) {
		return sqlSession.insert("com.project.mapper.spaceMapper.insertQnaQ", vo);
	}
	
	public int countQna(SpacesVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.countQna", vo);
	}
	
	public List<SpaceQnaVO> qnaList(Map<String, Object> params) {
		return sqlSession.selectList("com.project.mapper.spaceMapper.qnaList", params);
	}
	
	public int insertQnaA(SpaceQnaVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.updateQnaA", vo);
	}

	public int deleteQnaA(SpaceQnaVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.deleteQnaA", vo);
	}
	
	public SpaceQnaVO qnaInfo(SpaceQnaVO vo) {
		return sqlSession.selectOne("com.project.mapper.spaceMapper.qnaInfo", vo);
	}
	
	public int deleteQna(SpaceQnaVO vo) {
		return sqlSession.delete("com.project.mapper.spaceMapper.deleteQna", vo);
	}
	
	public int updateQnaQ(SpaceQnaVO vo) {
		return sqlSession.update("com.project.mapper.spaceMapper.updateQnaQ", vo);
	}
}
