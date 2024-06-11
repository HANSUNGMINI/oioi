package com.itwillbs.oi.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.itwillbs.oi.handler.GenerateRandomCode;
import com.itwillbs.oi.handler.SendMailClient;

@Service
public class MailService {

	public Map<String, Object> sendAuthMail(Map<String, Object> userMap) {
		String userEmail = (String) userMap.get("user_email");
		String auth_code = GenerateRandomCode.getRandomCode(6);
		String subject = "[오이마켓] 가입 인증 메일입니다.";
		String content = "오이마켓 가입 인증을 위해 해당 인증번호를 홈페이지에 입력해주세요" + auth_code;
		
		SendMailClient mailClient = new SendMailClient();
		new Thread(new Runnable() {
			@Override
			public void run() {
				mailClient.sendMail(userEmail, subject, content);
			}
		}).start();
		
		Map<String, Object> authInfo = new HashMap<>();
		authInfo.put("US_EMAIL", userEmail);
		authInfo.put("auth_code", auth_code);
		
		return authInfo;
	}

	public void sendForgotId(Map<String, Object> userMap) {
		String userEmail = (String) userMap.get("user_email");
		String userId = (String) userMap.get("user_id");
		String subject = "[오이마켓] 아이디를 확인해주세요.";
		String content = "회원님의 가입된 아이디는 <b>" + userId + "</b>입니다.";
		
		SendMailClient mailClient = new SendMailClient();
		new Thread(new Runnable() {
			@Override
			public void run() {
				mailClient.sendMail(userEmail, subject, content);
			}
		}).start();
	}

	public void sendForgotPw(Map<String, Object> userMap) {
		String userEmail = (String) userMap.get("user_email");
		String subject = "[오이마켓] 비밀번호 변경 이메일입니다.";
		String content = "<a href='http://localhost:8081/oi/forgot_pw_step3?user_id=" 
		                + userMap.get("user_id") 
		                + "&user_email=" + userEmail
		                + "&user_name=" + userMap.get("user_name")
		                + "'>클릭 시 새 비밀번호 설정 페이지로 이동합니다.</a>";
		
		SendMailClient mailClient = new SendMailClient();
		new Thread(new Runnable() {
			@Override
			public void run() {
				mailClient.sendMail(userEmail, subject, content);
			}
		}).start();
	}
	
	
	
	//	 인증 메일 발송 요청
//	public MailAuthInfoVO sendAuthMail(userVO user) {
//		// 인증 메일에 포함시킬 난수 생성
//				// => GenerateRandomCode 클래스의 getRandomCㄴode() 메서드 호출
//				//    (파라미터 : 난수 길이 전달)
//				String auth_code = GenerateRandomCode.getRandomCode(6);
////				System.out.println("생성된 난수 : " + auth_code);
//				// -------------------------------------------------------
//				// 인증메일에 포함할 제목과 본문 생성
//				String subject = "[오이마켓] 가입 인증 메일입니다.";
//				String content = "오이마켓 가입 인증을 위해 해당 인증번호를 홈페이지에 입력해주세요" + auth_code;
////				String content = "<a href='http://c3d2401t1.itwillbs.com/userEmailAuth?user_email=" + user.getuser_email() + "&auth_code=" + auth_code + "'>오이마켓 이메일 인증을 위해 링크를 클릭해 주세요.</a>";
//				// -------------------------------------------------------
//				// SendMailClient - sendMail() 메서드 호출하여 메일 발송 요청
//				// => 파라미터 : 이메일주소, 제목, 본문
//				SendMailClient mailClient = new SendMailClient();
//				// 단, 메일 발송 과정에서 메일 전송 상황에 따라 시간이 지연될 수 있는데
//				// 이 과정에서 다음 코드를 실행하지 못하고 발송이 끝날때까지 기다리게된다.
//				// 따라서, 메일 발송 작업과 나머지 작업을 별도로 동작시키기 위해
//				// 메일 발송 메서드 호출 작업을 자바의 쓰레드(Thread)를 활용하여 수행할 수 있다!
//				// 즉, 메일 발송이 완료되지 않더라도 다음 작업을 진행할 수 있게 됨
//				// -----------------------
//				// 익명 객체를 활용하여 1회용 쓰레드 생성
//				// new Thread(new Runnable() { public void run() { 멀티쓰레드코드.... }}).start();
////				mailClient.sendMail(user.getEmail(), subject, content);
//				new Thread(new Runnable() {
//					@Override
//					public void run() {
//						mailClient.sendMail(user.getuser_email(), subject, content);
//					}
//				}).start();
//
//
//				// -------------------------------------------------------
//				// MailAuthInfoVO 객체 생성 후 아이디, 인증코드 저장 및 리턴
//				MailAuthInfoVO authInfo = new MailAuthInfoVO(user.getuser_email(), auth_code);
//				
//				return authInfo;
//			}
//			
//			public void sendForgotId(userVO user) {
//
//				String subject = "[오이마켓] 아이디를 확인해주세요.";
//				String content = "회원님의 가입된 아이디는 <b>" + user.getuser_id() + "</b>입니다.";
//				
//				SendMailClient mailClient = new SendMailClient();
//				
//				new Thread(new Runnable() {
//					@Override
//					public void run() {
//						mailClient.sendMail(user.getuser_email(), subject, content);
//					}
//				}).start();
//
//			}
//			
//			public void sendForgotPw(userVO user) {
//				String subject = "[오이마켓] 비밀번호 변경 이메일입니다.";
//				String content = "<a href='http://localhost:8081/oi/forgot_pw_step3?user_id=" + user.getuser_id() 
//																				 + "&user_email=" + user.getuser_email()
//																				 + "&user_name=" + user.getuser_name()
//																				 + "'>클릭 시 새 비밀번호 설정 페이지로 이동합니다.</a>";
//				
//				SendMailClient mailClient = new SendMailClient();
//				
//				new Thread(new Runnable() {
//					@Override
//					public void run() {
//						mailClient.sendMail(user.getuser_email(), subject, content);
//					}
//				}).start();
//			}
//	
	}
	


























