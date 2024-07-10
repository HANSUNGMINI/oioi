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

	List<Map<String, Object>> getSearchProducts(Map map); // 검색한 상품 가져오기

	int getMyUnreadCount(Map map); // 총 안 읽은 개수

	List<Map<String, Object>> getMainChatList(Map map); // 최근 대화 내역 2개만
	

}
