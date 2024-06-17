package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommunityMapper {

	List<Map<String, Object>> selectBoardList(Map<String, Object> map);

	Map<String, Object> selectBoardDetail(int CM_IDX);

	String selectNickName(Object object);

	List<Map<String, String>> selectCM_CATEGORY();

}
