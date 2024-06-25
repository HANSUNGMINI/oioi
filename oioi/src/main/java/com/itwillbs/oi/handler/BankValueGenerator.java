package com.itwillbs.oi.handler;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Component;

// 핀테크 요청 작업에 사용할 다양한 값을 생성하는 클래스
// => 스프링 빈으로 등록해서 자동 주입받기 위해 @Component 어노테이션 적용
@Component
public class BankValueGenerator {
	// 이용기관 코드를 변수에 미리 저장
	private String client_use_code = "M202113854";
	
	// 거래고유번호 자동 생성을 위한 getBankTranId() 메서드 정의
	// (3.11. 거래고유번호(참가기관) 생성 안내)
	// => 파라미터 : 없음   리턴타입 : String
	// => 고유번호 생성 형식 : 이용기관코드(10자리) + 생성주체구분코드("U") + 이용기관 부여번호(9자리)
	public String getBankTranId() {
		String bank_tran_id = "";
		
		// 이용기관 부여번호(9자리) 생성
		// 만약, 정수형 난수로만 구성될 경우 SecureRandom 클래스 활용(000000000 ~ 999999999)
//		SecureRandom sr = new SecureRandom();
//		int rNum = sr.nextInt(1000000000); // 0 ~ 999999999 사이의 정수형 난수 생성
		// 단, 생성된 정수가 9자리 미만일 경우 앞자리 0은 표현되지 않으므로 9자리 난수가 되지 못함
		// 따라서, 추출된 난수를 String - format() 메서드 활용하여 9자리 문자열 형식을 지정하되
		// 부족한 앞자리는 0으로 채우는 작업 추가 필요
//		bank_tran_id = String.format("%09d", rNum);
		// =================================================================================
		// GenerateRandomCode - getRandomCode() 메서드 재사용 => 파라미터로 난수 길이 9 전달
		// => bank_tran_id 의 타입이 AN(알파벳 + 숫자이며, 알파벳은 모두 대문자) 이므로
		//    생성된 난수 조합을 대문자 변환을 위한 toUpperCase() 메서드 호출을 통해 변환
//		System.out.println(GenerateRandomCode.getRandomCode(9).toUpperCase());
		bank_tran_id = client_use_code + "U" + GenerateRandomCode.getRandomCode(9).toUpperCase();
		
		return bank_tran_id;
	}
	
	// 작업 요청 일시 자동 생성하기 위한 getTranDTime()
	public String getTranDTime() {
		LocalDateTime localDateTime = LocalDateTime.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		
		return localDateTime.format(dateTimeFormatter);
	}

}














