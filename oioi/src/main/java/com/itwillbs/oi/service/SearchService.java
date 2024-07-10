package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.SearchMapper;

@Service
public class SearchService {

	@Autowired
	SearchMapper mapper;

	// 연관 검색어 뽑아오기
	public List<Map<String, String>> getList(Map map) {
		return mapper.selectRecommendList(map);
	}

	// 중복된 키워드 있는지 확인
	public int duplicateKeyword(Map<String, String> map) {
		return mapper.selectDuplicate(map);
	}

	// 검색어 등록
	public void registKeyword(Map<String, String> map) {
		mapper.insertKeyword(map);
	}

	// 검색 카운트 증가
	public void upCount(Map<String, String> map) {
		mapper.updateCount(map);
	}

	public List<Map<String, Object>> getPopularKeyword() {
		return mapper.selectPopularKeyword();
	}

	public List<Map<String, Object>> getSearchProducts(Map map) {
		return mapper.getSearchProducts(map);
	}

	public int getMyUnreadCount(Map map) {
		return mapper.getMyUnreadCount(map);
	}

	public List<Map<String, Object>> getMainChatList(Map map) {
		return mapper.getMainChatList(map);
	}

	
}
