package com.itwillbs.oi.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ChatBotController {
	
	// 챗봇
	@GetMapping("chatbot")
	public String goChatbot() {
		return "customerCenter/chatbot2";
	}
}


