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
	
	
	public Map<String, Object> loginOrRegister(Map<String, Object> userInfo) throws Exception {
        String userId = (String) userInfo.get("US_ID");
        Map<String, Object> existingUser = mapper.findUserByUsId(userId);
        if (existingUser != null) {
            // 이미 존재하는 사용자 - 업데이트
            mapper.updateKakaoUser(userInfo);
            return existingUser;
        } else {
            // 존재하지 않는 사용자 - 새 사용자 등록
            mapper.registKakaoUser(userInfo);
            return mapper.findUserByUsId(userId); // 삽입 후 사용자 반환
        }
    }
	
	// 네이버 로그인 
	public int isExistUserId(String userId) {
		return mapper.selectUserId(userId);
	}

	public Object updateUserFromNaver(Map<String, Object> naverUserInfo) {
		return mapper.updateNaverUser(naverUserInfo);
	}
	
	public Object insertUserFromNaver(Map<String, Object> naverUserInfo) {
		return mapper.registNaverUser(naverUserInfo);
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

	public int modifyPasswd(Map<String, Object> user) {
		System.out.println("서비스에서 받은 user 정보 : " + user);
		return mapper.updatePasswd(user);
	}

	
    // 필드를 업데이트하는 메소드
    public boolean updateField(String userId, String field, String value) {
        return mapper.updateField(userId, field, value);
    }

    public boolean isNicknameAvailable(String nickname) {
    	
        return !mapper.isNicknameTaken(nickname);
    }


    // 프로필 사진 변경
	public boolean updateUserProfile(String userId, String fileUrl) {
		
        return mapper.updateUserProfile(userId, fileUrl) > 0;
	}


	// 소개글 수정
	public boolean updateText(String userId, String editText) {
		
		return mapper.updateText(userId, editText) > 0;
	}

    

	
}
