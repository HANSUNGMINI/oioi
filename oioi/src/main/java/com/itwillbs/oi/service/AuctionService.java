package com.itwillbs.oi.service;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.AdminMapper;
import com.itwillbs.oi.mapper.AuctionMapper;

@Service
public class AuctionService {
	
	@Autowired
	private AuctionMapper mapper;

	public List<Map<String, String>> getCategory1() {
		System.out.println("auctionRegist - sevice");
		return mapper.getCategory1();
	}

	public List<Map<String, String>> getCategory2() {
		return mapper.getCategory2();
	}

	public List<Map<String, String>> getCategory3() {
		// TODO Auto-generated method stub
		return mapper.getCategory3();
	}
	
	public List<Map<String, String>> getCate1Edit(Map<String, Object> param) {
		return mapper.getCate1Edit(param);
	}
	public List<Map<String, String>> getCate2Edit(Map<String, Object> param) {
		return mapper.getCate2Edit(param);
	}
	public List<Map<String, String>> getCate3Edit(Map<String, Object> param) {
		return mapper.getCate3Edit(param);
	}

	public int insertImg(Map<String, String> fileMap) {
	 	Map<String, Object> paramMap = new HashMap<>(fileMap);
        mapper.insertImg(paramMap);
        BigInteger bigIntImgIdx = (BigInteger) paramMap.get("imgIdx");
        return bigIntImgIdx.intValue(); // BigInteger를 int로 변환하여 리턴
	}

	public int insertAPD(Map<String, Object> map) {
		return mapper.insertAPD(map);
	}

	public String[] categoryName(Map<String, Object> map) {
		return mapper.categoryName(map);
	}

	public List<Map<String, Object>> selectApdList(Map<String, Object> params) {
		return mapper.selectApdList(params);
	}

	public Map<String, String> selectApdDetail(Map<String, String> map) {
		return mapper.selectApdDetail(map);
	}

	public String selectACR(String APD_IDX) {
		return mapper.selectACR(APD_IDX);
	}

	public String insertACR(String APD_IDX) {
		return mapper.insertACR(APD_IDX);
	}

	public int updateApdBid(Map<String, Object> map) {
		return mapper.updateApdBid(map);
	}

	public int updateApdStatus(String APD_IDX) {
		return mapper.updateApdStatus(APD_IDX);
	}

	public int insertACM(Map<String, Object> map) {
		return mapper.insertACM(map);
	}

	public int insertBid(Map<String, Object> map) {
		return mapper.insertBid(map);
	}

	public List<Map<String, String>> selectBidChart(int APD_IDX) {
		return mapper.selectBidChart(APD_IDX);
	}

	public Map<String, Object> getNewAuctionItems() {
		return mapper.selectNewAuction();
	}

	public List<Map<String, Object>> apdPopular() {
		return mapper.apdPopular();
	}

	public int apdBuyStatus(Map<String, Object> map) {
		if(mapper.updateApdBuyStatus(map) == 1 && mapper.updateApdBuyOiMoney(map)) {
			return 1;
		}else {
			return 0;
		}
	}

	public void auctionFinalBid(Map<String, Object> map) {
		mapper.auctionFinalBid(map);
	}

	public List<Map<String, Object>> getRecentLookProduct(int product) {
		return mapper.getRecentLookProduct(product);
	}

	public String getOiMoney(String US_ID) {
		return mapper.getOiMoney(US_ID);
	}

	public String getAddress(String US_ID) {
		return mapper.selectAddress(US_ID);
	}

	public void apdTrade(Map<String, Object> map) {
		mapper.insertApdTrade(map);
	}

	public String getProfile(String US_ID) {
		return mapper.selectProfile(US_ID);
	}

	public List<Map<String, Object>> getReportMsg(Map<String, String> map) {
		return mapper.selectReportMsg(map);
	}

	public Map<String, String> getUserInfo(String US_ID) {
		return mapper.selectUserInfo(US_ID);
	}

	public int endApd(String APD_IDX) {
		return mapper.updateEndApd(APD_IDX);
	}

	

	

	

	
	
}
