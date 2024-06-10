package com.itwillbs.oi.handler;

import java.util.Random;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 길이의 난수 생성에 사용할 클래스 정의
public class GenerateRandomCode {
	// 난수 생성하여 문자열로 리턴할 getRandomCode() 메서드 정의
    // => 파라미터 : 난수 길이(정수)   리턴타입 : String
    // => 인스턴스 생성 없이 즉시 호출 가능하도록 static 메서드로 선언
    public static String getRandomCode(int length) {
        // 랜덤 숫자 문자열 생성
        return RandomStringUtils.randomNumeric(length);
    }

//    public static void main(String[] args) {
//        // 테스트를 위해 메서드 호출
//        System.out.println(getRandomCode(6)); // 6자리 랜덤 숫자 문자열 출력
//    }
	
	public static String getAuthCode() {
		
		return RandomStringUtils.randomNumeric(4);
	}
}












