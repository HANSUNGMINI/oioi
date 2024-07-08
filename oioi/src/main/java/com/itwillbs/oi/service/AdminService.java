package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public List<Map<String, Object>> selectCategoryList(Map<String, Object> data){ return adminMapper.selectCategoryList(data); }
	// List 조회 끝
	
	// 셀렉트박스 조회
	public List<Map<String, Object>> selectCodeCategoryList(){ return adminMapper.selectCodeCategoryList();}
	public List<Map<String, Object>> selectAuctionCategoryList(){ return adminMapper.selectAuctionCategoryList(); }
	public List<Map<String, Object>> selectAdminRoleList(){ return adminMapper.selectAdminRoleList(); }
	public List<Map<String, Object>> selectRejectionList(){ return adminMapper.selectRejectionList(); }
	public List<Map<String, Object>> selectCategoryCodeList(){ return adminMapper.selectCategoryCodeList(); }
	public List<Map<String, Object>> selectOptionList(String name){ return adminMapper.selectOptionList(name); }
	
	// 공통코드 관리
	public int changeActive(Map<String, Object> data){ return adminMapper.changeActive(data); }
	public int changeHide(Map<String, Object> select){ return adminMapper.changeHide(select); }
	public int patchcommon(Map<String, Object> select){ return adminMapper.patchcommon(select); }
	public int insertCommon(Map<String, Object> select){ return adminMapper.insertCommon(select); }
	
	// 카테고리 코드 관리
	public int patchCategory(Map<String, Object> select){ return adminMapper.patchCategory(select); }
	public int insertCategory(Map<String, Object> select){ return adminMapper.insertCategory(select); }
	public int changeCTG_Hide(Map<String, Object> select){ return adminMapper.changeCTG_Hide(select); }
	
	// 다른 거
	public Map<String, Object> selectDetailUser(Map<String, Object> map){ return adminMapper.selectDetailUser(map); }
	public Map<String, Object> selectDetailReport(Map<String, Object> map){ return adminMapper.selectDetailReport(map); }
	public Map<String, Object> selectDetailAP(Map<String, Object> map){ return adminMapper.selectDetailAP(map); }
	
	public int updateReportStatus(Map<String, String> map){ return adminMapper.updateReportStatus(map); }
	public int updateUserStatus(Map<String, String> map){ return adminMapper.updateUserStatus(map); }
	public int regMainBanner(Map<String, String> map){ return adminMapper.regMainBanner(map); }
	public List<Map<String, String>> selectMostRegist(){return adminMapper.selectMostRegist();}
	
	
	public Map<String, String> selectAuctionItem(Map<String, String> map){ return adminMapper.selectAuctionItem(map); }
	@Transactional
	public int updateUpdateAPD(Map<String, String> map){
		// APD05 상품등록 일 때 
		if(map.get("APD_STATUS").equals("APD05")) {
			adminMapper.insertAuctionProduct(map);
		}
		return adminMapper.updateUpdateAPD(map); 
	}
	
}
