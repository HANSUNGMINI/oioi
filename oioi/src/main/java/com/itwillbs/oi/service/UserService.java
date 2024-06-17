package com.itwillbs.oi.service;

import java.util.List;
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
	
	public boolean isEmptyNick(String user_nick) {
		System.out.println(user_nick);
		return mapper.selectCheckNick(user_nick);
	}
	
	
	public boolean isEmptyEmail(String userEmail) {
		return mapper.selectEmptyEmail(userEmail);
	}
	
	public boolean isEmptyPhoneNum(String userPhone) {
		return mapper.selectEmptyPhoneNum(userPhone);
	}
	
	
	public void registMailAuthInfo(Map<String, Object> mailAuthInfo) {
		Map<String, String> dbAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);
//		System.out.println(dbAuthInfo.toString());
		
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
	

//	public MemberVO getMember(MemberVO member) { // 회원 검색
//		
//		return mapper.selectMember(member);
//	}
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

	//로그인 
	public Map<String, String> selectUser(String userId) {
		return mapper.selectUser(userId);
	}
	
	// 아이디 찾기
	public Map<String, Object> findId(Map<String, Object> userMap) {
		System.out.println("서비스 정보 확인 : " + mapper.selectfindId(userMap));
		return mapper.selectfindId(userMap);
	}

	public String findUserIdByPhone(Map<String, Object> user) {
		return mapper.selectIdByPhone(user);
	}
	
	// 비밀번호 찾기
	public Map<String, Object> findPasswd(Map<String, Object> userMap) {
		return mapper.selectFindPw(userMap);
	}
	
	public int findUserData(Map<String, Object> user) {
		return mapper.selectUserData(user);
	}	
		
	// 마이페이지 정보 가져오기
	public Map<String, String> selectMyUser(String id) {
		
		return mapper.selectMyUser(id);
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
