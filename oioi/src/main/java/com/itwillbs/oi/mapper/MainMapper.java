package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainMapper {

	List<Map<String, Object>> selectRecentKeywordProduct(Map<String, String> map);

	List<Map<String, Object>> getPopularProcuts();
	List<Map<String, Object>> getMainAuctionItems();

	List<Map<String, Object>> getRecentLookProduct(int product);

	
}
