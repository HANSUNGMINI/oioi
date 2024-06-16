package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuctionMapper {
	Map<String, Object> selectAdmin(Map<String, String> admin);

	List<Map<String, String>> getCategory1();

	List<Map<String, String>> getCategory2();

	List<Map<String, String>> getCategory3();

	int insertImg(Map<String, Object> fileMap);

	int insertAPD(Map<String, Object> map);

	String[] categoryName(Map<String, Object> map);


}
