package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class CustomerCenterController {
	@GetMapping("notice")
	public String goNotice() {
		return "customerCenter/notice";
	}
}
