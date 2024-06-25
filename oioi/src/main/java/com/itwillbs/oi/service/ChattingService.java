package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.ChattingMapper;

@Service
public class ChattingService {

	
	@Autowired
	private ChattingMapper mapper;

	// 신고 카테고리 가져오기
	public List<Map<String, String>> getReportCategory() {
		return mapper.selectReportCategory();
	}
}
