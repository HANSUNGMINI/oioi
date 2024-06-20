package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.handler.PageInfo;
import com.itwillbs.oi.service.AdminService;

/*
 * HTTP 맵핑 종류
 * GET		= 리소스 조회
 * POST		= 등록, 요청 데이터 처리 
 * PUT		= 리소스 덮어쓰기 (해당 리소스가 없으면 생성)
 * PATCH	= 리소스 부분 분경 (PUT은 전체 변경이지만, PATCH는 일부만 변경)
 * DELETE	= 리소스 삭제
 * */

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
			return "err/fail";
		}
		
		return "admin/admin_main";
	}
	
	@GetMapping("admin_user")
	public String admin_user(Model model) {
		
		if(!CheckAuthority.isAdmin(session, model)) {
			return "err/fail";
		}
		return "admin/admin_user_list";
	}
	
	@GetMapping("admin_product")
	public String admin_product(Model model) {
		
		if(!CheckAuthority.isAdmin(session, model)) {
			return "err/fail";
		}
		return "admin/admin_product_list";
	}
	
	@GetMapping("admin_board")
	public String admin_board(Model model) {
		
		if(!CheckAuthority.isAdmin(session, model)) {
			return "err/fail";
		}
		return "admin/admin_user_list";
	}
	
	@GetMapping("admin_report")
	public String admin_report(Model model) {
		
		if(!CheckAuthority.isAdmin(session, model)) {
			return "err/fail";
		}
		return "admin/admin_user_list";
	}
	@GetMapping("admin_chat")
	public String admin_chat(Model model) {
		
		if(!CheckAuthority.isAdmin(session, model)) {
			return "err/fail";
		}
		return "admin/admin_user_list";
	}
	
	@GetMapping("master_admin")
	public String master_admin(Model model) {
		
		//TODO 왜 자바스크립트에서 처리가 안되는지 물어보기(늦
		if(!CheckAuthority.isAdminMaster(session, model)) {
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
	 	// List 조회
	@ResponseBody
	@GetMapping("List")
	public List<Map<String, Object>> List(@RequestParam Map<String, Object> select, Model model) {
		
		List<Map<String, Object>> result = null;
		
		String table = select.get("table").toString();
		
		switch (table) {
			case "admin" : result = adminservice.selectAdminList(select); break;
			case "user" : result = adminservice.selectUserList(select); break;
			case "product" : result = adminservice.selectProductList(select); break;
		}
		
		return result;
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
		return adminservice.selectAdminList(select);
	}
		// 공통 코드 조회
	@ResponseBody
	@PostMapping("selectCode")
	public List<Map<String, Object>> selectCode(@RequestParam Map<String, Object> select,  Model model) {
		return adminservice.selectCommonList(select);
	}
		// 공통 코드 상태 변경
	@ResponseBody
	@PostMapping("changeHide")
	public int changeHide(@RequestParam Map<String, Object> select) {
		return adminservice.changeHide(select);
	}
		// 공통코드 value값 수정하기
	@ResponseBody
	@PatchMapping("common")
	public int patchCommon(@RequestBody Map<String, Object> map) {
		return adminservice.patchcommon(map);
	}
		// 공통코드 추가하기
	@ResponseBody
	@PutMapping("common")
	public int addCommon(@RequestBody Map<String, Object> map) {
		System.out.println(map);
		int result = adminservice.insertCommon(map);
		return result;
	}
		// 공통코드 삭제
	@ResponseBody
	@DeleteMapping("common")
	public int deleteCommon(@RequestBody Map<String, Object> map) {
		return adminservice.deleteCommon(map);
	}
	
		// 관리자 권한 바꾸기
	@ResponseBody
	@PostMapping("changeActive")
	public int changeActive(@RequestParam Map<String, Object> select) {
		return adminservice.changeActive(select);
	}
	
	
}
