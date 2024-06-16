package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
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
	    private UserService userService;

	    final DefaultMessageService messageService;

	    public coolSmsController() {
	        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
	        this.messageService = NurigoApp.INSTANCE.initialize("NCSSPBG6VN2CC6NF", "N4RIO8T2ADGR6FPM8NFAPZURGWSCF4DD", "https://api.coolsms.co.kr");

	    }
	    @ResponseBody
	    @PostMapping("send-one")
	    public String sendOne(@RequestBody Map<String, String> requestBody, HttpSession session) {
	    	
	    	session.setMaxInactiveInterval(300);
	    	
	    	Map<String, Object> resultMap = new HashMap<String, Object>();
	    	
	    	try {
		    	String user_phone = requestBody.get("user_phone");
		    	String auth_num = GenerateRandomCode.getAuthCode();
		    	
		        Message message = new Message();
		        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
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
	    public String sendUserId(@RequestBody Map<String, String> requestBody, HttpSession session) {
	        
	        session.setMaxInactiveInterval(300);
	        System.out.println(requestBody);
	        Map<String, Object> resultMap = new HashMap<>();
	        Map<String, Object> user = new HashMap<String, Object>();
	        try {
	            String userName = requestBody.get("user_name2");
	            String userPhone = requestBody.get("user_phone");
	            System.out.println(userName);
	            user.put("userPhone", userPhone);
	            user.put("userName", userName);
	            // 이름과 전화번호로 사용자 조회
	            String userId = userService.findUserIdByPhone(user);
	            System.out.println(userId);
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
	    
