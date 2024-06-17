package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.service.SearchService;

@Controller
public class SearchController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	SearchService service;
	
	// 연관 검색어 뽑아오기
	@ResponseBody
	@GetMapping("searchRecommend")
	public List<Map<String, String>> searchRecommend(@RequestParam Map<String,String> map) {
		System.out.println(map);
//		System.out.println(map);
		List<Map<String, String>> recommendList = service.getList(map);
		System.out.println(">>>>>>>>>>>>" + service.getList(map));
		return recommendList;
	}

}
