package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String goChatting(Model model, @RequestParam Map<String, String> map) {
		
		System.out.println(">>>> map " + map);
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		// 닉네임 및 상품 제목 가져오기
		Map<String, String> info = service.getUserInfo(map);
		System.out.println(">>>>>> " + info);
		
		// 채팅 목록 불러오기 
		
		// 리뷰 카테고리 불러오기
		List<Map<String, String>> reviewMap = service.getReviewCategory();
		
		// 신고 카테고리 불러오기
		List<Map<String, String>> reportMap = service.getReportCategory();

		// model에 담아서 정보 보내기
		model.addAttribute("info", info); // 상대방 닉네임 + 상품 정보
		model.addAttribute("reportMap", reportMap); // [공통코드] 신고 카테고리
		model.addAttribute("reviewMap", reviewMap); // [공통코드] 리뷰 카테고리
		
		return "chatting/chattingRoom";
	}
	
	@PostMapping("report")
	public String reportUser(@RequestParam Map<String, String> map) {
		
		System.out.println("신고 맵 " + map);
		
		
		return "";
	}
	
}
