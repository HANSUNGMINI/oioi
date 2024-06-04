package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SellingController {
	
	@GetMapping("selling")
	public String Auction() {
		return "selling";
	}
}
