package com.itwillbs.oi.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
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
	
	@ResponseBody
	@GetMapping("selectBoard")
	public JsonObject selectBoard(@RequestParam String type, Map<String, Object> map) {
		JsonObject response = new JsonObject();
		
		map.put("type", type);
		
		System.out.println(map);
		List<Map<String, Object>> boardList = service.selectBoardList(map);
		
		System.out.println("boardList : " + boardList);
		
		JsonArray boardJson = new JsonArray();
		
		for(Map<String, Object> board : boardList) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("CM_title", board.get("CM_title").toString());
			jsonObject.addProperty("CM_category", board.get("CM_category").toString());
			jsonObject.addProperty("CM_id", board.get("CM_id").toString());
			jsonObject.addProperty("CM_reg_date", board.get("CM_reg_date").toString());
			jsonObject.addProperty("count", board.get("count").toString());
			
			boardJson.add(jsonObject);
		}
		
		response.add("boardJson", boardJson);
		System.out.println("boardJson :" + boardJson);
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
