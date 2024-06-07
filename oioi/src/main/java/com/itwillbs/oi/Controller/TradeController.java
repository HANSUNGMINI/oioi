package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TradeController {
	
	
	@GetMapping("trade")
	public String goTrade() {
		return "trade";
	}
	
	@GetMapping("product")
	public String goProductRegist() {
		return "product";
	}
	
	@GetMapping("detail")
	public String goDetail() {
		return "detailView";
	}
}
