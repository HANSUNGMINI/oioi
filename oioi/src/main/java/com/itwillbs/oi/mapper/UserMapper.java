package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
	String selectStatus(String id);
	boolean checkNullColomn(String id);
	void updateStatus(String id);
	int registUser(Map<String, Object> resultMap); //회원가입 mapper
//	int insertMember(MemberVO member); 
	
	boolean selectCheckID(String user_id);
//	boolean selectCheckID(String member_id);// 회원가입 아이디 중복체크
	
	boolean selectCheckNick(String user_nick); // 회원가입 닉네임 중복체크
	
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

	Map<String, String> selectUser(String userId);

	Map<String, Object> selectfindId(Map<String, Object> userMap);

	String selectIdByPhone(Map<String, Object> user);

	Map<String, String> selectMyUser(String id);
	
	 // 필드를 업데이트하는 메소드
    boolean updateField(@Param("userId") String userId, @Param("field") String field, @Param("value") String value);

    // 닉네임 중복 검사
    boolean isNicknameTaken(@Param("nickname") String nickname);
	
	
	Map<String, Object> selectFindPw(Map<String, Object> userMap);

	int selectUserData(Map<String, Object> user);

	int updatePasswd(Map<String, Object> user);

	Map<String, Object> findUserByUsId(String US_ID);

    void registKakaoUser(Map<String, Object> userInfo);

    void updateKakaoUser(Map<String, Object> userInfo);
   
    // 네이버 로그인 
 	int selectUserId(String userId);

 	int updateNaverUser(Map<String, Object> naverUserInfo);
 	
 	int registNaverUser(Map<String, Object> naverUserInfo);

 	int updateUserProfile(@Param("userId") String userId, @Param("fileUrl") String fileUrl);

	int updateText(@Param("userId") String userId,@Param("editText") String editText);
	
	List<Map<String, Object>> selectAuctionList(String id);
	
	List<Map<String, Object>> selectTradeList(String id);
	
    String getPassword(@Param("userId") String userId);
	
    int updatePassword(@Param("userId") String userId, @Param("newPassword") String newPassword);
	
	

//	MemberVO selectForgotPwPhone(Map<String, String> map);


	

	

	


}
