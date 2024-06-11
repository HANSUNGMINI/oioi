package com.itwillbs.oi.Controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@PostMapping("product")
	public String submitProduct(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		System.out.println(map.get("tag"));
		
		return "";
	}
}
