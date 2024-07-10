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

	String selectBankAccessToken(String userId);

	Map<String, Object> selectBankUserInfo(Object object);

	void updateChargeOimoney(Map<String, Object> map);
	
	Map<String, Object> selectTradePDInfo(int PD_IDX);

	int selectOiMoney(String id);

	// 안전 결제 후 
	void updatePdStatus(Map<String, String> map);
	void updateMinusOimoney(Map<String, String> map);
	void insertTDinfo(Map<String, String> map);

	// 구매확정 후 판매자 머니 충전
	void updatePlusOimoney(Map<String, String> map);
	void updatePdStatus2(Map<String, String> map);

	// 출금하기
	void updateRefundOimoney(Map<String, Object> map);




	
	// 관리자 엑세스 토큰 정보 저장
//	void insertAdminToken(BankTokenVO adminToken);
//
//	// 관리자 엑세스 토큰 정보 갱신
//	void updateAdminToken(BankTokenVO adminToken);
//
//	BankUserInfoVO selectBankUserInfo(String id);


}
