package com.itwillbs.oi.Controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.oi.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminservice;
	@Autowired
	private HttpSession session;
	
	
	// 이동 메소드
	@GetMapping("adminlogin")
	public String goLoginPage() {
		return "admin/admin_login";
	}
	
	@GetMapping("logout")
	public String logout() {
		session.invalidate();
		return "home";
	}
	
	@GetMapping("user")
	public String userlist() {
		return "admin/admin_user_list";
	}
	
	@GetMapping("admin")
	public String goAdmin() {
		return "admin/admin_main";
	}
	
	
	// DB작업 후 이동 메소드
	@PostMapping("admin")
	public String adminLogin(@RequestParam Map<String, String> admin
							, Model model) {
		Map<String, Object> selectedAdmin = adminservice.selectAdmin(admin);
		if(selectedAdmin == null) {
			model.addAttribute("msg", "다시 시도");
			return "err/fail";
		}
		
		System.out.println(selectedAdmin);
		model.addAttribute("admin", selectedAdmin);
		return "redirect:/admin";
	}
	
	// AJAX 메소드
}
