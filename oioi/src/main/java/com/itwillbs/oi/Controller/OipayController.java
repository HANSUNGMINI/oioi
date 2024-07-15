package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.ChattingService;
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
		
		if(!CheckAuthority.checkStatus(session, model)) {
			model.addAttribute("isClose", true);
			model.addAttribute("hrefOpener", true);
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
		
		if(!CheckAuthority.checkStatus(session, model)) {
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
//		System.out.println("token ----------------------" + token);
//		Map bankUserInfo = service.getUserInfo(token);
//		System.out.println("bankUserInfo+++++++++++++++" + bankUserInfo);
		map.put("token", token);
		map.put("id", (String)session.getAttribute("US_ID"));
		
		
		// BankService - withdraw() 메서드 호출하여 출금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : Map(withdrawResult)
		Map withdrawResult = service.withdraw(map);
//		System.out.println("withdrawResult>>>>>>>>>>" + withdrawResult);
		
		// 출금 요청 결과 객체 저장 후 bank_withdraw_result 페이지로 포워딩
//		model.addAttribute("withdrawResult", withdrawResult);
//		System.out.println(withdrawResult.get("rsp_code"));
		System.out.println("rsp코드드드드드듣 드드드드드드다ㅡ" + withdrawResult.get("rsp_code"));
		if(withdrawResult.get("rsp_code").equals("A0000")) {
//			System.out.println(map.get("amtInput"));
//			System.out.println(map.get("id"));
			service.updateOimoney(map);
		} else {
//			model.addAttribute("msg", "충전에 실패했습니다😓😓");
			return null;
		}
		
		return withdrawResult.toString();
	}
	
	@ResponseBody
	@PostMapping("payRefund")
	public JsonObject payRefund(HttpSession session, Model model, @RequestParam Map<String,Object> map) {
		String access_token = (String)session.getAttribute("BUI_ACCESS_TOKEN");
		
//		if(!CheckAuthority.isUser(session, model, CheckAuthority.MAIN)) {
//			model.addAttribute("msg", "로그인 후 이용해주세요.");
//			return "err/fail";
//		}
//		
//		if(access_token == null) {
//			model.addAttribute("msg", "계좌 연결 후 이용해주세요.");
//			return "err/fail";
//		}
		
		JsonObject result = new JsonObject();
		
		map.put("token", access_token);
		map.put("id", (String)session.getAttribute("US_ID"));
		
		int amt = Integer.parseInt(map.get("amtInput").toString());
		int oiMoney =  Integer.parseInt(map.get("US_OIMONEY").toString()); 
		
		
		if(amt > oiMoney) {
			result.addProperty ("msg", "오이머니 잔액이 부족합니다🥺");
			result.addProperty ("result", "error");
			return result;
		} 
		
		Map depositResult = service.deposit(map);
		
//		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>" + depositResult);
		// 입금 요청 결과 객체 저장 후 bank_deposit_result 페이지로 포워딩
//		model.addAttribute("depositResult", depositResult);
//		System.out.println("++++++++++++++++" + map);
		if(depositResult.get("rsp_code").equals("A0000")) {
			service.updateRefundOimoney(map);
		} else {
			result.addProperty ("msg", "출금에 실패하였습니다🥺");
			result.addProperty ("result", "error");
			return result;
		}
		
		result.addProperty ("msg", "머니가 출금되었습니다😊");
		result.addProperty ("result", "success");
		return result;
	}
	
	
	@GetMapping("purchase") //결제페이지
	public String purhcase(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		
//		System.out.println(map); //{TO_ID=gkstyd13, PD_IDX=12}
		
		String BUYER_ID = (String)session.getAttribute("US_ID");
		map.put("BUYER_ID", BUYER_ID);
		
		// 채팅방 번호 가져오기
		String CR_ID = service.getChatRoomNum(map);
		
		// 상품정보 가져오기
		int PD_IDX = Integer.parseInt(map.get("PD_IDX"));
		Map<String, Object> product = service.selectTradePDInfo(PD_IDX);
		
		product.put("CR_ID", CR_ID);
//		System.out.println(">>>>>>>>"+product);
		
		// 판매자 닉네임 가져오기
		String sellerId = (String)product.get("US_ID");
		String sellerNick = service.getSellerNick(sellerId);
		product.put("sellerNick", sellerNick);
		
		// 머니 정보 가져오기
		String id = (String)session.getAttribute("US_ID");
		int oiMoney = service.selectOiMoney(id);
		
//		System.out.println(product);
//		System.out.println(oiMoney);
		
		model.addAttribute("product", product);
		model.addAttribute("oimoney", oiMoney);
				
		return "oipay/payment";
	}

	
	@PostMapping("purchase") // 결제
	public String purchasePro(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		String US_ID = (String)session.getAttribute("US_ID");
		map.put("US_ID", US_ID);

		System.out.println(map);
//		System.out.println(map); // {TO_ID=test, PD_IDX=71, PD_STATUS=판매 중, US_ID=haru0321, PD_PRICE=5000, US_OIMONEY=495000}
		
		int price = Integer.parseInt((String)map.get("PD_PRICE"));
		int oiMoney = Integer.parseInt((String)map.get("US_OIMONEY"));
		
		if(price > oiMoney) {
			model.addAttribute("msg", "오이머니 잔액이 부족합니다🥺");
			return "err/fail";
		}
		
		service.purchaseByOimoney(map);
		
		model.addAttribute("msg", "결제가 완료되었습니다😊🎉");
		model.addAttribute("openerReload", true);
		model.addAttribute("isClose", true);
		return "err/success";
	}
}
