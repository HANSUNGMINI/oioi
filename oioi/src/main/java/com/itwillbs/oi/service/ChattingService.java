package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.ChattingMapper;
import com.itwillbs.oi.vo.ProductChatVO;

@Service
public class ChattingService {

	
	@Autowired
	private ChattingMapper mapper;

	// [정보 가져오기] 
	// 채팅 시 필요한 유저 정보 가져오기
	public Map<String, String> getUserInfo(Map<String, String> map) {
		return mapper.getUserInfo(map);
	}

	// 내 정보
	public Map<String, String> getMyInfo(Map<String, String> map) {
		return mapper.getMyInfo(map);
	}
	
	// 신고 카테고리 가져오기
	public List<Map<String, String>> getReportCategory() {
		return mapper.selectReportCategory();
	}
	
	// 리뷰 카테고리 가져오기
	public List<Map<String, String>> getReviewCategory() {
		return mapper.selectReviewCategory();
	}

	// ---------------------------------------------------------------------------
	
	// [정보 처리하기]
	// 신고하기
	public int insertReport(Map<String, String> map) {
		return mapper.insertReport(map);
	}

	// 리뷰 작성
	public int insertReview(Map<String, String> map) {
		return mapper.insertReview(map);
	}

	// ----------------------------------------------------------------------------
	

	
}
