package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {
	
	@GetMapping("myPage")
	public String myPage() {
		
		return "mypage/mypage";
	}
	
	@GetMapping("user")
	public String user() {
		System.out.println("확인");
		return "mypage/mypage_user";
	}
}
