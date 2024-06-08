package com.itwillbs.oi.Controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.oi.service.MailService;
import com.itwillbs.oi.service.MemberService;
import com.itwillbs.oi.vo.MailAuthInfoVO;
import com.itwillbs.oi.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	@Autowired
	private MailService mailService;
	
	@GetMapping("login")
	public String goLogin() {
		return "member/login";
	}
	
	//회원가입 폼
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
	
	@PostMapping("register")
	public String joinPro(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
		
		// ------------------------------메일-----------------------------
//		System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + member.getMember_email());
		// MailService - sendAuthMail() 메서드 호출하여 인증 메일 발송 요청
		// => 파라미터 : MemberVO 객체   리턴타입 : MailAuthInfoVO(mailAuthInfo)
		MailAuthInfoVO mailAuthInfo = mailService.sendAuthMail(member);
		System.out.println("인증정보 : " + mailAuthInfo);
		
		// MemberService - registMailAuthInfo() 메서드 호출하여 인증 정보 등록 요청
		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : void
		service.registMailAuthInfo(mailAuthInfo);
		
		// ----------------------중복 이메일 전화번호 확인------------------------------
		boolean isEmptyEmail = service.isEmptyEmail(member.getMember_email());
		boolean isEmptyPhoneNum = service.isEmptyPhoneNum(member.getMember_phone());
		
		if(!isEmptyEmail) {
			model.addAttribute("msg", "이미 가입된 이메일 입니다.");
			return "err/fail";
		}
		
		if(!isEmptyPhoneNum) {
			model.addAttribute("msg", "이미 가입된 전화번호입니다.");
			return "err/fail";
		}
		//-------------------------비밀번호 암호화-------------------------------------
		String securePasswd = passwordEncoder.encode(member.getMember_passwd());
		member.setMember_passwd(securePasswd);
		
		if(service.registMember(member) > 0) {
			model.addAttribute("member_id", member.getMember_id());
			System.out.println(member.getMember_id());
			return "member/regist_success";
		} else {
			model.addAttribute("msg", "회원가입 실패!");
			return "err/fail";
		}
	}
	
}
