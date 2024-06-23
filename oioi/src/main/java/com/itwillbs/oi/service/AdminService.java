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
	
	// 관리자
	public Map<String, Object> selectAdmin(Map<String, String> admin){ return adminMapper.selectAdmin(admin); }
	public int insertAdminAccount(Map<String, Object> admin){ return adminMapper.insertAdminAccount(admin); }
	
	// List 조회
	public List<Map<String, Object>> selectCommonList(Map<String, Object> data){ return adminMapper.selectCommonList(data); }
	public List<Map<String, Object>> selectProductList(Map<String, Object> data){ return adminMapper.selectProductList(data); }
	public List<Map<String, Object>> selectAdminList(Map<String, Object> data){ return adminMapper.selectAdminList(data); }
	public List<Map<String, Object>> selectUserList(Map<String, Object> data){ return adminMapper.selectUserList(data); }
	public List<Map<String, Object>> selectAuctionList(Map<String, Object> data){ return adminMapper.selectAuctionList(data); }
	public List<Map<String, Object>> selectReportList(Map<String, Object> data){ return adminMapper.selectReportList(data); }
	public List<Map<String, Object>> selectCommunityList(Map<String, Object> data){ return adminMapper.selectCommunityList(data); }
	// List 조회 끝
	
	// 셀렉트박스 조회
	public List<Map<String, Object>> selectCodeCategoryList(){ return adminMapper.selectCodeCategoryList();}
	public List<Map<String, Object>> selectAuctionCategoryList(){ return adminMapper.selectAuctionCategoryList(); }
	public List<Map<String, Object>> selectAdminRoleList(){ return adminMapper.selectAdminRoleList(); }
	
	// 공통코드 관리
	public int changeActive(Map<String, Object> data){ return adminMapper.changeActive(data); }
	public int changeHide(Map<String, Object> select){ return adminMapper.changeHide(select); }
	public int patchcommon(Map<String, Object> select){ return adminMapper.patchcommon(select); }
	public int insertCommon(Map<String, Object> select){ return adminMapper.insertCommon(select); }
	public int deleteCommon(Map<String, Object> select){ return adminMapper.deleteCommon(select); }
	
}
