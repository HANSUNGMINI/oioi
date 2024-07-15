package com.itwillbs.oi.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.itwillbs.oi.handler.GenerateRandomCode;
import com.itwillbs.oi.handler.SendMailClient;

@Service
public class MailService {
	
    private Map<String, String> authCodes = new HashMap<>();


    public Map<String, Object> sendAuthMail(Map<String, Object> userMap) {
        String userEmail = (String) userMap.get("user_email");
        if (userEmail == null || userEmail.isEmpty()) {
            throw new IllegalArgumentException("유효한 이메일 주소를 입력하세요.");
        }

        String auth_code = GenerateRandomCode.getRandomCode(6);
        String subject = "[오이마켓] 가입 인증 메일입니다.";
        String content = "오이마켓 가입 인증을 위해 해당 인증번호를 홈페이지에 입력해주세요. 인증번호: " + auth_code;

        SendMailClient mailClient = new SendMailClient();
        new Thread(() -> {
            try {
                mailClient.sendMail(userEmail, subject, content);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();

        Map<String, Object> authInfo = new HashMap<>();
        authInfo.put("US_EMAIL", userEmail);
        authInfo.put("auth_code", auth_code);

        return authInfo;
    }

    public void sendForgotId(Map<String, Object> user) {
        String userEmail = (String) user.get("US_EMAIL");
        if (userEmail == null || userEmail.isEmpty()) {
            throw new IllegalArgumentException("유효한 이메일 주소를 입력하세요.");
        }

        String userId = (String) user.get("US_ID");
        String subject = "[오이마켓] 아이디를 확인해주세요.";
        String content = "회원님의 가입된 아이디는 <b>" + userId + "</b>입니다.";

        SendMailClient mailClient = new SendMailClient();
        new Thread(() -> {
            try {
                mailClient.sendMail(userEmail, subject, content);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();
    }

    public void sendForgotPw(Map<String, Object> user) {
        String userEmail = (String) user.get("US_EMAIL");
        if (userEmail == null || userEmail.isEmpty()) {
            throw new IllegalArgumentException("유효한 이메일 주소를 입력하세요.");
        }

        String subject = "[오이마켓] 비밀번호 변경 이메일입니다.";
        String content = "<a href='http://c3d2401t1.itwillbs.com/oioi/change_passwd?user_id=" 
                        + user.get("US_ID") 
                        + "&user_name=" + user.get("US_NAME")
                        + "&user_email=" + userEmail
                        + "'>클릭 시 새 비밀번호 설정 페이지로 이동합니다.</a>";

        SendMailClient mailClient = new SendMailClient();
        new Thread(() -> {
            try {
                mailClient.sendMail(userEmail, subject, content);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();
    }

    public Map<String, Object> sendChangeEmailAuthMail(Map<String, Object> userMap) {
        String newEmail = (String) userMap.get("email");
        if (newEmail == null || newEmail.isEmpty()) {
            throw new IllegalArgumentException("유효한 이메일 주소를 입력하세요.");
        }

        String authCode = GenerateRandomCode.getRandomCode(6);
        String subject = "[오이마켓] 이메일 변경 인증 코드입니다.";
        String content = "오이마켓 이메일 변경을 위해 해당 인증번호를 홈페이지에 입력해주세요. 인증번호: " + authCode;

        SendMailClient mailClient = new SendMailClient();
        new Thread(() -> {
            try {
                mailClient.sendMail(newEmail, subject, content);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();

        authCodes.put(newEmail, authCode);

        Map<String, Object> authInfo = new HashMap<>();
        authInfo.put("new_email", newEmail);
        authInfo.put("auth_code", authCode);

        return authInfo;
    }
    
    public String getAuthCode(String email) {
        return authCodes.get(email);
    }
}
