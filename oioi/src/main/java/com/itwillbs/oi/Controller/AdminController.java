package com.itwillbs.oi.Controller;

import java.util.Map;

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
	
	
	@GetMapping("adminlogin")
	public String goLoginPage() {
		return "admin/admin_login";
	}
	
	@PostMapping("adminlogin")
	public String adminLogin(@RequestParam Map<String, String> admin
							, Model model) {
		
		System.out.println(admin);
		System.out.println("======================");
		Map<String, Object> selectedAdmin = adminservice.selectAdmin(admin);
		if(selectedAdmin == null) {
			model.addAttribute("msg", "다시 시도");
			return "err/fail";
		}
		
		model.addAttribute("admin", selectedAdmin);
		return "admin/admin_main";
	}
}
