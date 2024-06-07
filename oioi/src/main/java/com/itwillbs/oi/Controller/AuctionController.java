package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuctionController {
	
	@GetMapping("auction")
	public String Auction() {
		return "auction/auction";
	}
	
	@GetMapping("auctionDetail")
	public String auctionDetail() {
		return "auction/auction_detail";
	}
	
	

}
