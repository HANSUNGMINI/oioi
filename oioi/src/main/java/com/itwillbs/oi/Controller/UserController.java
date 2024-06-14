package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.service.MailService;
import com.itwillbs.oi.service.UserService;

@Controller
public class UserController {
	//여기서 오류가 나는건가?
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
	
	@GetMapping("check_nick")
	public String check_nick() {
		return "user/check_nick";
	}
	
	// 실제 유효성검사를 마친후 중복확인 DB작업을 하기 위한 매핑주소
	@PostMapping("check_nick")
	public String checkNickPro(String user_nick, Model model, HttpServletResponse response) {
		boolean isEmptyNick = service.isEmptyNick(user_nick);
		model.addAttribute("userNick", user_nick);
		model.addAttribute("isValidNick", !isEmptyNick);
		
		return "redirect:/check_nick";
	}
	
	
	@PostMapping("register")
	public String joinPro(@RequestParam Map<String, Object> userMap, Model model, BCryptPasswordEncoder passwordEncoder) {
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
	
	@PostMapping("login")
	public String loginPro(@RequestParam Map<String, String> loginData, HttpSession session, Model model, BCryptPasswordEncoder passwordEncoder, HttpServletResponse response) {
	    
	    String userId = loginData.get("user_id");
	    String userPasswd = loginData.get("user_passwd");
	    String rememberId = loginData.get("rememberMe");
	    // 서비스를 통해 회원 정보 가져오기
	    Map<String, String> dbUser = service.selectUser(userId); // 회원 ID로 회원 정보를 가져오는 메서드가 있다고 가정합니다.
	    if(dbUser == null || !passwordEncoder.matches(userPasswd, dbUser.get("US_PASSWD"))) { // 로그인 실패
	        model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다.\\n입력하신 내용을 다시 확인해주세요.");
	        return "err/fail";
	    } else if ("2".equals(dbUser.get("US_STATUS"))) {
	        model.addAttribute("msg", "이미 탈퇴한 회원입니다.");
	        return "err/fail";
	    } else { // 로그인 성공
	        // 세션 객체에 로그인 성공한 아이디 및 닉네임 저장
	        session.setAttribute("US_ID", userId);
	        session.setAttribute("US_NICK", dbUser.get("US_NICK"));
	        System.out.println("로그인 아이디: " + userId);
	        System.out.println("회원정보" + dbUser);
	        
	        Cookie cookie = new Cookie("cookieId", userId);
	        if(rememberId != null) { // 체크박스 체크 상태일 경우 쿠키 설정
	        	cookie.setMaxAge(60 * 60 * 24); // 60초 * 60분 * 24시간 = 86000초 = 1일
	        } else {
	        	cookie.setMaxAge(0);
	        }
	        response.addCookie(cookie);
	        System.out.println(cookie);
	        // 메인페이지 리다이렉트
	        return "redirect:/";
	    }
	}
	
	@GetMapping("lost_id")
	public String lost_id() {
		return "user/lost_id";
	}
	
	@PostMapping("lost_id")
	public String lostIdPro(@RequestParam Map<String, Object> userMap, Model model) {
		System.out.println("받은 userMap 정보 : " + userMap);
		Map<String, Object> user = service.findId(userMap);
		System.out.println("조회된 user정보 : " + user);
		if(user != null) {
			mailService.sendForgotId(user);
			model.addAttribute("msg", "이메일 전송이 완료되었습니다.");
			model.addAttribute("targetURL", "login");
			return "err/fail";
		} else {
			model.addAttribute("msg", "이름 또는 E-Mail 주소를 잘못 입력하셨습니다.");
			return "err/fail";
		}
	}
	
	@GetMapping("lost_passwd")
	public String lostPasswd() {
		return "user/lost_passwd";
	}
	
//	@PostMapping("lost_passwd")
//	public String lostPasswdPro() {
//		
//	}
}
