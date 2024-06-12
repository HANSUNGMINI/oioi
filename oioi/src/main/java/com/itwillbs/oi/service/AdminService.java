package com.itwillbs.oi.service;

import java.util.List;
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
	
	public List<Map<String, Object>> selectUserList(Map<String, String> select){
		return adminMapper.selectUserList(select);
	}
}
