package com.itwillbs.oi.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.AdminMapper;

@Service
public class AdminService {
	@Autowired
	private AdminMapper adminMapper;
	
	public Map<String, Object> selectAdmin(Map<String, String> admin){
		return adminMapper.selectAdmin(admin);
	}
}
