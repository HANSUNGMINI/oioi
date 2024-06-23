package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	// 관리자 로그인 작업
	Map<String, Object> selectAdmin(Map<String, String> admin);
	
	// List 조회작업
	List<Map<String, Object>> selectUserList(Map<String, Object> data);
	List<Map<String, Object>> selectProductList(Map<String, Object> data);
	List<Map<String, Object>> selectAdminList(Map<String, Object> data);
	List<Map<String, Object>> selectCommonList(Map<String, Object> data);
	List<Map<String, Object>> selectAuctionList(Map<String, Object> data);
	List<Map<String, Object>> selectReportList(Map<String, Object> data);
 	
	// 셀렉트박스 리스트 조회작업
	List<Map<String, Object>> selectCodeCategoryList();
	List<Map<String, Object>> selectAuctionCategoryList();
	
	// Status 변경 작업
	int changeActive(Map<String, Object> data);
	int changeHide(Map<String, Object> data);
	
	// 공통코드
	int patchcommon(Map<String, Object> data);
	int insertCommon(Map<String, Object> data);
	int deleteCommon(Map<String, Object> data);
}
