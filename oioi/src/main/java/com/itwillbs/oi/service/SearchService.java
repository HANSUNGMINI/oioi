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
}
