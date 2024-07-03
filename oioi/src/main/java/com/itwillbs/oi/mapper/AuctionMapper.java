package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AuctionMapper {
	Map<String, Object> selectAdmin(Map<String, String> admin);

	List<Map<String, String>> getCategory1();

	List<Map<String, String>> getCategory2();

	List<Map<String, String>> getCategory3();

	int insertImg(Map<String, Object> fileMap);

	int insertAPD(Map<String, Object> map);

	String[] categoryName(Map<String, Object> map);

	List<Map<String, Object>> selectApdList(@Param("params") Map<String, Object> params);

	Map<String, String> selectApdDetail(Map<String, String> map);

	Map<String, String> selectACR(String APD_IDX);

	int insertACR(String aPD_IDX);

	int updateApdBid(Map<String, Object> map);

	int updateApdStatus(String APD_IDX);

	int insertACM(Map<String, Object> map);

	int insertBid(Map<String, Object> map);

	List<Map<String, String>> selectBidChart(int aPD_IDX);

	List<Map<String, Object>> selectAuctionList();

	List<Map<String, Object>> apdPopular();


}
