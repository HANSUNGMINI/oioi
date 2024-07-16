package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.oi.handler.GenerateRandomCode;
import com.itwillbs.oi.service.UserService;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@RestController
public class coolSmsController {

    @Autowired
    private HttpSession session;
    
    @Autowired
    private UserService service;

    final DefaultMessageService messageService;

    public coolSmsController() {
        this.messageService = NurigoApp.INSTANCE.initialize("NCS97ALCFUUNEUTN", "DO7VGOIBS8DAASGIL8C8EUKYITAW82KH", "https://api.coolsms.co.kr");
    }

    @ResponseBody
    @PostMapping("send-one")
    public String sendOne(@RequestBody Map<String, String> requestBody) {
        session.setMaxInactiveInterval(300);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            String user_phone = requestBody.get("user_phone");
            String auth_num = GenerateRandomCode.getAuthCode();

            Message message = new Message();
            message.setFrom("01065959094");
            message.setTo(user_phone);
            message.setText("[OiMarket] 아래의 인증번호를 입력해 주세요. \n인증번호 : ["+ auth_num + "]");

            SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));

            session.setAttribute("auth_num", auth_num);

            resultMap.put("success", true);
            resultMap.put("auth_num", auth_num);

        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success", false);
        }

        JSONObject jo = new JSONObject(resultMap);

        return jo.toString();
    }

    @ResponseBody
    @PostMapping("send-user-id")
    public String sendUserId(@RequestBody Map<String, String> requestBody) {
        session.setMaxInactiveInterval(300);
        Map<String, Object> resultMap = new HashMap<>();
        Map<String, Object> user = new HashMap<String, Object>();
        try {
            String userName = requestBody.get("user_name2");
            String userPhone = requestBody.get("user_phone");
            user.put("userPhone", userPhone);
            user.put("userName", userName);
            String userId = service.findUserIdByPhone(user);
            if (userId != null) {
                String messageText = "[OiMarket] 회원님의 ID는 " + userId + " 입니다.";

                Message message = new Message();
                message.setFrom("01065959094");
                message.setTo(userPhone);
                message.setText(messageText);

                SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));

                resultMap.put("success", true);
                resultMap.put("userId", userId);
            } else {
                resultMap.put("success", false);
                resultMap.put("message", "해당 이름과 전화번호로 등록된 회원이 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success", false);
        }

        JSONObject jo = new JSONObject(resultMap);

        return jo.toString();
    }

    @ResponseBody
    @PostMapping("send-user-passwd")
    public String sendUserPw(@RequestBody Map<String, String> requestBody) {
        session.setMaxInactiveInterval(300);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> user = new HashMap<String, Object>();
        try {
            String userId = requestBody.get("user_id2");
            String userName = requestBody.get("user_name2");
            String user_phone = requestBody.get("user_phone");
            String auth_num = GenerateRandomCode.getAuthCode();
            user.put("userId" , userId);
            user.put("userName" , userName);
            user.put("userPhone" , user_phone);
            int userData = service.findUserData(user);
            if(userData > 0) {
                Message message = new Message();
                message.setFrom("01065959094");
                message.setTo(user_phone);
                message.setText("[OiMarket] 아래의 인증번호를 입력해 주세요. \n인증번호 : ["+ auth_num + "]");

                SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
                session.setAttribute("auth_num", auth_num);
                resultMap.put("success", true);
                resultMap.put("auth_num", auth_num);
            } else {
                resultMap.put("success", false);
                resultMap.put("message", "해당 정보로 등록된 회원이 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("success", false);
        }

        JSONObject jo = new JSONObject(resultMap);

        return jo.toString();
    }

    @ResponseBody
    @PostMapping("verifyPhoneAuthCode")
    public ResponseEntity<Map<String, Object>> verifyPhoneAuthCode(@RequestBody Map<String, String> requestBody) {
        String inputAuthCode = requestBody.get("authCode");
        String sessionAuthCode = (String) session.getAttribute("auth_num");
        Map<String, Object> resultMap = new HashMap<>();

        if (sessionAuthCode != null && sessionAuthCode.equals(inputAuthCode)) {
            resultMap.put("success", true);
            resultMap.put("message", "인증되었습니다.");
        } else {
            resultMap.put("success", false);
            resultMap.put("message", "인증번호가 일치하지 않습니다.");
        }

        return ResponseEntity.ok(resultMap);
    }
}

//	    @ResponseBody
//	    @PostMapping("send-user-id")
//	    public String sendUserId(@RequestBody Map<String, String> requestBody, HttpSession session) {
//	        
//	        session.setMaxInactiveInterval(300);
//	        
//	        Map<String, Object> resultMap = new HashMap<String, Object>();
//	        
//	        try {
//	            String user_phone = requestBody.get("user_phone");
//	            String userId = userService.findUserIdByPhone(user_phone);
//	            
//	            if (userId != null) {
//	                String messageText = "[OiMarket] 회원님의 ID는: " + userId + " 입니다.";
//
//	                Message message = new Message();
//	                message.setFrom("01065959094");
//	                message.setTo(user_phone);
//	                message.setText(messageText);
//
//	                SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
//	                
//	                resultMap.put("success", true);
//	                resultMap.put("userId", userId);
//	            } else {
//	                resultMap.put("success", false);
//	                resultMap.put("message", "해당 전화번호로 등록된 회원이 없습니다.");
//	            }
//	        } catch (Exception e) {
//	            e.printStackTrace();
//	            resultMap.put("success", false);
//	        }
//	        
//	        JSONObject jo = new JSONObject(resultMap);
//	        
//	        return jo.toString();
//	    }
//	}
	    
