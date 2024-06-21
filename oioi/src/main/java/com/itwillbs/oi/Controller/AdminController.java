package com.itwillbs.oi.Controller;

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
import com.itwillbs.oi.service.AdminService;

import retrofit2.http.PATCH;

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
	public String goLoginPage() {return "admin/admin_login";}
	@GetMapping("logout")
	public String logout() {session.invalidate(); return "redirect:/./";}
	
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
		return "admin/admin_common_code_list";
	}
	
	
	// 최고 관리자용
	@GetMapping("master_admin")
	public String master_admin(Model model) {
		
		if(!CheckAuthority.isAdminMaster(session, model)) {
			return "err/fail";
		}
		
		return "admin/admin_admin_list";
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
		return "admin/admin_common_code_list";
	}
	
	//==========================
	// AJAX 메소드
	 	// List 조회
	@ResponseBody
	@GetMapping("List")
	public List<Map<String, Object>> selectList(@RequestParam Map<String, Object> data, Model model) {
		
		List<Map<String, Object>> result = null;
		
		String target = data.get("table").toString();
		
		System.out.println(data);
		switch (target) {
			case "admin" : result = adminservice.selectAdminList(data); break;
			case "user" : result = adminservice.selectUserList(data); break;
			case "product" : result = adminservice.selectProductList(data); break;
			case "common" : result = adminservice.selectCommonList(data); break;
		}
		
		
		System.out.println(result);
		return result;
	}
		// status 관리
	@ResponseBody
	@PatchMapping("status")
	public int changeStatus(@RequestBody Map<String, Object> data, Model model) {
		System.out.println(data);
		
		String target = data.get("type").toString();
		int result = 0;
		
		switch (target) {
			case "AD_ACTIVE" : result = adminservice.changeActive(data); break;
			case "hide" : result = adminservice.changeHide(data); break;
		}
		
		return result;
	}
	
	
	
	// 관리자
		// 공통코드 value값 수정하기
	@ResponseBody
	@PutMapping("common")
	public int putCommon(@RequestBody Map<String, Object> map) {
		Map<String, Object> modifiedRows = (Map<String, Object>)map.get("modifiedRows");
		
		
		int result = 0;
		// 수정한 row 작업
		List<Map<String, Object>> updateRows = (List<Map<String, Object>>)modifiedRows.get("updatedRows");
		System.out.println(updateRows);
		if(updateRows != null) {
			for(Map<String, Object> item : updateRows) {
				result += adminservice.patchcommon(item);
			}
		}
		
		// 추가한 row작업
		List<Map<String, Object>> createdRows = (List<Map<String, Object>>)modifiedRows.get("createdRows");
		System.out.println(createdRows);
		if(createdRows != null) {
			for(Map<String, Object> item : createdRows) {
				item.put("target", map.get("target"));
				result += adminservice.insertCommon(item);
			}
		}
		
		return result;
	}

		// 공통코드 삭제
	@ResponseBody
	@DeleteMapping("common")
	public int deleteCommon(@RequestBody Map<String, Object> map) {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(map);
		List<Map<String, Object>> deleteRows = (List<Map<String, Object>>)map.get("deleteRows");
		
		int result = 0;
		
		for(Map<String, Object> item : deleteRows) {
			result += adminservice.deleteCommon(item);
		}
		
		return result;
	}
	
	
	
	// ============================================보관용=====================================================
//	@ResponseBody
//	@PatchMapping("common")
//	public int patchCommon(@RequestBody Map<String, Object> map) {
//		
//		System.out.println(map);
//		List<Map<String, Object>> updateRows = (List<Map<String, Object>>)map.get("updatedRows");
//		
//		int result = 0;
//		
//		for(Map<String, Object> item : updateRows) {
//			result += adminservice.patchcommon(item);
//		}
//		
//		return result;
//	}
}
