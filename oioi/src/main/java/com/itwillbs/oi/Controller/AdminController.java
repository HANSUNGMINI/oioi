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

import com.itwillbs.oi.handler.CheckAuthority;
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
		return "redirect:/./";
	}
	
	@GetMapping("admin")
	public String goAdmin(Model model) {
		
		// 관리자가 아님
		if(!CheckAuthority.isAdmin(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		return "admin/admin_main";
	}
	
	@GetMapping("user")
	public String userlist(Model model) {
		
		if(!CheckAuthority.isAdmin(session, model)) {
			return "err/fail";
		}
		return "admin/admin_user_list";
	}
	
	@GetMapping("master_admin")
	public String master_admin(Model model) {
		
		//TODO 왜 자바스크립트에서 처리가 안되는지 물어보기
		if(!CheckAuthority.isAdminMaster(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		return "admin/admin_master_admin";
	}
	
	//==========================
	// DB작업 후 이동 메소드
	@PostMapping("admin")
	public String adminLogin(@RequestParam Map<String, String> admin
							, Model model) {
		
		Map<String, Object> selectedAdmin = adminservice.selectAdmin(admin);
		
		if(selectedAdmin == null) {
			model.addAttribute("msg", "다시 시도");
			return "err/fail";
		}
		
		if(selectedAdmin.get("RL_NAME").toString().equals("최고관리자")) {
			session.setAttribute("isMaster", true);
		}
		
		session.setAttribute("isAdmin", true);
		session.setAttribute("admin", selectedAdmin);
		
		return "admin/admin_main";
	}
	
	
	@GetMapping("master_category")
	public String master_category(Model model) {
		
		if (session.getAttribute("isMaster") == null ) {
			model.addAttribute("msg", "권한 없음!");
			return "err/fail";
		}
		
		List<Map<String, Object>> categoryList = adminservice.selectCategoryList();
		
		System.out.println(categoryList);
		
		model.addAttribute("categoryList", categoryList);
		return "admin/admin_master_category";
	}
	
	//==========================
	// AJAX 메소드
	
	// 유저
		// 유저 목록조회
	@ResponseBody
	@PostMapping("UserList")
	public List<Map<String, Object>> UserList(@RequestParam Map<String, Object> select) {
		PageInfo pageInfo = new PageInfo(Integer.parseInt(select.get("pageNum").toString()), 10);
		select.put("limit", pageInfo);
		
//		PageInfo.makePageInfo(pageInfo, 0, 0);
		
		List<Map<String, Object>> userList = adminservice.selectUserList(select);
		
		return userList;
	}
		// 유저 상세조회
	@ResponseBody
	@PostMapping("UserDetail")
	public Map<String, Object> UserDetail(@RequestParam Map<String, String> user) {
		Map<String, Object> map = null;
		return map;
	}
	
	
	// 관리자
		// 관리자 목록 조회
	@ResponseBody
	@PostMapping("masterAdmin")
	public List<Map<String, Object>> masterAdmin(@RequestParam Map<String, Object> select,  Model model) {
		List<Map<String, Object>> adminList = adminservice.selectAdminList(select);
		return adminList;
	}
		// 공통 코드 조회
	@ResponseBody
	@PostMapping("selectCode")
	public List<Map<String, Object>> selectCode(@RequestParam Map<String, Object> select,  Model model) {
		System.out.println(select);
		List<Map<String, Object>> commonList = adminservice.selectCommonList(select);
		System.out.println(commonList);
		return commonList;
	}
		// 공통 코드 상태 변경
	@ResponseBody
	@PostMapping("changeHide")
	public int changeHide(@RequestParam Map<String, Object> select) {
		System.out.println(select);
		int updateChangeActive = adminservice.changeHide(select);
		
		return updateChangeActive;
	}
		// 관리자 권한 바꾸기
	@ResponseBody
	@PostMapping("changeActive")
	public int changeActive(@RequestParam Map<String, Object> select) {
		System.out.println(select);
		int updateChangeActive = adminservice.changeActive(select);
		
		return updateChangeActive;
	}
	
	
}
