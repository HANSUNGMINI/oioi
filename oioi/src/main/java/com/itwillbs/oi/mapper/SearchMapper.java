package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchMapper {

	
	List<Map<String, String>> selectRecommendList(Map map);// 연관 검색어 뽑아오기
	
	int selectDuplicate(Map<String, String> map); // 중복된 키워드 있는지
	
	void insertKeyword(Map<String, String> map); // 검색어 등록

	void updateCount(Map<String, String> map); // 검색 카운트 증가

	List<Map<String, Object>> selectPopularKeyword(); // 인기 검색어 1 ~ 20 가져오기


}
