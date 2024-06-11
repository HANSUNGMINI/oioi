package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.service.MailService;
import com.itwillbs.oi.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService service;
	@Autowired
	private MailService mailService;
	
	@GetMapping("login")
	public String goLogin() {
		return "user/login";
	}
	
	//회원가입 폼
	@GetMapping("register")
	public String goRegister() {
		return "user/register";
	}
	
	@GetMapping("check_id")
	public String check_id() {
		return "user/check_id";
	}
	
	// 실제 유효성검사를 마친후 중복확인 DB작업을 하기 위한 매핑주소
	@PostMapping("check_id")
	public String checkIdPro(String user_id, Model model, HttpServletResponse response) {
		boolean isEmptyId = service.isEmptyId(user_id);
		model.addAttribute("userId", user_id);
		model.addAttribute("isValid", !isEmptyId);
		
		return "redirect:/check_id";
	}
	
	@PostMapping("register")
	public String joinPro(@RequestBody Map<String, Object> userMap, Model model, BCryptPasswordEncoder passwordEncoder) {
		String userEmail = (String) userMap.get("user_email");
		String userPhone = (String) userMap.get("user_phone");
		
		boolean isEmptyEmail = service.isEmptyEmail(userEmail);
		boolean isEmptyPhoneNum = service.isEmptyPhoneNum(userPhone);
		
		if(!isEmptyEmail) {
			model.addAttribute("msg", "이미 가입된 이메일 입니다.");
			return "err/fail";
		}
		
		if(!isEmptyPhoneNum) {
			model.addAttribute("msg", "이미 가입된 전화번호입니다.");
			return "err/fail";
		}
		
		String securePasswd = passwordEncoder.encode((String)userMap.get("user_passwd"));
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("US_ID", (String)userMap.get("user_id"));
		resultMap.put("US_PASSWD", securePasswd);
		resultMap.put("US_NAME", (String)userMap.get("user_name"));
		resultMap.put("US_NICK", (String)userMap.get("user_nick"));
		resultMap.put("US_EMAIL", userEmail);
		resultMap.put("US_POST_CODE", (String)userMap.get("user_post_code"));
		resultMap.put("US_ADDRESS1", (String)userMap.get("user_address1"));
		resultMap.put("US_ADDRESS2", (String)userMap.get("user_address2"));
		resultMap.put("US_GENDER", (String)userMap.get("user_gender"));
		resultMap.put("US_PHONE", userPhone);
		
		if(service.registUser(resultMap) > 0) {
			model.addAttribute("msg", "회원가입에 성공하셨습니다!");
			return "user/regist_success";
		} else {
			model.addAttribute("msg", "회원가입 실패!");
			return "err/fail";
		}
	}
	
//	@PostMapping("register")
//	public String joinPro(userVO user, Model model, BCryptPasswordEncoder passwordEncoder) {
//		System.out.println(user);
//		// ------------------------------메일-----------------------------
////		System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + user.getuser_email());
//		// MailService - sendAuthMail() 메서드 호출하여 인증 메일 발송 요청
//		// => 파라미터 : userVO 객체   리턴타입 : MailAuthInfoVO(mailAuthInfo)
////		MailAuthInfoVO mailAuthInfo = mailService.sendAuthMail(user);
////		System.out.println("인증정보 : " + mailAuthInfo);
////		
////		// userService - registMailAuthInfo() 메서드 호출하여 인증 정보 등록 요청
////		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : void
////		service.registMailAuthInfo(mailAuthInfo);
//		
//		// ----------------------중복 이메일 전화번호 확인------------------------------
//		boolean isEmptyEmail = service.isEmptyEmail(user.getuser_email());
//		boolean isEmptyPhoneNum = service.isEmptyPhoneNum(user.getuser_phone());
//		
//		if(!isEmptyEmail) {
//			model.addAttribute("msg", "이미 가입된 이메일 입니다.");
//			return "err/fail";
//		}
//		
//		if(!isEmptyPhoneNum) {
//			model.addAttribute("msg", "이미 가입된 전화번호입니다.");
//			return "err/fail";
//		}
//		//-------------------------비밀번호 암호화-------------------------------------
//		String securePasswd = passwordEncoder.encode(user.getuser_passwd());
//		user.setuser_passwd(securePasswd);
//		
//		if(service.registuser(user) > 0) {
//			model.addAttribute("user_id", user.getuser_id());
//			System.out.println(user.getuser_id());
//			return "user/regist_success";
//		} else {
//			model.addAttribute("msg", "회원가입 실패!");
//			return "err/fail";
//		}
//	}
	@ResponseBody
	@PostMapping("SendAuthMail")
	public ResponseEntity<Map<String, Object>> sendAuthMail(@RequestBody Map<String, Object> userMap) {
		
		Map<String, Object> response = new HashMap<>();
		
		try {
			Map<String, Object> mailAuthInfoMap = mailService.sendAuthMail(userMap);
			service.registMailAuthInfo(mailAuthInfoMap);
			response.put("success", true);
			response.put("auth_code", mailAuthInfoMap.get("auth_code"));
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "인증메일 발송에 실패했습니다. 다시 시도해주세요.");
			
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}
	
//	// 이메일 인증
//		@ResponseBody
//		@PostMapping("SendAuthMail")
//		public ResponseEntity<Map<String, Object>> sendAuthMail(@RequestBody userVO user) {
//			Map<String, Object> response = new HashMap<>();
//			
//			try {
//				MailAuthInfoVO mailAuthInfo = mailService.sendAuthMail(user);
//				service.registMailAuthInfo(mailAuthInfo);
//				response.put("success", true);
//				response.put("auth_code", mailAuthInfo.getAuth_code());
//				return ResponseEntity.ok(response);
//			} catch (Exception e) {
//				response.put("success", false);
//				response.put("message", "인증메일 발송에 실패했습니다. 다시 시도해주세요.");
//				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
//			}
//		}
		
		
////	// 이메일 인증
//	@ResponseBody
//	@PostMapping ("SendAuthMail")
//	public String sendAuthMail(userVO user, RedirectAttributes redirectAttributes) {
//		System.out.println(user.getuser_email());
////		// MailService - sendAuthMail() 메서드 호출하여 인증 메일 발송 요청
////		// => 파라미터 : userVO 객체   리턴타입 : MailAuthInfoVO(mailAuthInfo)
//		MailAuthInfoVO mailAuthInfo = mailService.sendAuthMail(user);
//		System.out.println("인증정보 : " + mailAuthInfo);
////		
////		// userService - registMailAuthInfo() 메서드 호출하여 인증 정보 등록 요청
////		// => 파라미터 : MailAuthInfoVO 객체   리턴타입 : void
//		service.registMailAuthInfo(mailAuthInfo);
//		// 성공 메시지를 리디렉트 속성에 추가
//		redirectAttributes.addFlashAttribute("msg", "인증메일이 발송되었습니다.");
//		
//		// 폼 데이터를 리디렉트 속성에 추가
//		redirectAttributes.addFlashAttribute("user", user);
//		//		// send_auth_mail_success.jsp 페이지 포워딩
//		return "이메일 전송 성공";
//	}
//	
////	 [ 이메일 인증 비즈니스 로직 ] 
////	 "userEmailAuth" 서블릿 주소 매핑(인증정보 파라미터 저장)
//	@GetMapping("userEmailAuth")
//	public String emailAuth(MailAuthInfoVO authInfo, Model model) {
//		System.out.println("인증정보 : " + authInfo);
////		
////		// userService - requestEmailAuth() 메서드 호출하여 이메일 인증 요청
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
	
//	@PostMapping("login")
//	public String loginPro(userVO user,  HttpSession session , Model model, BCryptPasswordEncoder passwordEncoder) {
//		
//		userVO dbuser = service.getuser(user);
//		
//		if(dbuser == null || !passwordEncoder.matches(user.getuser_passwd(), dbuser.getuser_passwd())){ // 로그인 실패
//			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다.\\n입력하신 내용을 다시 확인해주세요.");
//			return "err/fail";
//		} else if (dbuser.getuser_status() == 2) {
//			model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
//			return "err/fail";
//		}else { // 로그인 성공
//			// 세션 객체에 로그인 성공한 아이디를 "sId" 속성값으로 추가
//			session.setAttribute("user_id", user.getuser_id());
//			
//			// 메인페이지 리다이렉트
//			return "redirect:/";
//		}
//		
//	}
}
