package com.itwillbs.oi.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.CommunityService;

@Controller
public class CommunityContorller {
	@Autowired
	private CommunityService service;
	
	
	@GetMapping("community")
	public String Community() {
		
		return "community/community_main";
	}
	
	@ResponseBody
	@GetMapping("selectBoard") // 게시글 리스트 불러오기
	public JsonObject selectBoard(@RequestParam String type, Map<String, Object> map) {
		JsonObject response = new JsonObject();
		
		map.put("type", type);
//		System.out.println(map);
		
		List<Map<String, Object>> boardList = service.selectBoardList(map);
//		System.out.println("boardList : " + boardList);
		
		JsonArray boardJson = new JsonArray();
		
		for(Map<String, Object> board : boardList) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("CM_IDX", board.get("CM_IDX").toString());
			jsonObject.addProperty("CM_TITLE", board.get("CM_TITLE").toString());
			jsonObject.addProperty("CM_CATEGORY", board.get("CM_CATEGORY").toString());
			jsonObject.addProperty("CM_NICK", board.get("CM_NICK").toString());
			jsonObject.addProperty("CM_REG_DATE", board.get("CM_REG_DATE").toString());
			jsonObject.addProperty("count", board.get("count").toString());
			
			boardJson.add(jsonObject);
		}
		
		response.add("boardJson", boardJson);
//		System.out.println("boardJson :" + boardJson);
		
		return response;
	}
	
	@GetMapping("communityWrite") // 게시글 작성 페이지 이동
	public String communityWrite(HttpSession session, Model model) {
		
//		if(session.getAttribute("US_ID") == null) {
//			model.addAttribute("msg", "로그인 후 이용이 가능합니다.");
//			
//			return "err/fail";
//		}
		
//		if(!CheckAuthority.isUser(session, model)) {
//			return "err/fail";
//		}
		
		if(!CheckAuthority.isUser(session, model, CheckAuthority.LOGIN)) {
			return "err/fail";
		}
		
		String nickName = service.selectNickName(session.getAttribute("US_ID"));
//		List<Map<String, String>> CM_CATEGORY = service.selectCM_CATEGORY();
		
		model.addAttribute("CM_NICK", nickName);
		
		return "community/board_write";
	}
	
	@PostMapping("communityWrite") // 게시글 등록
	public String communityWritePro(Model model, @RequestParam Map<String, Object> map,  @RequestPart("cm_image_form")MultipartFile[] files) {
		
		
		Map<String, Object> uploadedFiles = new HashMap<String, Object>();
        for (MultipartFile file : files) {
        	uploadedFiles.put(file.getOriginalFilename(), file);
        }
		
        map.put("uploadedFiles", uploadedFiles);
        
        System.out.println(map);
////		int insertCnt = service.insertBoard(map);
//		
//		if(insertCnt < 0) {
//			model.addAttribute("msg", "게시글 등록에 실패하셨습니다.");
//			return "err/fail";
//		}
//		
		return "";
	}
	
	@GetMapping("boardDetail") // 게시글 상세보기
	public String boardDetail(Map<String, Object> map, @RequestParam int CM_IDX, Model model) {
		
		map = service.selectBoardDetail(CM_IDX);
		
		if(map == null) {
			model.addAttribute("msg", "게시글을 불러 올 수 없습니다.");
			
			return "err/fail";
		}
		
		System.out.println(map);
		
		model.addAttribute("boardDetail", map);
		
		return "community/board_detail";
	}
	
	@GetMapping("boardModify") // 게시글 수정 페이지 이동
	public String boardModify() {
		return "community/board_modify";
	}
	
	@PostMapping("boardModify") // 게시글 수정
	public String boardModifyPRo() {
		
		return "boardDetail";
	}
}
