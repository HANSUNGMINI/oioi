package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.google.gson.JsonObject;
import com.itwillbs.oi.service.CommunityService;

import retrofit2.http.GET;

@Controller
public class CommunityContorller {
	@Autowired
	private CommunityService service;
	
	
	@GetMapping("community")
	public String Community() {
		
		return "community/community_main";
	}
	
	@GetMapping("selectBoard")
	public JsonObject selectBoard() {
		JsonObject response = new JsonObject();
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> boardList = service.selectBoardList(map);
		
		System.out.println("dddddddddddddddddddddddddd" + boardList);
		
		for(Map<String, Object> board : boardList) {
			
			response.addProperty("CM_title", board.get("CM_title").toString());
			response.addProperty("CM_category", board.get("CM_category").toString());
			response.addProperty("CM_id", board.get("CM_id").toString());
			response.addProperty("CM_reg_date", board.get("CM_reg_date").toString());
		}
		
		return response;
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
