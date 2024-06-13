package com.itwillbs.oi.Controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.oi.service.AuctionService;

@Controller
public class AuctionController {
	
	@Autowired
	private AuctionService service;
	
	
	@GetMapping("auction")
	public String Auction() {
		return "auction/auction";
	}
	
	@GetMapping("auctionDetail")
	public String auctionDetail() {
		return "auction/auction_detail";
	}
	
	@GetMapping("auctionRegist")
	public String auctionRegist(Model model) {
		System.out.println("auctionRegist - controller");
		List<Map<String, String>> cate1 = service.getCategory1();
		
		model.addAttribute("cate1", cate1);
		
		
		return "auction/auction_regist";
	}
	

}
