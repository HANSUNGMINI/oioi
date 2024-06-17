package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		
		// 주소 결합
		String ad1 = user.get("US_ADDRESS1"); 
		String ad2 = user.get("US_ADDRESS2");
		String ad = ad1 + ", " + ad2;
		user.put("ad", ad);

		model.addAttribute("user", user);
		
		return "mypage/mypage_user";
	}
	
	@PostMapping("updateNickname")
	@ResponseBody
	public String updateNickname(@RequestParam Map<String, String> map, Model model) {
		String newNick = map.get("nickname"); // 받아옴
//		System.out.println("닉네임 : " + newNick);
		
		
		return "";
	}
	
	
	
	
}
