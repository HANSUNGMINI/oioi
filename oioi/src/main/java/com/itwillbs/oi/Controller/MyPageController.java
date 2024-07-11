package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.UserService;

@Controller
public class MyPageController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private UserService service;
	
	@GetMapping("myPage")
	public String myPage(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		
		String id = (String)session.getAttribute("US_ID");
		
		Map<String, String> user = service.selectMyUser(id);
		
		model.addAttribute("user", user);

		return "mypage/mypage";
	}
	
	// 	회원 정보 수정
	@GetMapping("userUpdate")
	public String userUpdate(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		String id = (String)session.getAttribute("US_ID");
		Map<String, String> user = service.selectMyUser(id);
		
		// 주소 결합
		String ad1 = user.get("US_ADDRESS1"); 
		String ad2 = user.get("US_ADDRESS2");
		String ad = ad1 + ", " + ad2;
		user.put("ad", ad);

		model.addAttribute("user", user);
		
		return "mypage/mypage_user";
	}
	
    @PostMapping("checkNickname")
    @ResponseBody
    public Map<String, Object> checkNickname(@RequestParam String nickname) {
//    	Map<String, Object> result = new HashMap<String, Object>();
    	
        boolean isValidNick = service.isNicknameAvailable(nickname);
        return Map.of("isValidNick", isValidNick);
    }
	
    // 필드를 업데이트하는 메소드
    @PostMapping("updateField")
    @ResponseBody
    public Map<String, Object> updateField(@RequestParam String field, @RequestParam String value) {
        // 세션에서 사용자 ID를 가져옴
        String id = (String) session.getAttribute("US_ID");

        // 서비스 호출을 통해 필드 업데이트
        boolean updateResult = service.updateField(id, field, value);

        // 업데이트 결과에 따라 JSON 형식의 응답을 반환
        if (updateResult) {
            return Map.of("result", true);
        } else {
            return Map.of("result", false, "message", "필드 변경 실패!");
        }
    }
	
    @GetMapping("userLogout")
    public String userLogout() {
    	session.invalidate();
    	
    	return "redirect:/";
    }
    
    @GetMapping("myTrade")
    public String myTrade(Model model) {
    	
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
    	
    	return "mypage/my_trade";
    }
    
    @GetMapping("myReport")
    public String myReport(Model model) {
    	
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
    	return "mypage/my_report";
    }
	
	
	
}
