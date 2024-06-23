package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	// 관리자
	Map<String, Object> selectAdmin(Map<String, String> admin);
	int insertAdminAccount(Map<String, Object> admin);
	
	// List 조회작업
	List<Map<String, Object>> selectUserList(Map<String, Object> data);
	List<Map<String, Object>> selectProductList(Map<String, Object> data);
	List<Map<String, Object>> selectAdminList(Map<String, Object> data);
	List<Map<String, Object>> selectCommonList(Map<String, Object> data);
	List<Map<String, Object>> selectAuctionList(Map<String, Object> data);
	List<Map<String, Object>> selectReportList(Map<String, Object> data);
	List<Map<String, Object>> selectCommunityList(Map<String, Object> data);
 	
	// 셀렉트박스 리스트 조회작업
	List<Map<String, Object>> selectCodeCategoryList();
	List<Map<String, Object>> selectAuctionCategoryList();
	List<Map<String, Object>> selectAdminRoleList();
	
	// 공통코드 관리
	int patchcommon(Map<String, Object> data);
	int insertCommon(Map<String, Object> data);
	int deleteCommon(Map<String, Object> data);
	int changeActive(Map<String, Object> data);
	int changeHide(Map<String, Object> data);
	
	// 기타
	int patchAuctionProductStatus(Map<String, Object> data);
}
