package com.itwillbs.oi.handler;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

// 자바 메일 기능 사용 시 메일 서버(ex. 네이버, Gmail 등) 인증을 위한 정보를 관리하는 클래스 정의
// => javax.mail.Authenticator(jakarta.mail.Authenticator) 클래스 상속받아 정의
public class MailAuthenticator extends Authenticator {
	// 인증정보(아이디, 패스워드)를 관리할 javax.mail.PasswordAuthenticator 클래스 타입 변수 선언
	PasswordAuthentication passwordAuthentication;

	// 기본 생성자 정의
	public MailAuthenticator() {
		/*
		 * 인증에 사용될 아이디와 패스워드를 갖는 PasswordAuthentication 객체 생성
		 * - 파라미터 : 메일 서버의 계정명, 패스워드
		 *   => 네이버, Gmail 기준 2단계 인증 미사용 시 : 계정명, 계정 패스워드
		 *   => 네이버, Gmail 기준 2단계 인증 사용 시 : 계정명, 앱 비밀번호
		 *      (각 상용 메일 계정에 대한 2단계 인증 활성화 필요)
		 *      (앱 비밀번호는 로그인 등의 다른 서비스에는 사용 불가, 특정 서비스(메일)에서만 사용)
		 */  
		passwordAuthentication = new PasswordAuthentication("amugae111@naver.com", "12ZRT2NJ38JZ");
	}

	// 인증 정보 관리 객체(PasswordAuthentication)를 외부로 리턴하는 getPasswordAuthentication() 메서드 정의
	// => 주의! Getter 메서드 직접 정의 시 멤버변수명에 따라 메서드명이 달라지는데
	//    외부에서 해당 메서드를 직접 호출하는 것이 아니라 객체 내에서 자동으로 호출되므로
	//    미리 약속된 메서드명으로 메서드 정의 필수!
	// => Authenticator 클래스의 getPasswordAuthentication() 메서드 오버라이딩하여 정의할 것
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// TODO Auto-generated method stub
		return passwordAuthentication;
	}
	
	
}
