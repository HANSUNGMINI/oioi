package com.itwillbs.oi.Controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		System.out.println(member);
		// ------------------------------메일-----------------------------
//		System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + member.getMember_email());
		// MailService - sendAuthMail() 메서드 호출하여 인증 메일 발송 요청
		// => 파라미터 : MemberVO 객체   리턴타입 : MailAuthInfoVO(mailAuthInfo)
//		MailAuthInfoVO mailAuthInfo = mailService.sendAuthMail(member);
//		System.out.println("인증정보 : " + mailAuthInfo);
//		
//		// MemberService - registMailAuthInfo() 메서드 호출하여 인증 정보 등록 요청
//		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : void
//		service.registMailAuthInfo(mailAuthInfo);
		
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
	
////	// 이메일 인증
//	@GetMapping("SendAuthMail")
//	public String sendAuthMail(MemberVO member, RedirectAttributes redirectAttributes) {
//		System.out.println(member.getMember_email());
////		// MailService - sendAuthMail() 메서드 호출하여 인증 메일 발송 요청
////		// => 파라미터 : MemberVO 객체   리턴타입 : MailAuthInfoVO(mailAuthInfo)
//		MailAuthInfoVO mailAuthInfo = mailService.sendAuthMail(member);
////		System.out.println("인증정보 : " + mailAuthInfo);
////		
////		// MemberService - registMailAuthInfo() 메서드 호출하여 인증 정보 등록 요청
////		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : void
//		service.registMailAuthInfo(mailAuthInfo);
//		// 성공 메시지를 리디렉트 속성에 추가
//		redirectAttributes.addFlashAttribute("msg", "인증메일이 발송되었습니다.");
//		
//		// 폼 데이터를 리디렉트 속성에 추가
//		redirectAttributes.addFlashAttribute("member", member);
//		//		// send_auth_mail_success.jsp 페이지 포워딩
//		return "redirect:/register";
//	}
////	
////	 [ 이메일 인증 비즈니스 로직 ] 
////	 "MemberEmailAuth" 서블릿 주소 매핑(인증정보 파라미터 저장)
//	@GetMapping("MemberEmailAuth")
//	public String emailAuth(MailAuthInfoVO authInfo, Model model) {
//		System.out.println("인증정보 : " + authInfo);
////		
////		// MemberService - requestEmailAuth() 메서드 호출하여 이메일 인증 요청
////		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : boolean(isAuthSuccess)
//		boolean isAuthSuccess = service.requestEmailAuth(authInfo);
////		
////		// 인증 요청 결과 판별
////		// 임시) 성공/실패 모두 error/fail.jsp 페이지로 포워딩
////		// 성공 시 : "인증 성공! 로그인 페이지로 이동합니다!" 메세지와 로그인 페이지 주소 전달
////		// 실패 시 : "인증 실패!" 메세지 전달
//		if(isAuthSuccess) {
//			model.addAttribute("msg", "인증 성공!\\n로그인 페이지로 이동합니다!");
//			model.addAttribute("targetURL", "login");
//		} else {
//			model.addAttribute("msg", "인증 실패!");
//		}
////		
//		return "err/fail";
//	}
	
	@PostMapping("login")
	public String loginPro(MemberVO member,  HttpSession session , Model model, BCryptPasswordEncoder passwordEncoder) {
		
		MemberVO dbMember = service.getMember(member);
		
		if(dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())){ // 로그인 실패
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다.\\n입력하신 내용을 다시 확인해주세요.");
			return "err/fail";
		} else if (dbMember.getMember_status() == 2) {
			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
			return "err/fail";
		}else { // 로그인 성공
			// 세션 객체에 로그인 성공한 아이디를 "sId" 속성값으로 추가
			session.setAttribute("member_id", member.getMember_id());
			
			// 메인페이지 리다이렉트
			return "redirect:/";
		}
		
	}
}
