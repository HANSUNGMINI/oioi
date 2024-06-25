package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChattingMapper {

	// -------- 공통코드 가져오기 --------------
	List<Map<String, String>> selectReportCategory(); // 신고 카테고리 가져오기
	List<Map<String, String>> selectReviewCategory(); // 리뷰 카테고리 가져오기

	Map<String, String> getUserInfo(Map<String, String> map); // 채팅 시 필요한 유저 정보 가져오기 


}
