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
	
	// 유저
		// 유저 목록조회
	@ResponseBody
	@PostMapping("UserList")
	public Map<String, Object> UserList(@RequestParam Map<String, Object> select, Model model) {
		// 모든 객체를 담아가는 리턴용 Map 선언
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println(select);
		// 1. 페이지 넘버 파싱, 2. 페이지넘버로 조회용 Map 객체 생성, 3. 구문실행 파라미터에 삽입
		int pageNum = Integer.parseInt(select.get("pageNum").toString());
		Map<String, Integer> pagination = PageInfo.limitPagination(pageNum);
		select.put("page", pagination);
		
		// 리스트 조회
	    List<Map<String, Object>> userList = adminservice.selectUserList(select);
	    
	    // 조회내용이 없으면 result 객체에 빈 객체 넣어서 가져가기
		if(userList.isEmpty()) {
			System.out.println("없음");
			result.put("userList", userList);
			return result;
		}
		
		// 조회된 내용이 있다면 첫 번째 row데이터의 리스트카운트 가져와서 저장
	    int listCount = Integer.parseInt(userList.get(0).get("listCount").toString());
	    
	    // result 객체에 각각 삽입해서 리턴
	    result.put("userList", userList);
	     	// 위에서 만든 조회용 Map객체와 listCount 받아서 페이지버튼 만드는 Map객체 생성
	    result.put("pageInfo", PageInfo.makePagination(pagination, listCount));
	    
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
		List<Map<String, Object>> adminList = adminservice.selectAdminList(select);
		return adminList;
	}
		// 공통 코드 조회
	@ResponseBody
	@PostMapping("selectCode")
	public List<Map<String, Object>> selectCode(@RequestParam Map<String, Object> select,  Model model) {
		List<Map<String, Object>> commonList = adminservice.selectCommonList(select);
		return commonList;
	}
		// 공통 코드 상태 변경
	@ResponseBody
	@PostMapping("changeHide")
	public int changeHide(@RequestParam Map<String, Object> select) {
		int result = adminservice.changeHide(select);
		
		return result;
	}
		// 공통코드 value값 수정하기
	@ResponseBody
	@PatchMapping("common")
	public int patchCommon(@RequestBody Map<String, Object> map) {
		System.out.println(map);
		int result = adminservice.patchcommon(map);
		return result;
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
		System.out.println(map);
		int result = adminservice.deleteCommon(map);
		System.out.println(result);
		return result;
	}
	
		// 관리자 권한 바꾸기
	@ResponseBody
	@PostMapping("changeActive")
	public int changeActive(@RequestParam Map<String, Object> select) {
		int result = adminservice.changeActive(select);
		return result;
	}
	
	
}
