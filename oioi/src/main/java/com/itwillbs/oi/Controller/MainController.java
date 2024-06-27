package com.itwillbs.oi.Controller;

import java.util.ArrayList;
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
		model.addAttribute("productList", productList);
		
		return productList;
	}
	
	@ResponseBody
	@GetMapping("recentLookProductList")
	public List<Map<String, Object>> recentLookProductList(@RequestParam Map<String, String> map, Model model) {
		
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
	
        // 최종 결과를 담을 리스트를 초기화합니다.
        List<Map<String, Object>> recentProductList = new ArrayList<>();

        // 각 상품 ID에 대해 서비스를 통해 상품 정보를 가져와 리스트에 추가합니다.
        for (int productId : productSet) {
            List<Map<String, Object>> products = service.getRecentLookProduct(productId);
            if (!products.isEmpty()) {
            	recentProductList.addAll(products);
            }
        }

        // 결과를 출력합니다. (디버깅용)
        System.out.println("최근 본 상품입니다 " + recentProductList);
        
		return recentProductList;
	}
}
