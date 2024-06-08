package com.itwillbs.oi.handler;

import java.util.Random;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 길이의 난수 생성에 사용할 클래스 정의
public class GenerateRandomCode {
	// 난수 생성하여 문자열로 리턴할 getRandomCode() 메서드 정의
	// => 파라미터 : 난수 길이(정수)   리턴타입 : String
	// => 인스턴스 생성없이 즉시 호출 가능하도록 static 메서드로 선언
	public static String getRandomCode(int length) {
		// [ 난수 생성 방법 ]
		// 1. java.util.Random 클래스 활용
		// 5자리 정수(0 ~ 99999)로 된 난수 생성
//		Random r = new Random();
//		int rNum = r.nextInt(100000);
		
		// 2. java.security.SecureRandom 클래스 활용
		// => Random 클래스의 의사 난수로 인한 보안 취약점을 해결하기 위해 만들어진 클래스
		// => Random 클래스와 기본 사용법 동일함
//		SecureRandom r = new SecureRandom();
//		int rNum = r.nextInt(100000);
		
		// 5자리 정수 난수 발생 후 문자열로 변환
		// => 5자리 미만의 정수의 경우 5자리 형태로 변환하여 변환 필요(앞자리 0으로 채움)
//		String strNum = String.format("%05d", rNum);
		// ----------------------------------------------------------------------------------
		// 5자리의 난수(알파벳 대문자, 소문자, 숫자 조합) 생성
		// 1) 난수에 사용될 데이터를 char 배열로 생성(ex. 대문자 10개, 소문자 10개, 숫자 10개 = 30개)
//		char[] randomCodePiece = {
//			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
//			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
//			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
//		};
//		
//		String strNum = "";
//		
//		// ------- for문을 사용하여 50자리 난수 생성을 위해 50번 반복 -------
//		for(int i = 1; i <= 50; i++) {
//			// 2) 배열의 문자 갯수(ex. 30개 = 0 ~ 29)에 해당하는 인덱스 범위의 정수형 난수 생성
//			SecureRandom r = new SecureRandom();
//			int rNum = r.nextInt(randomCodePiece.length);
//			
//			// 3) 생성된 난수를 배열 인덱스로 활용하여 문자 1개 추출 후 문자열 결합하여 저장
//			strNum += randomCodePiece[rNum]; 
//		}
//		
//		System.out.println(strNum);
		// ===================================================================================
		// 3. org.apache.commons.lang3.RandomStringUtils 클래스 활용(commons-lang3 라이브러리 필요)
		// => static 메서드 randomXXX() 메서드를 호출하여 난수 생성
		// => 알파벳, 숫자 조합 난수 생성하기 위해 randomAlphanumeric() 메서드 활용
		return RandomStringUtils.randomAlphanumeric(length);
	}
	
	public static String getAuthCode() {
		
		return RandomStringUtils.randomNumeric(4);
	}
}












