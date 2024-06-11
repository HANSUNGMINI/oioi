package com.itwillbs.oi.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.UserMapper;

@Service
public class UserService {
	@Autowired
	private UserMapper mapper;
	
	
	public int registUser(Map<String, Object> resultMap) {
		return mapper.registUser(resultMap);
	}
	
	public boolean isEmptyId(String user_id) {
		System.out.println(user_id);
		return mapper.selectCheckID(user_id);
	}
	
	public boolean isEmptyEmail(String member_email) {
		return mapper.selectEmptyEmail(member_email);
	}
	
	public void registMailAuthInfo(Map<String, Object> mailAuthInfo) {
		Map<String, String> dbAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
		
		if (dbAuthInfo == null) {
			mapper.registMailAuthInfo(mailAuthInfo);
		} else { // 기존 인증정보 있음(인증메일 발송 이력 있음)
			mapper.updateMailAuthInfo(mailAuthInfo);
		}
		
	}
	
	public boolean requestEmailAuth(Map<String, Object> authInfo) {
		boolean isAuthSuccess = false;
		Map<String, String> dbAuthInfo = mapper.selectMailAuthInfo(authInfo);
		
		if (dbAuthInfo != null && authInfo.get("auth_code").equals(dbAuthInfo.get("auth_code"))) {
			isAuthSuccess = true;
		}
		
		return isAuthSuccess;
	}
	
//	public boolean requestEmailAuth(Map<String, Object> authInfo) {
//		boolean isAuthSuccess = false; // 인증 성공 여부를 저장할 변수
//		
//		// MemberMapper - selectMailAuthInfo() 메서드 호출하여 기존 이메일 인증 정보 조회
//		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : Map<String, String>(dbAuthInfo)
//		Map<String, String> dbAuthInfo = mapper.selectMailAuthInfo(authInfo);
//		
//		System.out.println("전달받은 인증정보 : " + authInfo);
//		System.out.println("조회된 인증정보 : " + dbAuthInfo);
//		
//		// 조회된 인증 정보 존재 여부 판별
//		if(dbAuthInfo != null) { // 아이디에 해당하는 인증 정보 존재
//			// 하이퍼링크를 통해 전달받은 인증코드와 조회된 인증코드 문자열 비교
//			if(authInfo.getAuth_code().equals(dbAuthInfo.get("auth_code"))) { // 인증코드가 일치
//				
//				// 1. MemberMapper - updateMailAuthStatus() 메서드 호출하여
//				//    member 테이블의 이메일 인증 상태(mail_auth_status) 값을 "Y" 로 변경(UPDATE)
//				// => 파라미터 : MailAuthInfoVO 객체(아이디 필요)
//				
//				
//				// 2. MemberMapper - deleteMailAuthStatus() 메서드 호출하여
//				//    mail_auth_info 테이블의 레코드 삭제
//				// => 파라미터 : MailAuthInfoVO 객체(아이디 필요)
//				
//				
//				// 인증 수행 결과를 true 로 변경
//				isAuthSuccess = true;
//			}
//		}
//		
//		return isAuthSuccess;
//	}
	
//	public int registMember(MemberVO bean) { //회원가입
//		return mapper.insertMember(bean);
//	}

	//	public boolean isEmptyId(String member_id) { // 중복 아이디
//		System.out.println(member_id);
//		return mapper.selectCheckID(member_id);
//	}

	
//	public boolean isCorrectUser(MemberVO member) { //로그인
//		return mapper.selectCorrectUser(member);
//	}


	

//	public MemberVO getMember(MemberVO member) { // 회원 검색
//		
//		return mapper.selectMember(member);
//	}
//
//
//	public MemberVO forgotId(MemberVO member) { // 아이디 찾기
//		
//		return mapper.selectForgotId(member);
//	}
//	
//	public MemberVO forgotPw(MemberVO member) { // 비밀번호 찾기
//		
//		return mapper.selectForgotPw(member);
//	}


	public int selectMemberCount() {
		return mapper.selectMemberCount();
	}


	public int todayMemberCount() {
		return mapper.selectTodayMember();
	}

	
//	public void registMailAuthInfo(MailAuthInfoVO mailAuthInfo) {
//		// 기존 인증정보 존재 여부 확인을 위해 인증정보 조회 요청
//		// MemberMapper - selectMailAuthInfo() 메서드 호출
//		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : Map<String, String>(dbAuthInfo)
//		Map<String, String> dbAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
////		System.out.println(dbAuthInfo);
//		
//		// 인증정보 조회 결과 판별
//		if(dbAuthInfo == null) { // 기존 인증정보 없음(인증메일 발송 이력 없음)
//			// 새 인증정보 등록을 위해 insertMailAuthInfo() 메서드 호출하여 등록 작업 요청(INSERT)
//			mapper.insertMailAuthInfo(mailAuthInfo);
//		} else { // 기존 인증정보 있음(인증메일 발송 이력 있음)
//			// 기존 인증정보 갱신을 위해 updateMailAuthInfo() 메서드 호출하여 수정 작업 요청(UPDATE)
//			mapper.updateMailAuthInfo(mailAuthInfo);
//		}
//		
//	}


	


	


	public boolean isEmptyPhoneNum(String member_phone) {
		
		return mapper.selectEmptyPhoneNum(member_phone);
	}


//	public int modifyPasswd(MemberVO member) {
//	
//		return mapper.updatePasswd(member);
//	}


//	public String forgotIdPhone(Map<String, String> map) {
//		return mapper.selectForgotIdPhone(map);
//	}


//	public MemberVO forgotPwPhone(Map<String, String> map) {
//		return mapper.selectForgotPwPhone(map);
//	}



	


	


}
