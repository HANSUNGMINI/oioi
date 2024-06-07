package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
	
	
	@GetMapping("adminMain")
	public String adminMain() {
		return "admin/admin_main";
	}
	
	
	@GetMapping("adminMain2")
	public String adminMain2() {
		return "admin/admin_main2";
	}
}
