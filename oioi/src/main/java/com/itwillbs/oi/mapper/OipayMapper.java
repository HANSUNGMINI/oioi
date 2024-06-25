package com.itwillbs.oi.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OipayMapper {

	// 핀테크 엑세스 토큰 정보(아이디) 조회
	String selectId(Map<String, Object> map);

	// 핀테크 엑세스 토큰 정보 저장
	void insertAccessToken(Map<String, Object> map);

	// 핀테크 엑세스 토큰 정보 갱신
	void updateAccessToken(Map<String, Object> map);

	// 관리자 엑세스 토큰 정보 조회
	String selectAdminToken();
	
	// 관리자 엑세스 토큰 정보 저장
//	void insertAdminToken(BankTokenVO adminToken);
//
//	// 관리자 엑세스 토큰 정보 갱신
//	void updateAdminToken(BankTokenVO adminToken);
//
//	BankUserInfoVO selectBankUserInfo(String id);


}
