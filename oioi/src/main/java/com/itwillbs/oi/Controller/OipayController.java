package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.OipayService;

@Controller
public class OipayController {
	@Autowired
	private OipayService service;
	
	@GetMapping("connectAct")
	public String connectAct(HttpSession session, Model model) {
		if(!CheckAuthority.isUser(session, model, CheckAuthority.LOGIN)) {
			return "err/fail";
		}
		return "oipay/connectAct";
	}
	
	@GetMapping("callback")
	public String auth(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		String id = (String)session.getAttribute("US_ID");
		
		Map<String, Object> token = service.getAccessToken(authResponse);
		
		if(token == null || token.get("access_token") == null) {
			model.addAttribute("msg", "토큰 발급 실패! 다시 인증하세요!🥺");
			model.addAttribute("isClose", true);
			return "err/fail";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("token", token);
		service.registAccessToken(map);
		
		session.setAttribute("token", token);
		
		model.addAttribute("msg", "계좌 인증 완료!");
		model.addAttribute("isClose", true);
		model.addAttribute("targetURL", "oiPay");
		return "err/success";
	}
	
	@GetMapping("oiPay")
	public String oiPay(Model model, HttpSession session) {
		
		if(!CheckAuthority.isUser(session, model, CheckAuthority.MAIN)) {
			return "err/fail";
		}
		
		String access_token = (String)session.getAttribute("BUI_ACCESS_TOKEN");
//		System.out.println(">>>>>>>>>>>" + session.getAttribute("BUI_ACCESS_TOKEN"));
		
		if(access_token == null) {
			model.addAttribute("msg", "잘못된 접근입니다😓😓");
			return "err/fail";
		}
		
		
		
		Map<String, Object> token = service.selectUserBankInfo(access_token);
//		System.out.println(")))))))))))))))))))))))))))" + token);
		Map actUserInfo = service.getUserInfo(token);
		System.out.println("@@@@@@@@@@@@@@@" + actUserInfo);
		
		model.addAttribute("actUserInfo", actUserInfo);
		
		return "oipay/oipay";
	}
	
	@GetMapping("payCharge")
	public String payCharge(HttpSession session) {
		
		// 엑세스 토큰 관련 정보가 저장된 BankTokenVO 객체 가져오기
		System.out.println(session.getAttribute("BUI_ACCESS_TOKEN"));
		
		
		// 세션 체크
		// 1) 세션 아이디가 없을 경우 fail.jsp 포워딩 처리("잘못된 접근입니다", "./" 경로 전달)
		// 2) 세션에 저장된 엑세스토큰(access_token)이 없을 경우 fail.jsp 포워딩 처리
		//    => "계좌 인증 수행 필수!" 메세지 및 "MemberInfo" 경로 전달
//		if(session.getAttribute("sId") == null) {
//			model.addAttribute("msg", "잘못된 접근입니다");
//			model.addAttribute("targetURL", "./");
//			return "result_process/fail";
//		} else if(token == null || token.getAccess_token() == null) {
//			model.addAttribute("msg", "계좌 인증 수행 필수!");
//			model.addAttribute("targetURL", "MemberInfo");
//			return "result_process/fail";
//		}
		
//		map.put("token", token);
//		map.put("id", (String)session.getAttribute("sId"));
//		logger.info(">>>>>>>>>>> 출금 요청 정보 : " + map);
		
		// BankService - withdraw() 메서드 호출하여 출금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : Map(withdrawResult)
//		Map withdrawResult = bankService.withdraw(map);
		
//		logger.info(">>>>>>>>>>> 출금 요청 결과(withdrawResult) : " + withdrawResult);
		
		// 출금 요청 결과 객체 저장 후 bank_withdraw_result 페이지로 포워딩
//		model.addAttribute("withdrawResult", withdrawResult);
		
		
		return "";
	}
	@GetMapping("payRefund")
	public String payRefund() {
		
		
		return "";
	}

}
