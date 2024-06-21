package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.MainMapper;

@Service
public class MainService {

	@Autowired
	private MainMapper mapper;

	// 키워드 기반 상품 목록 가져오기
	public List<Map<String, Object>> getRecentKeywordProduct(Map<String, String> map) {
		return mapper.selectRecentKeywordProduct(map);
	}
}
