package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.itwillbs.oi.service.OipayService;

@Controller
public class OipayController {
	@Autowired
	private OipayService service;
	
	@GetMapping("connectAct")
	public String connectAct() {
		
		return "oipay/connectAct";
	}
	
	@GetMapping("oiPay")
	public String oiPay() {
		
		return "oipay/oipay";
	}
	
	@GetMapping("payCharge")
	public String payCharge() {
		
		
		return "";
	}
	@GetMapping("payRefund")
	public String payRefund() {
		
		
		return "";
	}
	
	@GetMapping("callback")
	public String auth(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		String id = (String)session.getAttribute("US_ID");
		
//		System.out.println("11111111111111111111111111" + id);
		
//		System.out.println("22222222222222222222222222" +  authResponse);

		Map<String, Object> token = service.getAccessToken(authResponse);
		
//		System.out.println("3333333333333333333333333" + token);
		
		if(token == null || token.get("access_token") == null) {
			model.addAttribute("msg", "토큰 발급 실패! 다시 인증하세요!");
			model.addAttribute("isClose", true);
			return "err/fail";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("token", token);
		service.registAccessToken(map);
		
		session.setAttribute("token", token);
		
//		System.out.println("4444444444444444444444" + token);
		
		model.addAttribute("msg", "계좌 인증 완료!");
		model.addAttribute("isClose", true);
		model.addAttribute("targetURL", "oiPay");
		return "err/success";
	}
	

}
