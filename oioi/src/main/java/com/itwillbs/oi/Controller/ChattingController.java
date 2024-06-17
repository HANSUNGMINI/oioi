package com.itwillbs.oi.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.oi.handler.CheckAuthority;

@Controller
public class ChattingController {
	
	@Autowired
	HttpSession session;

	@GetMapping("ChatList")
	public String goChatList(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		return "chatting/chatting_list";
	}
	
	@GetMapping("Chatting")
	public String goChatting(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		return "chatting/chattingRoom";
	}
	
}
