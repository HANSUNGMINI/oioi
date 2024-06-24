package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OipayController {
	
	@GetMapping("oiPay")
	public String oiPay() {
		
		return "oipay/oipay";
	}
	
	@GetMapping("payCharge")
	public String payCharge() {
		
		String pay = "charge";
		
		return pay;
	}
	@GetMapping("payRefund")
	public String payRefund() {
		
		String pay = "refund";
		
		return pay;
	}

}
