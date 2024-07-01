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

	public Map<String, String> selectACR(String APD_IDX) {
		return mapper.selectACR(APD_IDX);
	}

	public int insertACR(String APD_IDX) {
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

	public List<Map<String, Object>> getNewAuctionItems() {
		return mapper.selectAuctionList();
	}

	

	

	
	
}
