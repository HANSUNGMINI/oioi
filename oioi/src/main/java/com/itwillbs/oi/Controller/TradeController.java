package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.oi.service.AuctionService;
import com.itwillbs.oi.service.TradeService;

@MultipartConfig
@Controller
public class TradeController {
	
	@Autowired 
	private TradeService TradeService;
	@Autowired
	private AuctionService Auctionservice;
	
	@GetMapping("trade")
	public String goTrade() {
		return "trade";
	}
	
	@GetMapping("product")
	public String goProductRegist(Model model) {
		// 카테고리 
		List<Map<String, String>> cate1 = Auctionservice.getCategory1();
		model.addAttribute("cate1", cate1);
		
		// 상품 상태
		List<Map<String, String>> productCondition = TradeService.getProductCondition();
		model.addAttribute("productCondition", productCondition);
//		System.out.println(productCondition);
		
		// 거래 방식
		List<Map<String, String>> tradeMethod = TradeService.getTradeMethod();
		model.addAttribute("tradeMethod", tradeMethod);
		System.out.println(tradeMethod);
		return "product";
	}
	
	@GetMapping("detail")
	public String goDetail() {
		return "detailView";
	}
	
	@PostMapping("product")
	public String submitProduct(@RequestParam Map<String, Object> map, Model model
			,@RequestPart("addfile") MultipartFile[] files) {
		System.out.println(map);
		System.out.println(map.get("tag"));

		for(MultipartFile mf : files) {
			System.out.println(mf);
		}
		
		
		return "";
	}
}
