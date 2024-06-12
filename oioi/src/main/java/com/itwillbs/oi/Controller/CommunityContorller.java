package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityContorller {
	@GetMapping("community")
	public String Community() {
		return "community/community_main";
	}
	
	@GetMapping("communityWrite")
	public String communityWrite() {
		
		return "community/board_write";
	}
	
	@GetMapping("boardDetail")
	public String boardDetail() {
		return "community/board_detail";
	}
	
	@GetMapping("boardModify")
	public String boardModify() {
		return "community/board_modify";
	}
}
