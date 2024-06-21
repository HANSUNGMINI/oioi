package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.StoreMapper;

@Service
public class StoreService {
	@Autowired
	private StoreMapper mapper;

	public List<Map<String, Object>> selectMyPd(String id) {
		
		return mapper.selectMyPd(id);
	}

}
