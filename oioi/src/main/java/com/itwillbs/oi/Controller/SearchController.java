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

import com.itwillbs.oi.handler.CheckSearchKeyword;
import com.itwillbs.oi.service.SearchService;

@Controller
public class SearchController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	SearchService service;
	
	@Autowired
	CheckSearchKeyword searchKeyword;
	
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
		//System.out.println(">>>>>> 검색해서 이동한 키워드 : " + map);

		String keyword = (String)map.get("keyword");
		
		if (keyword == "") {
			return "";
		}
		
		// 중복된 키워드 있는지 확인
		int duplicateNum = service.duplicateKeyword(map); 

		// 중복되지 않고, 자음 / 모음만 입력한 게 아닐 경우
		if(duplicateNum < 1 && !searchKeyword.isConsonantOnly(keyword) && !searchKeyword.containsVowel(keyword)) {
			// 키워드 넣기
			service.registKeyword(map);
		} else {
			// 키워드 카운트 갱신 
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
		//System.out.println(">>>>>>>>>>>>>"+ popularList);
		model.addAttribute("popularList",popularList);
		
		return popularList;
	}
	
	// 검색 이동
	@GetMapping("researchProduct")
	public String goResearchProduct() {
		
		return "trade/searchProduct";
	}
	
	// 검색어 가져오기
	@ResponseBody
	@GetMapping("researchProductList")
	public List<Map<String, Object>> goResearch(@RequestParam Map map, Model model) {
		//System.out.println("넘어오나 " + map);
		List<Map<String, Object>> productList = service.getSearchProducts(map);
		//System.out.println(productList);
		model.addAttribute("productList", productList);
		
		return productList;
	}
	
	// 안 읽은 메세지 개수 가져오기
	@ResponseBody
	@GetMapping("getMyUnreadCount")
	public int getMyUnreadCount(@RequestParam Map map, Model model) {
		
		// 안 읽은 메세지 개수 가져오기
		int unread = service.getMyUnreadCount(map);
		return unread;
	}
	
	@ResponseBody
	@GetMapping("getMyMainChatList")
	public List<Map<String, Object>> getMyMainChatList(@RequestParam Map map, Model model) {
		
		// 대화내용 두 개만 가져오기
		List<Map<String, Object>> mainChatList= service.getMainChatList(map);
		
		return mainChatList;
	}
}
