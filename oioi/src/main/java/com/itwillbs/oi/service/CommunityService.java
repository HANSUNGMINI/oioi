package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.CommunityMapper;

@Service
public class CommunityService {
	@Autowired
	private CommunityMapper mapper;

	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		return mapper.selectBoardList(map);
	}

	public Map<String, Object> selectBoardDetail(int CM_IDX) {
		return mapper.selectBoardDetail(CM_IDX);
	}

	public String selectNickName(Object object) {
		return mapper.selectNickName(object);
	}

	public List<Map<String, String>> selectCM_CATEGORY() {
		return mapper.selectCM_CATEGORY();
	}

}
