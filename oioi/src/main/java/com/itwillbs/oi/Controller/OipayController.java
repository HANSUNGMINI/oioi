package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.OipayService;
import com.itwillbs.oi.service.TradeService;

import kotlin.reflect.jvm.internal.impl.types.model.TypeSystemOptimizationContext;

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
		
		session.setAttribute("BUI_ACCESS_TOKEN", token.get("access_token"));
		
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
		
		if(access_token == null) {
			model.addAttribute("msg", "잘못된 접근입니다😓😓");
			return "err/fail";
		} else if (session.getAttribute("US_ID") == null) {
			model.addAttribute("msg", "로그인 후 사용가능합니다");
			return "err/fail";
		}
		
		
		Map<String, Object> token = service.selectUserBankInfo(access_token);
		Map bankUserInfo = service.getUserInfo(token);
		
		model.addAttribute("token", token);
		model.addAttribute("bankUserInfo", bankUserInfo);
		session.setAttribute("token", token);
		session.setAttribute("bankUserInfo", bankUserInfo);
		
		
		return "oipay/oipay";
	}
	
	@ResponseBody
	@PostMapping("payCharge") // 출금
	public String payCharge(HttpSession session, Model model,
							@RequestParam Map<String, Object> map) {
		
		// 엑세스 토큰 관련 정보가 저장된 BankTokenVO 객체 가져오기
		String access_token = (String)session.getAttribute("BUI_ACCESS_TOKEN");
		
		if(!CheckAuthority.isUser(session, model, CheckAuthority.MAIN)) {
			model.addAttribute("msg", "로그인 후 이용해주세요.");
			return "err/error";
		}
		
		if(access_token == null) {
			model.addAttribute("msg", "계좌 연결 후 이용해주세요.");
			return "err/error";
		}
		
		Map token = (Map)session.getAttribute("token");
		System.out.println("token ----------------------" + token);
//		Map bankUserInfo = service.getUserInfo(token);
//		System.out.println("bankUserInfo+++++++++++++++" + bankUserInfo);
		map.put("token", token);
		map.put("id", (String)session.getAttribute("US_ID"));
		
		
		// BankService - withdraw() 메서드 호출하여 출금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : Map(withdrawResult)
		Map withdrawResult = service.withdraw(map);
		System.out.println("withdrawResult>>>>>>>>>>" + withdrawResult);
		
		// 출금 요청 결과 객체 저장 후 bank_withdraw_result 페이지로 포워딩
//		model.addAttribute("withdrawResult", withdrawResult);
//		System.out.println(withdrawResult.get("rsp_code"));
		if(withdrawResult.get("rsp_code").equals("A0000")) {
			System.out.println(map.get("amtInput"));
			System.out.println(map.get("id"));
			service.updateOimoney(map);
		} else {
			model.addAttribute("msg", "충전에 실패했습니다😓😓");
			return "err/error";
		}
		
		return withdrawResult.toString();
	}
	
	
	@GetMapping("payRefund")
	public String payRefund() {
		
		
		return "";
	}
	
//	@ResponseBody
	@GetMapping("purchase")
	public String purhcase(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		System.out.println(map);
		// 상품정보 가져오기
		int PD_IDX = Integer.parseInt(map.get("PD_IDX"));
		Map<String, Object> product = service.selectTradePDInfo(PD_IDX);
		System.out.println(product);
		
		// 머니 정보 가져오기
		String id = (String)session.getAttribute("US_ID");
//		System.out.println(id);
		int oiMoney = service.selectOiMoney(id);
//		System.out.println(oiMoney);
		
		model.addAttribute("product", product);
		model.addAttribute("oimoney", oiMoney);
				
		return "oipay/payment";
	}

}
