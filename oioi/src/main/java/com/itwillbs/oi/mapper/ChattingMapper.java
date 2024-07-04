package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.oi.vo.ProductChatVO;

@Mapper
public interface ChattingMapper {

	// -------- 공통코드 가져오기 --------------
	List<Map<String, String>> selectReportCategory(); // 신고 카테고리 가져오기
	List<Map<String, String>> selectReviewCategory(); // 리뷰 카테고리 가져오기
	// ------------------------------------------
	
	// ----------- 정보 가져오기 ----------------
	Map<String, String> getUserInfo(Map<String, String> map); // 채팅 시 필요한 유저 정보 가져오기 
	Map<String, String> getMyInfo(Map<String, String> map); // 채팅 시 내 정보 가져오기
	// -------------------------------------------
	
	// ----------- 정보 처리하기 ----------------
	int insertReport(Map<String, String> map); // 신고 처리
	int insertReview(Map<String, String> map); // 리뷰 처리
	// -------------------------------------------

	// ----------- 채팅 ----------------


}
