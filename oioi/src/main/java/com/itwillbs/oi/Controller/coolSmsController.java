package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.itwillbs.oi.handler.GenerateRandomCode;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@RestController
public class coolSmsController {


	    final DefaultMessageService messageService;

	    public coolSmsController() {
	        // 반드시 계정 내 등록된 유효한 API 키, API Secret Key를 입력해주셔야 합니다!
	        this.messageService = NurigoApp.INSTANCE.initialize("NCSSPBG6VN2CC6NF", "N4RIO8T2ADGR6FPM8NFAPZURGWSCF4DD", "https://api.coolsms.co.kr");

	    }
	    
	    @ResponseBody
	    @PostMapping("send-one")
	    public String sendOne(@RequestParam String member_phone, HttpSession session) {
	    	
	    	session.setMaxInactiveInterval(300);
	    	
	    	Map<String, Object> resultMap = new HashMap<String, Object>();
	    	
	    	try {
		    	String auth_num = GenerateRandomCode.getAuthCode();
		    	
		        Message message = new Message();
		        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
		        message.setFrom("01065959094");
		        message.setTo(member_phone);
		        message.setText("[OiMarket] 아래의 인증번호를 입력해 주세요. \n인증번호 : ["+ auth_num + "]");
	
		        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
//		        System.out.println(response);
		        
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
	    
	    
}
