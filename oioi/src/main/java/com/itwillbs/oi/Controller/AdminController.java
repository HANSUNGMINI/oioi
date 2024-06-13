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
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.handler.PageInfo;
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
		
		session.setAttribute("admin", selectedAdmin);
		return "redirect:/admin";
	}
	
	// AJAX 메소드
	@ResponseBody
	@PostMapping("UserList")
	public List<Map<String, Object>> UserList(@RequestParam Map<String, Object> select) {
		PageInfo pageInfo = new PageInfo(Integer.parseInt(select.get("pageNum").toString()), 3);
		select.put("limit", pageInfo);
		
//		PageInfo.makePageInfo(pageInfo, 0, 0);
		
		List<Map<String, Object>> userList = adminservice.selectUserList(select);
		
		return userList;
	}
	
	@ResponseBody
	@PostMapping("UserDetail")
	public Map<String, Object> UserDetail(@RequestParam Map<String, String> user) {
		Map<String, Object> map = null;
		return map;
	}
	
}
