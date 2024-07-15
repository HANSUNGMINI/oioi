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
	
	List<Map<String, String>> getCate1Edit(Map<String, Object> param);
	List<Map<String, String>> getCate2Edit(Map<String, Object> param);
	List<Map<String, String>> getCate3Edit(Map<String, Object> param);
	
	int insertImg(Map<String, Object> fileMap);

	int insertAPD(Map<String, Object> map);

	String[] categoryName(Map<String, Object> map);

	List<Map<String, Object>> selectApdList(@Param("params") Map<String, Object> params);

	Map<String, String> selectApdDetail(Map<String, String> map);

	String selectACR(String APD_IDX);

	String insertACR(String APD_IDX);

	int updateApdBid(Map<String, Object> map);

	int updateApdStatus(String APD_IDX);

	int insertACM(Map<String, Object> map);

	int insertBid(Map<String, Object> map);

	List<Map<String, String>> selectBidChart(int aPD_IDX);

	List<Map<String, Object>> apdPopular();

	Map<String, Object> selectNewAuction();

	int updateApdBuyStatus(Map<String, Object> map);

	void auctionFinalBid(Map<String, Object> map);

	List<Map<String, Object>> getRecentLookProduct(int product);

	boolean updateApdBuyOiMoney(Map<String, Object> map);

	String getOiMoney(String US_ID);

	String selectAddress(String uS_ID);

	void insertApdTrade(Map<String, Object> map);

	String selectProfile(String US_ID);

	List<Map<String, Object>> selectReportMsg(Map<String, String> map);

	Map<String, String> selectUserInfo(String uS_ID);

	int updateEndApd(String APD_IDX);


}
