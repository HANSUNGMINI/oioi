package com.itwillbs.oi.Controller;

import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
	
	@ResponseBody
	@GetMapping("recentLookProductList")
	public String recentLookProductList(@RequestParam Map<String, String> map, Model model) {
		
		System.out.println(">>> map에 머가 있을가 " + map); // recentProduct=50,32,32,49,50,50,50,50,45,45
		
		// String으로 바꾸기
		String recentProduct = map.get("recentProduct"); 
		
        // ','를 구분자로 문자열 분리
        String[] productsArray = recentProduct.split(",");

        // 숫자들을 저장할 Set 생성 (중복 제거 및 순서 유지)
        Set<Integer> productSet = new LinkedHashSet<>();

        // 배열을 순회하면서 Set에 숫자 추가
        for (String product : productsArray) {
            productSet.add(Integer.parseInt(product.trim()));
        }

        // 결과 출력
        System.out.println(productSet); // [50, 32, 49, 45]
	
        List<Map<String, String>> productList = null;
        
        // 데이터 뽑아오기
        for (int product : productSet) {
        	productList = service.getRecentLookProduct(product);
        }
        
        
		return "";
	}
}
