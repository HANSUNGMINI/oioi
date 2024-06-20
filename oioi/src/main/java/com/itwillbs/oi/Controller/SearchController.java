package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
//		System.out.println(map);
		List<Map<String, String>> recommendList = service.getList(map);
		
		return recommendList;
	}
	
	// 검색 키워드 저장
	@ResponseBody
	@GetMapping("SaveSearchKeyword")
	public String saveSearchKeyword(@RequestParam Map<String, String> map) {
		System.out.println(">>>>>> 검색해서 이동한 키워드 : " + map);
		
		// 중복된 키워드 있는지 확인
		int duplicateNum = service.duplicateKeyword(map); 
		System.out.println(">>>>>" + duplicateNum);
		
		if(duplicateNum < 1) {
			// 키워드 넣기
			service.registKeyword(map);
		} else {
			// 카운트 갱신 
			service.upCount(map);
		}
		
		return "";
	}
	
	// 인기 검색어 불러오기
	@ResponseBody
	@GetMapping("popularSearchKeywordList")
	public List<Map<String, Object>> popularSearchKeywordList(Model model) {
		
		// 모든 정보 가져오기
		List<Map<String, Object>> popularList = service.getPopularKeyword();
		System.out.println(">>>>>>>>>>>>>"+ popularList);
		model.addAttribute("popularList",popularList);
		
		return popularList;
	}

}
