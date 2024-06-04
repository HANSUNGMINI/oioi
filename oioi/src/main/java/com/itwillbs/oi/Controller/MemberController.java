package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
	
	@GetMapping("login")
	public String goLogin() {
		return "member/login";
	}
	
	@GetMapping("register")
	public String goRegister() {
		return "member/register";
	}
}
