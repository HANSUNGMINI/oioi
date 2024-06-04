package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChattingController {

	@GetMapping("ChatList")
	public String goChatList() {
		return "chatting/chatting_list";
	}
	
}
