package com.itwillbs.oi.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.oi.handler.OipayApiClient;
import com.itwillbs.oi.mapper.OipayMapper;

@Service
public class OipayService {
	@Autowired
	private OipayApiClient bankApiClient;
	
	@Autowired
	private OipayMapper mapper;
	
	@Autowired
	HttpSession session;
	
	// 엑세스토큰 발급 요청
	public Map<String, Object> getAccessToken(Map<String, String> authResponse) {
		// BankApiClient - requestAccessToken() 메서드 호출하여 엑세스토큰 발급을 위한 요청 수행
		// => 파라미터 : Map 객체   리턴타입 : ResponseTokenVO
		return bankApiClient.requestAccessToken(authResponse);
	}

	public void registAccessToken(Map<String, Object> map) {
		
		// BankMapper - selectTokenInfo() 메서드 호출하여 아이디가 일치하는 레코드 존재 여부 확인
		// => 파라미터 : Map 객체   리턴타입 : String(id)(아이디값만 조회)
		
		String id = mapper.selectId(map);
//		System.out.println("111111111111111111111111111" + id);
		
		// 아이디 존재 여부 판별
		// => 아이디 존재하지 않을 경우 - 새 엑세스 토큰 INSERT(insertAccessToken())
		// => 아이디 존재할 경우 - 기존 엑세스 토큰 UPDATE(updateAccessToken())
		if(id == null) { 
			mapper.insertAccessToken(map);
		} else {
			mapper.updateAccessToken(map);
		}
	}


	public String selectBankAccessToken(String userId) {
		return mapper.selectBankAccessToken(userId);
	}
	
	public Map<String, Object> selectUserBankInfo(Object object) {
		return mapper.selectBankUserInfo(object);
	}

	public Map getUserInfo(Map<String, Object> token) {
		return bankApiClient.requestUserInfo(token);
	}

	public Map withdraw(Map<String, Object> map) {
		return bankApiClient.requestWithdraw(map);
	}

	public void updateOimoney(Map<String, Object> map) {
		mapper.updateOimoney(map);
	}

	public Map<String, Object> selectTradePDInfo(int PD_IDX) {
		return mapper.selectTradePDInfo(PD_IDX);
	}

	public int selectOiMoney(String id) {
		return mapper.selectOiMoney(id);
	}

	@Transactional
	public void purchaseByOimoney(Map<String, String> map) {
		mapper.updatePdStatus(map);
		mapper.updateUseOimoney(map);
		
	}
	
//	// 엑세스토큰 정보를 사용하여 핀테크 사용자 정보 조회 요청
//	public Map getUserInfo(BankTokenVO token) {
//		// BankApiClient - requestUserInfo() 메서드 호출
//		return bankApiClient.requestUserInfo(token);
//	}
//
//	// 핀테크 사용자 계좌 상세정보 조회 요청
//	public Map getAccountDetail(Map<String, Object> map) {
//		// BankApiClient - requestAccountDetail() 메서드 호출
//		return bankApiClient.requestAccountDetail(map);
//	}
//
//	// 핀테크 출금이체 요청
//	public Map withdraw(Map<String, Object> map) {
//		// BankApiClient - requestWithdraw() 메서드 호출
//		return bankApiClient.requestWithdraw(map);
//	}
//
//	// 관리자 엑세스토큰 발급 요청
//	public BankTokenVO getAdminAccessToken() {
//		// BankApiClient - requestAdminAccessToken() 메서드 호출
//		return bankApiClient.requestAdminAccessToken();
//	}
//
//	// 관리자 엑세스토큰 저장 요청
//	public void registAdminToken(BankTokenVO adminToken) {
//		// 관리자 아이디("admin") 에 대한 엑세스토큰을 조회하여
//		// 1) 토큰이 존재하지 않을 경우 BankMapper - insertAdminToken() 메서드 호출하여 새 토큰 등록
//		// 2) 토큰이 존재할 경우 BankMapper - updateAdminToken() 메서드 호출하여 토큰 정보 갱신
//		if(mapper.selectAdminToken() == null) {
//			mapper.insertAdminToken(adminToken);
//		} else {
//			mapper.updateAdminToken(adminToken);
//		}
//		
//	}
//
//	// 핀테크 입금이체 요청
//	public Map deposit(Map<String, Object> map) {
//		// BankMapper - selectAdminToken() 메서드 호출하여 관리자 엑세스 토큰 조회 후
//		// 조회된 토큰 관련 객체(BankTokenVO)을 Map 객체의 "token" 이라는 이름으로 저장(덮어쓰기)
//		// => 파라미터 : 없음   리턴타입 : String(adminToken)
//		String adminToken = mapper.selectAdminToken();
//		BankTokenVO token = (BankTokenVO)map.get("token");
//		token.setAccess_token(adminToken);
//		
//		// BankApiClient - requestDeposit() 메서드 호출
//		return bankApiClient.requestDeposit(map);
//	}
//
//	// 사용자 계좌정보 조회 요청
//	public BankUserInfoVO getBankUserInfo(String id) {
//		// BankMapper - selectBankUserInfo() 메서드 호출하여 사용자 계좌정보 조회 요청
//		// => 파라미터 : 아이디   리턴타입 : BankUserInfoVO
//		return mapper.selectBankUserInfo(id);
//	}
//
//	public void transfer(Map<String, Object> map) {
//		// [ 송금 작업 수행 ]
//		// 1단계. 보내는 사람 -> 핀테크이용기관(아이티윌)  출금이체 수행
//		// 2단계. 핀테크이용기관(아이티윌) -> 받는 사람    입금이체 수행
//		// ----------------------------------------------------------------
//		// BankApiClient - requestWithdraw2() 메서드 호출하여 출금 이체 요청
//		// => 파라미터 : Map 객체   리턴타입 : Map
//		Map withdrawResult = bankApiClient.requestWithdraw2(map);
//		System.out.println("withdrawResult : " + withdrawResult);
//		
//		// Map 객체(map)에 withdrawResult 저장
//		map.put("withdrawResult", withdrawResult);
//		
//		if(withdrawResult.get("rsp_code").equals("A0000")) { // 출금이체 응답 코드 : 성공(A0000)
//			// ----------------------------------------------------------------
//			// BankMapper - selectAdminToken() 메서드 호출하여 관리자 엑세스 토큰 조회 후
//			// 조회된 토큰을 Map 객체의 "adminToken" 이라는 이름으로 저장
//			// => 파라미터 : 없음   리턴타입 : String(adminToken)
//			String adminToken = mapper.selectAdminToken();
//			map.put("adminToken", adminToken);
//			// -----------------------------------------------------------------
//			// BankApiClient - requestDeposit2() 메서드 호출하여 출금 이체 요청
//			// => 파라미터 : Map 객체   리턴타입 : Map
//			Map depositResult = bankApiClient.requestDeposit2(map);
//			System.out.println("depositResult : " + depositResult);
//			
////			if(depositResult.get("rsp_code").equals("A0000")) { // 입금이체 응답 코드 : 성공(A0000)
////				// 입금이체 성공 시 수행할 작업...
////			}
//			
//			// Map 객체(map)에 depositResult 저장
//			map.put("depositResult", depositResult);
//		}
//		
////		return map;
//		
//	}
//
//	public void getTransferResult(Map<String, String> map) {
////		bankApiClient.requestTransferResult(map);
//	}

}












