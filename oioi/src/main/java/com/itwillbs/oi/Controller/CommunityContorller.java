package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityContorller {
	@GetMapping("community")
	public String goCommunity() {
		return "community/community_main";
	}
	
	@GetMapping("communityWrite")
	public String communityWrite() {
		
		return "community/board_write";
	}
}
