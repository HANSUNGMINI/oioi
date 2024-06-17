package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchMapper {

	// 연관 검색어 뽑아오기
	List<Map<String, String>> selectRecommendList(Map map);

}
