package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.service.MainService;


@Controller
public class MainController {

	@Autowired
	private MainService service;
	
	@ResponseBody
	@GetMapping("recentKeywordProductList")
	public List<Map<String, Object>> recentKeywordProductList(@RequestParam Map<String, String> map, Model model) {
		System.out.println(map);
		List<Map<String, Object>> productList = service.getRecentKeywordProduct(map);
		System.out.println(">>>>> productList " + productList);
		model.addAttribute("productList", productList);
		
		return productList;
	}
}
