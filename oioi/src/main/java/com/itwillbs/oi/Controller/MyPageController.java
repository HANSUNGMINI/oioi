package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.UserService;

@Controller
public class MyPageController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private UserService service;
	
	@GetMapping("myPage")
	public String myPage(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		
		String id = (String)session.getAttribute("US_ID");
		
		Map<String, String> user = service.selectMyUser(id);
		
		model.addAttribute("user", user);

		return "mypage/mypage";
	}
	
	// 	회원 정보 수정
	@GetMapping("userUpdate")
	public String userUpdate(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		String id = (String)session.getAttribute("US_ID");
		Map<String, String> user = service.selectMyUser(id);

		model.addAttribute("user", user);
		
		return "mypage/mypage_user";
	}
	
	
	
	
}
