package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommunityMapper {

	List<Map<String, Object>> selectBoardList(Map<String, Object> map);

	Map<String, Object> selectBoardDetail(int CM_IDX);

	List<Map<String, String>> selectCM_CATEGORY();

	int insertBoard(Map<String, Object> map);

	int selectCM_IDX();

	int deleteBoard(Map<String, Object> map);

	int updateBoard(Map<String, Object> boardMap);

	int selectListCount(Map<String, Object> map);

	void updateReadCount(int cM_IDX);

	List<Map<String, String>> selectReportCategory();

	int insertReport(Map<String, String> map);

}
