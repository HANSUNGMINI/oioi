package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyStoreController {
	
	@GetMapping("myStore")
	public String myStore() {
		return "myStore/myStore";
	}
}
