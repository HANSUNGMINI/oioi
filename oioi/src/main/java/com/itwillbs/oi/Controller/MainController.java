package com.itwillbs.oi.Controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {

	@ResponseBody
	@GetMapping("recentKeywordProductList")
	public String recentKeywordProductList(@RequestParam Map<String, String> map) {
		System.out.println(">>>>>>>>> map : " + map);
		
		return "";
	}
}
