package com.itwillbs.oi.handler;

import java.net.URI;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

// @Component 어노테이션 사용 시 @Service, @Repository 등의 어노테이션을 대체 가능
// => 보편적인 용도의 클래스에 적용
@Component
public class OipayApiClient {
	@Autowired
	private BankValueGenerator bankValueGenerator;
	// ------------------------------------------------------------------------------
	/*
	 * 오픈뱅킹 API 요청 시 사용할 데이터 저장
	 * => src/main/resources/config/appdata.properties 파일 내의 속성값 연결
	 *    (servlet-context.xml 파일 내에 설정 필수!)
	 * client_id=4066d795-aa6e-4720-9383-931d1f60d1a9
	 * client_secret=36b4a668-94ba-426d-a291-771405e498e4
	 * client_use_code=M202113854
	 * cntr_account_num=23062003999
	 * base_url=https://testapi.openbanking.or.kr
	 */
	@Value("${client_id}")
	private String client_id;
	@Value("${client_secret}")
	private String client_secret;
	@Value("${client_use_code}")
	private String client_use_code;
	@Value("${cntr_account_num}")
	private String cntr_account_num;
	@Value("${base_url}")
	private String base_url;
	// ------------------------------------------------------------------------------
	// 로깅을 위한 Logger 타입 객체 생성(주의! 현재 클래스를 파라미터로 전달해야함)
//	private static final Logger logger = LoggerFactory.getLogger(OipayApiClient.class);
	
	// 2.1.2. 토큰발급 API - 사용자 토큰발급 API (3-legged) 요청(POST)
	// 요청 URL : https://testapi.openbanking.or.kr/oauth/2.0/token
	// 요청 파라미터 : code, client_id, client_secret, redirect_uri, grant_type
	public Map<String, Object> requestAccessToken(Map<String, String> authResponse) {
		// 금융결제원 오픈API 의 토큰 발급 API 요청 작업 수행 및 처리
		// POST 방식 요청을 수행할 URL 정보를 URI 타입 객체로 생성
		URI uri = UriComponentsBuilder
					.fromUriString("https://testapi.openbanking.or.kr/oauth/2.0/token") // 기본 요청 주소
					.encode() // 주소 인코딩
					.build()  // UriComponents 타입 객체 생성
					.toUri(); // URI 타입 객체로 변환
		
		// POST 방식 요청의 경우 파라미터(데이터)를 URL 에 결합시키지 않고
		// 별도로 body 에 포함시켜 전달해야한다.
		// 따라서, 해당 파라미터 데이터를 별도의 객체로 생성하여 전달 필요
		// => LinkedMultiValueMap 객체 활용
		// 1) LinkedMultiValueMap 타입 객체 생성(제네릭타입은 파라미터이므로 String, String 타입 지정)
		LinkedMultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		// 2) LinkedMultiValueMap 객체의 add() 메서드를 호출하여 ("키", "값") 형식으로 파라미터 설정
		parameters.add("code", authResponse.get("code")); // 인증코드 요청을 통해 응답받은 코드
//		parameters.add("client_id", "4066d795-aa6e-4720-9383-931d1f60d1a9");
//		parameters.add("client_secret", "36b4a668-94ba-426d-a291-771405e498e4");
		// client_id 와 client_secret 값을 하드코딩하지 않고
		// appdata.properties 파일 내의 값을 가져와서 전달
		parameters.add("client_id", client_id);
		parameters.add("client_secret", client_secret);
		parameters.add("redirect_uri", "http://localhost:8081/oi/callback");
		parameters.add("grant_type", "authorization_code");
		
		// HttpEntity 객체를 활용하여 요청에 사용될 파라미터가 저장된 객체를 요청 형식에 맞게 변환
		// => HttpEntity 객체는 헤더와 바디 정보를 함께 관리하는 객체
		// => 제네릭타입은 파라미터를 관리하는 객체 타입으로 지정하고
		//    생성자 파라미터로 파라미터 관리하는 객체 전달
		// => 바디 정보만 설정하고, 헤더 정보는 기본적인 헤더값 사용하므로 설정 생략
		HttpEntity<LinkedMultiValueMap<String, String>> httpEntity = 
				new HttpEntity<LinkedMultiValueMap<String,String>>(parameters);
		
		// REST API(RESTful API) 요청을 위해 RestTemplate 객체 활용
		// 1) RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		// 2) RestTemplate 객체의 exchange() 메서드 호출하여 POST 방식 요청 수행
		//    => 파라미터 : 요청 URL 을 관리하는 URI 객체,
		//                  요청 메서드,
		//                  요청 정보를 관리하는 HttpEntity 객체,
		//                  요청에 대한 응답 전달 시 응답 데이터를 파싱하여 관리할 클래스
		//    => 이 메서드가 호출되는 시점에 실제 HTTP 요청 발생함
		//    => 리턴타입 : ResponseEntity<T> 타입이며, 제네릭타입 T 는 XXX.class 로 지정한 타입으로 바뀜
		//                  => 주의! JSON 타입 응답 데이터를 XXX.class 타입으로 자동 파싱을 위해서
		//                     Gson, Jackson 등의 JSON 데이터 파싱 라이브러리 필요!
		//                     (자동 파싱 불가능할 경우 UnknownContentTypeException 예외 발생)
		//                     (org.springframework.web.client.UnknownContentTypeException: Could not extract response: no suitable HttpMessageConverter found for response type [interface java.util.Map] and content type [application/json;charset=UTF-8])
		// 2-1) 응답 데이터(JSON)를 Map 타입 객체로 파싱할 경우
//		ResponseEntity<Map> responseEntity 
//					= restTemplate.exchange(uri, HttpMethod.POST, httpEntity, Map.class);
		// 2-2) 응답 데이터(JSON)를 XXXVO 타입 객체로 파싱할 경우
		ResponseEntity<Map> responseEntity 
					= restTemplate.exchange(uri, HttpMethod.POST, httpEntity, Map.class);
		
		// 응답 정보 확인을 위해 ResponseEntity 객체의 메서드 활용
//		logger.info("응답 코드 : " + responseEntity.getStatusCode());
//		logger.info("응답 헤더 : " + responseEntity.getHeaders());
//		logger.info("응답 본문 : " + responseEntity.getBody());
		
		// 응답 정보 리턴
		// 1) 응답 정보 전체가 저장된 ResponseEntity<T> 타입 객체 그대로 리턴
//		return responseEntity;
		// 2) 응답 정보 중에서 실제로 활용할 데이터가 저장된 
		//    ResponseEntity 객체의 getBody() 메서드 리턴값을 리턴
		return responseEntity.getBody();
	}

//	// 2.2. 사용자/서비스 관리 - 2.2.1. 사용자정보조회 API - GET
//	// https://testapi.openbanking.or.kr/v2.0/user/me
//	public Map requestUserInfo(BankTokenVO token) {
//		// 1. 사용자 정보 조회 API 의 경우 헤더 정보에 엑세스토큰 값을 담아 전송해야하므로
//		//    헤더 정보를 관리할 HttpHeaders 객체 생성 후 add() 메서드로 헤더 정보 추가
//		//    (추가할 헤더 정보가 복수개일 경우 LinkedMultiValueMap 객체 활용도 가능)
//		//    (=> HttpHeaders 객체 생성 시 생성자에 LinkedMultiValueMap 객체 전달)
//		HttpHeaders headers = new HttpHeaders();
//		// 1-1) 헤더 정보를 문자열 형태로 동일하게 설정할 경우 - add() 메서드 활용
//		// => 헤더명 : "Authorization"
//		//    헤더값 : "Bearer" 문자열과 엑세스토큰 문자열 결합(공백으로 구분)
//		headers.add("Authorization", "Bearer " + token.getAccess_token());
////		headers.set
//		
//		// 2. 헤더와 바디를 묶어서 관리하는 HttpEntity 객체 생성
//		//    => 생성자 파라미터로 헤더 정보 관리하는 HttpHeaders 객체 전달 가능
//		//    => 제네릭타입은 String 타입 지정(모든 헤더 정보는 문자열로 관리됨)
//		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
//		
//		// 3. HTTP 요청에 필요한 URI 정보 생성
//		// => GET 방식 요청 시 전달할 파라미터는 queryParam() 메서드로 직접 전달 가능
//		URI uri = UriComponentsBuilder
//				.fromUriString(base_url) // 기본 요청 주소
//				.path("/v2.0/user/me") // 작업 요청 상세 주소(세부 경로)
//				.queryParam("user_seq_no", token.getUser_seq_no()) // 파라미터
//				.encode() // 주소 인코딩
//				.build()  // UriComponents 타입 객체 생성
//				.toUri(); // URI 타입 객체로 변환
//		
//		// 4. RESTful API 요청을 위한 RestTemplate 객체 생성
//		RestTemplate restTemplate = new RestTemplate();
//		
//		// 5. RestTemplate 객체의 exchange() 메서드 호출하여 HTTP 요청 수행 - GET
//		// => 파라미터 : URI 객체, 요청 방식, HttpEntity 객체, 응답데이터 파싱하여 관리할 클래스타입
//		// => 리턴타입 : ResponseEntity<Map>
//		ResponseEntity<Map> responseEntity 
//					= restTemplate.exchange(uri, HttpMethod.GET, httpEntity, Map.class);
//					
//		// 6. ResponseEntity 객체의 getBody() 메서드 호출하여 응답데이터 파싱 결과 객체 리턴
//		return responseEntity.getBody();
//	}
//
//	// 2.3. 계좌조회 서비스(사용자) - 2.3.1. 잔액조회 API
//	// https://testapi.openbanking.or.kr/v2.0/account/balance/fin_num
//	// => 잔액조회 테스트 데이터가 등록되어 있는 경우에만 사용 가능(없을 경우 응답 에러 전송됨)
//	public Map requestAccountDetail(Map<String, Object> map) {
//		BankTokenVO token = (BankTokenVO)map.get("token");
//		
//		String bank_tran_id = bankValueGenerator.getBankTranId();
//		String tran_dtime = bankValueGenerator.getTranDTime();
//		logger.info(">>>>>>>> 은행거래고유번호(bank_tran_id) : " + bank_tran_id);
//		logger.info(">>>>>>>> 요청일시(tran_dtime) : " + tran_dtime);
//		
//		// 1. 사용자 정보 조회 API 의 경우 헤더 정보에 엑세스토큰 값을 담아 전송해야하므로
//		//    헤더 정보를 관리할 HttpHeaders 객체 생성 후 add() 메서드로 헤더 정보 추가
//		//    (추가할 헤더 정보가 복수개일 경우 LinkedMultiValueMap 객체 활용도 가능)
//		//    (=> HttpHeaders 객체 생성 시 생성자에 LinkedMultiValueMap 객체 전달)
//		HttpHeaders headers = new HttpHeaders();
//		// 1-1) 헤더 정보를 문자열 형태로 동일하게 설정할 경우 - add() 메서드 활용
//		// => 헤더명 : "Authorization"
//		//    헤더값 : "Bearer" 문자열과 엑세스토큰 문자열 결합(공백으로 구분)
//		headers.add("Authorization", "Bearer " + token.getAccess_token());
//		// 1-2) Bearer 토큰 형식으로 엑세스토큰 전달 시 setBearerAuth() 메서드 활용 가능
////		headers.setBearerAuth(token.getAccess_token());
//		
//		// 2. 헤더와 바디를 묶어서 관리하는 HttpEntity 객체 생성
//		//    => 생성자 파라미터로 헤더 정보 관리하는 HttpHeaders 객체 전달 가능
//		//    => 제네릭타입은 String 타입 지정(모든 헤더 정보는 문자열로 관리됨)
//		HttpEntity<String> httpEntity = new HttpEntity<String>(headers);
//		
//		// 3. HTTP 요청에 필요한 URI 정보 생성
//		// => GET 방식 요청 시 전달할 파라미터는 queryParam() 메서드로 직접 전달 가능
//		URI uri = UriComponentsBuilder
//				.fromUriString(base_url) // 기본 요청 주소
//				.path("/v2.0/account/balance/fin_num") // 작업 요청 상세 주소(세부 경로)
//				.queryParam("bank_tran_id", bank_tran_id) // 파라미터
//				.queryParam("fintech_use_num", map.get("fintech_use_num")) // 파라미터
//				.queryParam("tran_dtime", tran_dtime) // 파라미터
//				.encode() // 주소 인코딩
//				.build()  // UriComponents 타입 객체 생성
//				.toUri(); // URI 타입 객체로 변환
//		
//		// 4. RESTful API 요청을 위한 RestTemplate 객체 생성
//		RestTemplate restTemplate = new RestTemplate();
//		
//		// 5. RestTemplate 객체의 exchange() 메서드 호출하여 HTTP 요청 수행 - GET
//		// => 파라미터 : URI 객체, 요청 방식, HttpEntity 객체, 응답데이터 파싱하여 관리할 클래스타입
//		// => 리턴타입 : ResponseEntity<Map>
//		ResponseEntity<Map> responseEntity 
//					= restTemplate.exchange(uri, HttpMethod.GET, httpEntity, Map.class);
//					
//		// 6. ResponseEntity 객체의 getBody() 메서드 호출하여 응답데이터 파싱 결과 객체 리턴
//		return responseEntity.getBody();
//	}
//
//	// 2.5. 계좌이체 서비스 - 2.5.1. 출금이체 API
//	// https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num
//	public Map requestWithdraw(Map<String, Object> map) {
//		BankTokenVO token = (BankTokenVO)map.get("token");
//		
//		// 1. 사용자 정보 조회 API 의 경우 헤더 정보에 엑세스토큰 값을 담아 전송해야하므로
//		//    헤더 정보를 관리할 HttpHeaders 객체 생성 후 정보 추가
//		HttpHeaders headers = new HttpHeaders();
//		// 1-1) 헤더 정보를 문자열 형태로 동일하게 설정할 경우 - add() 메서드 활용
//		// => 헤더명 : "Authorization"
//		//    헤더값 : "Bearer" 문자열과 엑세스토큰 문자열 결합(공백으로 구분)
////		headers.add("Authorization", "Bearer " + token.getAccess_token());
//		// 1-2) Bearer 토큰 형식으로 엑세스토큰 전달 시 setBearerAuth() 메서드 활용 가능
//		headers.setBearerAuth(token.getAccess_token());
//		
//		// 전송할 컨텐츠 타입이 "application/json; charset=UTF-8" 타입을 요구하므로
//		// setContentType() 메서드 활용하여 JSON 타입으로 설정
//		// => 전송 파라미터로 MediaType.APPLICATION_JSON 상수 활용
//		//    (주의! APPLICATION_JSON_UTF8 상수는 사용하지 않음 = Deprecated)
//		headers.setContentType(MediaType.APPLICATION_JSON);
//		
//		// 2. 요청에 필요한 URI 정보 생성 => 문자열로 바로 생성
//		String url = base_url + "/v2.0/transfer/withdraw/fin_num";
//		
//		// 3. 요청 파라미터를 JSON 형식의 데이터로 생성
//		// => org.json.JSONObject 클래스 또는 com.google.code.gson.Gson 클래스 활용
//		// 3-1) JSONObject 클래스 활용 => put() 메서드로 JSON 데이터 추가
////		JSONObject jo = new JSONObject();
////		jo.put("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호(참가기관)
//		// => 이후 JSON 데이터 전달 시 jo.toString() 메서드 호출하여 문자열로 변환하여 전달
//		
//		// 3-2) Gson 클래스와 JsonObject 클래스 활용(JsonObject 클래스명 주의! JSONObject 아님!!)
//		// 1) Gson 클래스 인스턴스 생성
//		Gson gson = new Gson();
//		// 2) JsonObject 클래스 인스턴스 생성
//		JsonObject jsonObject = new JsonObject(); // 기본 생성자만 제공됨
//		// 3) JsonObject 객체의 addProperty() 메서드 호출하여 JSON 데이터 추가
//		// ---------- 핀테크 이용기관 정보 ----------
//		jsonObject.addProperty("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호(참가기관)
//		jsonObject.addProperty("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌)
////		jsonObject.addProperty("cntr_account_num", "23062003999"); // 약정 계좌/계정 번호(핀테크 서비스 기관 계좌)
//		jsonObject.addProperty("cntr_account_num", cntr_account_num); // appdata.properties 파일 내의 값 활용
//		jsonObject.addProperty("dps_print_content", map.get("id") + "_출금"); // 입금계좌인자내역(입금되는 계좌에 출력할 메세지)
//		
//		// ---------- 요청 고객(출금 계좌) 정보 ----------
//		jsonObject.addProperty("fintech_use_num", (String)map.get("withdraw_fintech_use_num")); // 출금계좌 핀테크이용번호 
//		jsonObject.addProperty("wd_print_content", "아이티윌_입금"); // 출금계좌인자내역(출금되는 계좌에 출력할 메세지)
//		jsonObject.addProperty("tran_amt", (String)map.get("tran_amt")); // 거래금액
//		jsonObject.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
//		jsonObject.addProperty("req_client_name", (String)map.get("withdraw_user_name")); // 요청고객성명(출금계좌)
//		jsonObject.addProperty("req_client_fintech_use_num", (String)map.get("withdraw_fintech_use_num")); // 요청고객핀테크이용번호(출금계좌)
//		// => 요청고객 계좌번호 미사용 시 핀테크 이용번호 설정 필수!
//		jsonObject.addProperty("req_client_num", ((String)map.get("id")).toUpperCase()); // 요청고객회원번호(아이디처럼 사용) => 영문자 모두 대문자 변환 
//		jsonObject.addProperty("transfer_purpose", "ST"); // 이체 용도(송금 : TR, 결제 : ST 등) 
//		
//		
//		// ---------- 수취 고객(실제 최종 입금 대상) 정보 ----------
//		// 최종적으로 금액을 수신하는 계좌에 대한 정보
//		// 이 정보(3가지)는 피싱 등의 사고 발생 시 지급 정지 등을 위한 정보로 실제 검증 수행 X
//		jsonObject.addProperty("recv_client_name", "아이티윌"); // 최종수취고객성명(입금대상)
//		jsonObject.addProperty("recv_client_bank_code", "002"); // // 최종수취고객계좌 개설기관 표준코드(입금대상)
//		jsonObject.addProperty("recv_client_account_num", "23062003999"); // 최종수취고객계좌번호(입금대상)
//
//		// 최종 요청 파라미터 확인
//		// => Gson 객체의 toJson() 메서드 호출하여 파라미터로 JsonObject 객체 전달
//		logger.info(">>>>>>>> 출금이체 요청 JSON 데이터 : " + gson.toJson(jsonObject));
//		
//		
//		// 4. 요청에 사용될 데이터를 관리하는 HttpEntity 객체 생성
//		// => 파라미터 데이터(body)로 JsonObject 객체를 문자열로 변환하여 전달, 헤더도 전달
//		HttpEntity<String> httpEntity = new HttpEntity<String>(gson.toJson(jsonObject), headers);
//		logger.info(">>>>>>>> httpEntity.getHeaders() : " + httpEntity.getHeaders());
//		logger.info(">>>>>>>> httpEntity.getBody() : " + httpEntity.getBody());
//		
//		
//		// 5. RESTful API 요청을 위한 RestTemplate 객체의 exchange() 메서드 호출하여
//		//    POST 방식 HTTP 요청 수행
//		RestTemplate restTemplate = new RestTemplate();
//		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, Map.class);
//		logger.info(">>>>>>>> 출금 이체 요청 결과 : " + responseEntity.getBody());
//		
//		return responseEntity.getBody();
//		/*
//		 * [ 테스트 데이터 등록 방법 - 출금이체 ]
//		 * 사용자 일련번호, 핀테크이용번호 : 출금 계좌 고객 정보
//		 * => 출금기관 대표코드, 출금계좌번호(출력용 포함) 자동으로 입력됨
//		 * 송금인 실명 : 출금 계좌 고객 성명
//		 * 거래금액 : tran_amt 값 입력
//		 * 입금계좌인자내역 : dps_print_content 값 입력(출금 계좌 고객 성명)
//		 * 수취인 성명 : 핀테크 이용기관 계좌 예금주명 입력(최종 수취인 아님!)
//		 */
//	}
//
//	// 2.1.2. 토큰발급 API - 센터인증 이용기관 토큰발급 API (2-legged) (관리자 토큰 발급용)
//	public BankTokenVO requestAdminAccessToken() {
//		// 금융결제원 오픈API 의 토큰 발급 API 요청 작업 수행 및 처리
//		// POST 방식 요청을 수행할 URL 정보를 URI 타입 객체로 생성(사용자 인증과 URL 동일함)
//		URI uri = UriComponentsBuilder
//					.fromUriString("https://testapi.openbanking.or.kr/oauth/2.0/token") // 기본 요청 주소
//					.encode() // 주소 인코딩
//					.build()  // UriComponents 타입 객체 생성
//					.toUri(); // URI 타입 객체로 변환
//		
//		// POST 방식 요청에 사용될 파라미터 생성(LinkedMultiValueMap 객체 활용)
//		// 1) LinkedMultiValueMap 타입 객체 생성(제네릭타입은 파라미터이므로 String, String 타입 지정)
//		LinkedMultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
//		// 2) LinkedMultiValueMap 객체의 add() 메서드를 호출하여 ("키", "값") 형식으로 파라미터 설정
//		parameters.add("client_id", "4066d795-aa6e-4720-9383-931d1f60d1a9");
//		parameters.add("client_secret", "36b4a668-94ba-426d-a291-771405e498e4");
//		parameters.add("scope", "oob");
//		parameters.add("grant_type", "client_credentials");
//		
//		HttpEntity<LinkedMultiValueMap<String, String>> httpEntity = 
//				new HttpEntity<LinkedMultiValueMap<String,String>>(parameters);
//		
//		RestTemplate restTemplate = new RestTemplate();
//		ResponseEntity<BankTokenVO> responseEntity 
//					= restTemplate.exchange(uri, HttpMethod.POST, httpEntity, BankTokenVO.class);
//		
//		// 응답 정보 확인을 위해 ResponseEntity 객체의 메서드 활용
//		logger.info("응답 코드 : " + responseEntity.getStatusCode());
//		logger.info("응답 헤더 : " + responseEntity.getHeaders());
//		logger.info("응답 본문 : " + responseEntity.getBody());
//		
//		// 응답 정보 리턴
//		return responseEntity.getBody();
//	}
//
//	// 2.5. 계좌이체 서비스 - 2.5.2. 입금이체 API
//	// https://testapi.openbanking.or.kr/v2.0/transfer/deposit/fin_num
//	public Map requestDeposit(Map<String, Object> map) {
//		BankTokenVO token = (BankTokenVO)map.get("token");
//		
//		// 1. 사용자 정보 조회 API 의 경우 헤더 정보에 엑세스토큰 값을 담아 전송해야하므로
//		//    헤더 정보를 관리할 HttpHeaders 객체 생성 후 정보 추가 및 컨텐츠 타입 JSON 으로 설정
//		HttpHeaders headers = new HttpHeaders();
//		headers.setBearerAuth(token.getAccess_token());
//		headers.setContentType(MediaType.APPLICATION_JSON);
//		
//		// 2. 요청에 필요한 URI 정보 생성
//		String url = base_url + "/v2.0/transfer/deposit/fin_num";
//		
//		// 3. 요청 파라미터를 JSON 형식의 데이터로 생성
//		Gson gson = new Gson();
//		// 3-1) 1건의 입금 이체 정보를 저장할 객체 생성
//		JsonObject joReq = new JsonObject();
//		joReq.addProperty("tran_no", 1); // 거래순번(단건이체이므로 무조건 1 고정)
//		joReq.addProperty("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호
//		
//		// ---------- 요청 고객(입금 계좌) 정보 ----------
//		joReq.addProperty("fintech_use_num", (String)map.get("deposit_fintech_use_num")); // 입금계좌핀테크이용번호
//		joReq.addProperty("print_content", "아이티윌_입금"); // 입금계좌인자내역
//		joReq.addProperty("tran_amt", (String)map.get("tran_amt")); // 거래금액
//		
//		joReq.addProperty("req_client_name", (String)map.get("deposit_user_name")); // 요청고객성명(출금계좌)
//		joReq.addProperty("req_client_fintech_use_num", (String)map.get("deposit_fintech_use_num")); // 요청고객핀테크이용번호(출금계좌)
//		// => 요청고객 계좌번호 미사용 시 핀테크 이용번호 설정 필수!
//		joReq.addProperty("req_client_num", ((String)map.get("id")).toUpperCase()); // 요청고객회원번호(아이디처럼 사용) => 영문자 모두 대문자 변환 
//		joReq.addProperty("transfer_purpose", "TR"); // 이체 용도(송금 : TR) 
//		
//		// 3-2) 입금 이체 1건의 정보를 배열(리스트)로 관리할 JsonArray 객체 생성
//		JsonArray jaReqList = new JsonArray();
//		jaReqList.add(joReq); // JsonArray 객체에 1건의 이체 정보가 담긴 JsonObject 객체 추가
//		
//		// 3-3) 기본 입금 이체 정보를 저장할 JsonObject 객체 생성
//		JsonObject jo = new JsonObject(); 
//		// ---------- 핀테크 이용기관 정보 ----------
//		jo.addProperty("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌)
//		jo.addProperty("cntr_account_num", cntr_account_num); // appdata.properties 파일 내의 값 활용		jsonObject.addProperty("dps_print_content", map.get("id") + "_출금"); // 입금계좌인자내역(입금되는 계좌에 출력할 메세지)
//		
//		jo.addProperty("wd_pass_phrase", "NONE"); // 입금이체용 암호문구(테스트 시 "NONE" 값 전달) 
//		jo.addProperty("wd_print_content", (String)map.get("deposit_user_name") + "_송금"); // 출금계좌인자내역 
//		jo.addProperty("name_check_option", "on"); // 수취인성명 검증여부(on : 검증, 생략 시 off) 
//		jo.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
//		jo.addProperty("req_cnt", 1); // 입금요청건수(현재 여러건 이체 지원중단됐으므로 단건이체 "1" 고정)
//		
//		// 3-4) 기본 입금 이체 정보 JsonObject 객체에 JsonArray 객체 추가
//		jo.add("req_list", jaReqList); // 요청일시
//		
//		// 최종 요청 파라미터 확인
//		// => Gson 객체의 toJson() 메서드 호출하여 파라미터로 JsonObject 객체 전달
//		logger.info(">>>>>>>> 입금이체 요청 JSON 데이터 : " + gson.toJson(jo));
//		
//		
//		// 4. 요청에 사용될 데이터를 관리하는 HttpEntity 객체 생성
//		// => 파라미터 데이터(body)로 JsonObject 객체를 문자열로 변환하여 전달, 헤더도 전달
//		HttpEntity<String> httpEntity = new HttpEntity<String>(gson.toJson(jo), headers);
//		logger.info(">>>>>>>> httpEntity.getHeaders() : " + httpEntity.getHeaders());
//		logger.info(">>>>>>>> httpEntity.getBody() : " + httpEntity.getBody());
//		
//		
//		// 5. RESTful API 요청을 위한 RestTemplate 객체의 exchange() 메서드 호출하여
//		//    POST 방식 HTTP 요청 수행
//		RestTemplate restTemplate = new RestTemplate();
//		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, Map.class);
//		logger.info(">>>>>>>> 입금 이체 요청 결과 : " + responseEntity.getBody());
//		
//		return responseEntity.getBody();
//		
//		/*
//		 * [ 테스트 데이터 등록 방법 - 입금이체 ]
//		 * 사용자 일련번호, 핀테크이용번호 : 입금(송금) 대상 고객 정보
//		 * => 입금기관 대표코드, 입금계좌번호(출력용 포함) 자동으로 입력됨
//		 * 송금인 실명 : 핀테크 이용기관의 계좌 예금주명 입력(입금 요청 고객 정보 아님!) => 이연태 고정
//		 * 거래금액 : tran_amt 값 입력
//		 * 입금계좌인자내역 : print_content 값 입력
//		 * 수취인 성명 : req_client_name 값 입력(입금(송금) 대상 고객 계좌 예금주명(최종 수취인))
//		 */
//	}
//	
//	// =====================================================================
//	// P2P(개인간) 송금용
//	// 2.5. 계좌이체 서비스 - 2.5.1. 출금이체 API
//	// https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num
//	public Map requestWithdraw2(Map<String, Object> map) {
//		// 두 사용자의 계좌정보 객체(BankUserInfoVO) 꺼내기
//		BankUserInfoVO senderInfo = (BankUserInfoVO)map.get("senderInfo");
//		BankUserInfoVO receiverInfo = (BankUserInfoVO)map.get("receiverInfo");
//		
//		// 1. 사용자 정보 조회 API 의 경우 헤더 정보에 엑세스토큰 값을 담아 전송해야하므로
//		//    헤더 정보를 관리할 HttpHeaders 객체 생성 후 정보 추가
//		HttpHeaders headers = new HttpHeaders();
//		// 1-1) 헤더 정보를 문자열 형태로 동일하게 설정할 경우 - add() 메서드 활용
//		// => 주의! 엑세스토큰은 항상 돈이 빠져나가는 계좌의 권한을 가진 토큰 전달
//		headers.setBearerAuth(senderInfo.getAccess_token()); // 보내는 사람의 엑세스토큰
//		headers.setContentType(MediaType.APPLICATION_JSON);
//		
//		// 2. 요청에 필요한 URI 정보 생성 => 문자열로 바로 생성
//		String url = base_url + "/v2.0/transfer/withdraw/fin_num";
//		
//		// 3. 요청 파라미터를 JSON 형식의 데이터로 생성
//		// 1) Gson 클래스 인스턴스 생성
//		Gson gson = new Gson();
//		// 2) JsonObject 클래스 인스턴스 생성
//		JsonObject jsonObject = new JsonObject(); // 기본 생성자만 제공됨
//		// 3) JsonObject 객체의 addProperty() 메서드 호출하여 JSON 데이터 추가
//		// ---------- 핀테크 이용기관 정보 ----------
//		jsonObject.addProperty("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호(참가기관)
//		jsonObject.addProperty("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌)
//		jsonObject.addProperty("cntr_account_num", cntr_account_num); // appdata.properties 파일 내의 값 활용
//		jsonObject.addProperty("dps_print_content", senderInfo.getName()); // 입금계좌인자내역(보내는사람 이름)
//		
//		// ---------- 요청 고객(출금 계좌) 정보 ----------
//		jsonObject.addProperty("fintech_use_num", senderInfo.getFintech_use_num()); // 출금계좌 핀테크이용번호 
//		jsonObject.addProperty("wd_print_content", receiverInfo.getName()); // 출금계좌인자내역(받는사람 이름)
//		jsonObject.addProperty("tran_amt", (String)map.get("tran_amt")); // 거래금액
//		jsonObject.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
//		jsonObject.addProperty("req_client_name", senderInfo.getName()); // 요청고객성명(출금계좌)
//		jsonObject.addProperty("req_client_fintech_use_num", senderInfo.getFintech_use_num()); // 요청고객핀테크이용번호(출금계좌)
//		jsonObject.addProperty("req_client_num", senderInfo.getId().toUpperCase()); // 요청고객회원번호(아이디처럼 사용) => 영문자 모두 대문자 변환 
//		jsonObject.addProperty("transfer_purpose", "TR"); // 이체 용도(송금 : TR, 결제 : ST 등) 
//		
//		// ---------- 수취 고객(실제 최종 입금 대상) 정보 ----------
//		// 최종적으로 금액을 수신하는 계좌에 대한 정보
//		// 이 정보(3가지)는 피싱 등의 사고 발생 시 지급 정지 등을 위한 정보로 실제 검증 수행 X
//		jsonObject.addProperty("recv_client_name", receiverInfo.getName()); // 최종수취고객성명(입금대상)
//		jsonObject.addProperty("recv_client_bank_code", receiverInfo.getBank_code()); // // 최종수취고객계좌 개설기관 표준코드(입금대상)
//		jsonObject.addProperty("recv_client_account_num", receiverInfo.getAccount_num()); // 최종수취고객계좌번호(입금대상)
//
//		// 최종 요청 파라미터 확인
//		// => Gson 객체의 toJson() 메서드 호출하여 파라미터로 JsonObject 객체 전달
//		logger.info(">>>>>>>> 출금이체 요청 JSON 데이터 : " + gson.toJson(jsonObject));
//		
//		
//		// 4. 요청에 사용될 데이터를 관리하는 HttpEntity 객체 생성
//		// => 파라미터 데이터(body)로 JsonObject 객체를 문자열로 변환하여 전달, 헤더도 전달
//		HttpEntity<String> httpEntity = new HttpEntity<String>(gson.toJson(jsonObject), headers);
//		logger.info(">>>>>>>> httpEntity.getHeaders() : " + httpEntity.getHeaders());
//		logger.info(">>>>>>>> httpEntity.getBody() : " + httpEntity.getBody());
//		
//		
//		// 5. RESTful API 요청을 위한 RestTemplate 객체의 exchange() 메서드 호출하여
//		//    POST 방식 HTTP 요청 수행
//		RestTemplate restTemplate = new RestTemplate();
//		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, Map.class);
//		logger.info(">>>>>>>> 출금 이체 요청 결과 : " + responseEntity.getBody());
//		
//		return responseEntity.getBody();
//		
//		/*
//		 * [ 테스트 데이터 등록 방법 - 출금이체 ]
//		 * 사용자 일련번호, 핀테크이용번호 : 출금 계좌 고객 정보
//		 * => 출금기관 대표코드, 출금계좌번호(출력용 포함) 자동으로 입력됨
//		 * 송금인 실명 : 출금 계좌 고객 성명
//		 * 거래금액 : tran_amt 값 입력
//		 * 입금계좌인자내역 : dps_print_content 값 입력(출금 계좌 고객 성명)
//		 * 수취인 성명 : 핀테크 이용기관 계좌 예금주명 입력(최종 수취인 아님!)
//		 */
//	}
//
//	// 2.5. 계좌이체 서비스 - 2.5.2. 입금이체 API
//	// https://testapi.openbanking.or.kr/v2.0/transfer/deposit/fin_num
//	public Map requestDeposit2(Map<String, Object> map) {
//		// 두 사용자의 계좌정보 객체(BankUserInfoVO) 꺼내기
//		BankUserInfoVO senderInfo = (BankUserInfoVO)map.get("senderInfo");
//		BankUserInfoVO receiverInfo = (BankUserInfoVO)map.get("receiverInfo");
//		
//		// 1. 사용자 정보 조회 API 의 경우 헤더 정보에 엑세스토큰 값을 담아 전송해야하므로
//		//    헤더 정보를 관리할 HttpHeaders 객체 생성 후 정보 추가 및 컨텐츠 타입 JSON 으로 설정
//		HttpHeaders headers = new HttpHeaders();
//		headers.setBearerAuth((String)map.get("adminToken")); // 관리자 토큰 전달 필수!
//		headers.setContentType(MediaType.APPLICATION_JSON);
//		
//		// 2. 요청에 필요한 URI 정보 생성
//		String url = base_url + "/v2.0/transfer/deposit/fin_num";
//		
//		// 3. 요청 파라미터를 JSON 형식의 데이터로 생성
//		Gson gson = new Gson();
//		// 3-1) 1건의 입금 이체 정보를 저장할 객체 생성
//		JsonObject joReq = new JsonObject();
//		joReq.addProperty("tran_no", 1); // 거래순번(단건이체이므로 무조건 1 고정)
//		joReq.addProperty("bank_tran_id", bankValueGenerator.getBankTranId()); // 거래고유번호
//		
//		// ---------- 요청 고객(받는 사람) 정보 ----------
//		joReq.addProperty("fintech_use_num", receiverInfo.getFintech_use_num()); // 받는사람 핀테크이용번호
//		joReq.addProperty("print_content", senderInfo.getName()); // 입금계좌인자내역(보내는사람 이름)
//		joReq.addProperty("tran_amt", (String)map.get("tran_amt")); // 거래금액
//		
//		joReq.addProperty("req_client_name", senderInfo.getName()); // 요청고객성명(출금계좌)
//		joReq.addProperty("req_client_fintech_use_num", senderInfo.getFintech_use_num()); // 요청고객핀테크이용번호(출금계좌)
//		// => 요청고객 계좌번호 미사용 시 핀테크 이용번호 설정 필수!
//		joReq.addProperty("req_client_num", senderInfo.getId().toUpperCase()); // 요청고객회원번호(아이디처럼 사용) => 영문자 모두 대문자 변환 
//		joReq.addProperty("transfer_purpose", "TR"); // 이체 용도(송금 : TR) 
//		
//		// 3-2) 입금 이체 1건의 정보를 배열(리스트)로 관리할 JsonArray 객체 생성
//		JsonArray jaReqList = new JsonArray();
//		jaReqList.add(joReq); // JsonArray 객체에 1건의 이체 정보가 담긴 JsonObject 객체 추가
//		
//		// 3-3) 기본 입금 이체 정보를 저장할 JsonObject 객체 생성
//		JsonObject jo = new JsonObject(); 
//		// ---------- 핀테크 이용기관 정보 ----------
//		jo.addProperty("cntr_account_type", "N"); // 약정 계좌/계정 구분("N" : 계좌)
//		jo.addProperty("cntr_account_num", cntr_account_num); // appdata.properties 파일 내의 값 활용		jsonObject.addProperty("dps_print_content", map.get("id") + "_출금"); // 입금계좌인자내역(입금되는 계좌에 출력할 메세지)
//		
//		jo.addProperty("wd_pass_phrase", "NONE"); // 입금이체용 암호문구(테스트 시 "NONE" 값 전달) 
//		jo.addProperty("wd_print_content", receiverInfo.getName()); // 출금계좌인자내역 
//		jo.addProperty("name_check_option", "on"); // 수취인성명 검증여부(on : 검증, 생략 시 off) 
//		jo.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
//		jo.addProperty("req_cnt", 1); // 입금요청건수(현재 여러건 이체 지원중단됐으므로 단건이체 "1" 고정)
//		
//		// 3-4) 기본 입금 이체 정보 JsonObject 객체에 JsonArray 객체 추가
//		jo.add("req_list", jaReqList); // 요청일시
//		
//		// 최종 요청 파라미터 확인
//		// => Gson 객체의 toJson() 메서드 호출하여 파라미터로 JsonObject 객체 전달
//		logger.info(">>>>>>>> 입금이체 요청 JSON 데이터 : " + gson.toJson(jo));
//		
//		
//		// 4. 요청에 사용될 데이터를 관리하는 HttpEntity 객체 생성
//		// => 파라미터 데이터(body)로 JsonObject 객체를 문자열로 변환하여 전달, 헤더도 전달
//		HttpEntity<String> httpEntity = new HttpEntity<String>(gson.toJson(jo), headers);
//		logger.info(">>>>>>>> httpEntity.getHeaders() : " + httpEntity.getHeaders());
//		logger.info(">>>>>>>> httpEntity.getBody() : " + httpEntity.getBody());
//		
//		
//		// 5. RESTful API 요청을 위한 RestTemplate 객체의 exchange() 메서드 호출하여
//		//    POST 방식 HTTP 요청 수행
//		RestTemplate restTemplate = new RestTemplate();
//		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, Map.class);
//		logger.info(">>>>>>>> 입금 이체 요청 결과 : " + responseEntity.getBody());
//		
//		return responseEntity.getBody();
//		
//		/*
//		 * [ 테스트 데이터 등록 방법 - 입금이체 ]
//		 * 사용자 일련번호, 핀테크이용번호 : 입금(송금) 대상 고객 정보
//		 * => 입금기관 대표코드, 입금계좌번호(출력용 포함) 자동으로 입력됨
//		 * 송금인 실명 : 핀테크 이용기관의 계좌 예금주명 입력(입금 요청 고객 정보 아님!) => 이연태 고정
//		 * 거래금액 : tran_amt 값 입력
//		 * 입금계좌인자내역 : print_content 값 입력
//		 * 수취인 성명 : req_client_name 값 입력(입금(송금) 대상 고객 계좌 예금주명(최종 수취인))
//		 */
//	}
//
//	// 2.5.3. 이체결과조회 API
//	// https://openapi.openbanking.or.kr/v2.0/transfer/result
//	public Map requestTransferResult(Map<String, String> map) {
//		// 1. 헤더 정보에 엑세스토큰 값을 담아 전송해야하므로
//		//    헤더 정보를 관리할 HttpHeaders 객체 생성 후 정보 추가 및 컨텐츠 타입 JSON 으로 설정
//		HttpHeaders headers = new HttpHeaders();
//		headers.setBearerAuth((String)map.get("adminToken")); // 관리자 토큰 전달 필수!
//		headers.setContentType(MediaType.APPLICATION_JSON);
//		
//		// 2. 요청에 필요한 URI 정보 생성
//		String url = base_url + "/v2.0/transfer/result";
//		
//		// 3. 요청 파라미터를 JSON 형식의 데이터로 생성
//		Gson gson = new Gson();
//		// 3-1) 1건의 입금 이체 정보를 저장할 객체 생성
//		JsonObject joReq = new JsonObject();
//		joReq.addProperty("tran_no", 1); // 거래순번(단건 조회를 위해 1 고정)
//		joReq.addProperty("org_bank_tran_id", map.get("bank_tran_id")); // 원거래 거래고유번호(참가기관)
////		joReq.addProperty("org_bank_tran_date", map.get("bank_tran_date")); // 원거래 거래일자(참가기관)
//		// 주의! 원거래 거래일자의 경우 테스트 시 실제 날짜가 아닌 2019년도로 설정되어 응답되므로
//		// 임시로 실제 거래일 설정 필요
//		joReq.addProperty("org_bank_tran_date", "20240621"); // 원거래 거래일자(참가기관)
//		
//		joReq.addProperty("org_tran_amt", map.get("tran_amt")); // 거래고유번호
//		
//		// 3-2) 이체 조회 1건의 요청 정보를 배열(리스트)로 관리할 JsonArray 객체 생성
//		JsonArray jaReqList = new JsonArray();
//		jaReqList.add(joReq); // JsonArray 객체에 1건의 이체 정보가 담긴 JsonObject 객체 추가
//		
//		// 3-3) 기본 이체 조회 정보를 저장할 JsonObject 객체 생성
//		JsonObject jo = new JsonObject(); 
//		jo.addProperty("check_type", "2"); // 출금이체 : 1, 입금이체 : 2
//		jo.addProperty("tran_dtime", bankValueGenerator.getTranDTime()); // 요청일시
//		jo.addProperty("req_cnt", 1); // 요청건수(1건 조회를 위해 1 전달)
//		
//		// 3-4) 전체 이체 조회 정보 JsonObject 객체에 JsonArray 객체 추가
//		jo.add("req_list", jaReqList); // 요청일시
//		
//		// 최종 요청 파라미터 확인
//		// => Gson 객체의 toJson() 메서드 호출하여 파라미터로 JsonObject 객체 전달
//		logger.info(">>>>>>>> 이체 결과 조회 요청 JSON 데이터 : " + gson.toJson(jo));
//		
//		
//		// 4. 요청에 사용될 데이터를 관리하는 HttpEntity 객체 생성
//		// => 파라미터 데이터(body)로 JsonObject 객체를 문자열로 변환하여 전달, 헤더도 전달
//		HttpEntity<String> httpEntity = new HttpEntity<String>(gson.toJson(jo), headers);
//		logger.info(">>>>>>>> httpEntity.getHeaders() : " + httpEntity.getHeaders());
//		logger.info(">>>>>>>> httpEntity.getBody() : " + httpEntity.getBody());
//		
//		
//		// 5. RESTful API 요청을 위한 RestTemplate 객체의 exchange() 메서드 호출하여
//		//    POST 방식 HTTP 요청 수행
//		RestTemplate restTemplate = new RestTemplate();
//		ResponseEntity<Map> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, Map.class);
//		logger.info(">>>>>>>> 이체 결과 조회 요청 결과 : " + responseEntity.getBody());
//		
//		return responseEntity.getBody();
//		
//		/*
//		 * [ 테스트 데이터 등록 방법 - 입금이체 ]
//		 * 사용자 일련번호, 핀테크이용번호 : 입금(송금) 대상 고객 정보
//		 * => 입금기관 대표코드, 입금계좌번호(출력용 포함) 자동으로 입력됨
//		 * 송금인 실명 : 핀테크 이용기관의 계좌 예금주명 입력(입금 요청 고객 정보 아님!) => 이연태 고정
//		 * 거래금액 : tran_amt 값 입력
//		 * 입금계좌인자내역 : print_content 값 입력
//		 * 수취인 성명 : req_client_name 값 입력(입금(송금) 대상 고객 계좌 예금주명(최종 수취인))
//		 */
//	}
	
}














