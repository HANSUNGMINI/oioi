package com.itwillbs.oi.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper {
	
	int registUser(Map<String, Object> resultMap); //회원가입 mapper
//	int insertMember(MemberVO member); 
	
	boolean selectCheckID(String member_id);// 회원가입 아이디 중복체크
	
	void registMailAuthInfo(Map<String, Object> mailAuthInfo); 
	
	void updateMailAuthInfo(Map<String, Object> mailAuthInfo);
	
	Map<String, String> selectMailAuthInfo(Map<String, Object> mailAuthInfo);
	
//	MemberVO selectMember(MemberVO member); 
//
//	MemberVO selectForgotId(MemberVO member); // 이름과 이메일로 아이디 찾기
//
//	MemberVO selectForgotPw(MemberVO member); // 아이디, 이름, 이메일로 비밀번호 찾기
	
	int selectMemberCount();

	int selectTodayMember();




//	int updatePasswd(MemberVO member);

	String selectForgotIdPhone(Map<String, String> map);

	boolean selectEmptyEmail(String userEmail);

	boolean selectEmptyPhoneNum(String userPhone);

//	MemberVO selectForgotPwPhone(Map<String, String> map);


	

	

	


}
