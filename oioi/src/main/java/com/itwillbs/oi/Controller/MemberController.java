package com.itwillbs.oi.Controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.oi.service.MemberService;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("login")
	public String goLogin() {
		return "member/login";
	}
	
	@GetMapping("register")
	public String goRegister() {
		return "member/register";
	}
	
	@GetMapping("check_id")
	public String check_id() {
		return "member/check_id";
	}
	
	// 실제 유효성검사를 마친후 중복확인 DB작업을 하기 위한 매핑주소
	@PostMapping("check_id")
	public String check_id_pro(String member_id, Model model, HttpServletResponse response) {
		boolean isEmptyId = service.isEmptyId(member_id);
		model.addAttribute("member_id", member_id);
		model.addAttribute("isValid", !isEmptyId);
		
		return "redirect:/check_id";
	}
	
	
	
}
