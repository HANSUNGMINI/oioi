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
	List<Map<String, Object>> selectCategoryList(Map<String, Object> data);
 	
	// 셀렉트박스 리스트 조회작업
	List<Map<String, Object>> selectCodeCategoryList();
	List<Map<String, Object>> selectAuctionCategoryList();
	List<Map<String, Object>> selectAdminRoleList();
	List<Map<String, Object>> selectRejectionList();
	List<Map<String, Object>> selectCategoryCodeList();
	List<Map<String, Object>> selectOptionList(String name);

	
	// 공통코드 관리
	int patchcommon(Map<String, Object> data);
	int insertCommon(Map<String, Object> data);
	int deleteCommon(Map<String, Object> data);
	int changeActive(Map<String, Object> data);
	int changeHide(Map<String, Object> data);
	
	// 카테고리 코드 관리
	
	int patchCategory(Map<String, Object> select);
	int insertCategory(Map<String, Object> select);
	int changeCTG_Hide(Map<String, Object> select);
	
	// 기타
	int insertAuctionProduct(Map<String, String> data);
	int updateReportStatus(Map<String, String> data);
	int updateUserStatus(Map<String, String> data);
	int updateUpdateAPD(Map<String, String> data);
	int regMainBanner(Map<String, String> data);
	
	Map<String, Object> selectDetailUser(Map<String, Object> data);
	Map<String, Object> selectDetailReport(Map<String, Object> data);
	Map<String, Object> selectDetailAP(Map<String, Object> data);
	
	Map<String, String> selectAuctionItem(Map<String, String> data);
	List<Map<String, String>> selectMostRegist();
}
