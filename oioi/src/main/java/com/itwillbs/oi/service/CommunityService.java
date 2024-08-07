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


	public int insertBoard(Map<String, Object> map) {
		return mapper.insertBoard(map);
	}

	public int selectCM_IDX() {
		return mapper.selectCM_IDX();
	}

	public int deleteBoard(Map<String, Object> map) {
		return mapper.deleteBoard(map);
	}

	public int updateBoard(Map<String, Object> boardMap) {
		return mapper.updateBoard(boardMap);
	}

	public int getListCount(Map<String, Object> map) {
		return mapper.selectListCount(map);
	}

	public void updateReadCount(int cM_IDX) {
		mapper.updateReadCount(cM_IDX);
	}

	public List<Map<String, String>> getReportCategory() {
		return mapper.selectReportCategory();
	}

	public int insertReport(Map<String, String> map) {
		return mapper.insertReport(map);
	}

	public List<Map<String, Object>> getCMCategory() {
		return mapper.selectCMCategory();
	}

}
