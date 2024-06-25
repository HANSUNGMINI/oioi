package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.ChattingService;

@Controller
public class ChattingController {
	
	@Autowired
	private HttpSession session;

	@Autowired
	private ChattingService service;
	
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
		
		// 상품 목록 및 유저 정보 불러오기
		
		
		// 채팅 목록 불러오기 
		
		// 신고 카테고리 불러오기
		List<Map<String, String>> reportMap = service.getReportCategory();
		model.addAttribute("reportMap", reportMap);
		
		return "chatting/chattingRoom";
	}
	
	
}
