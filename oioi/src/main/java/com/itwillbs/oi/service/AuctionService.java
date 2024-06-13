package com.itwillbs.oi.service;

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
	
	
}
