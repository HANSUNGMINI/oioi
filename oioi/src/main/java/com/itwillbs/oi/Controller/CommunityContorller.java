package com.itwillbs.oi.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
		
//		List<Map<String, String>> CM_CATEGORY = service.selectCM_CATEGORY();
		int next_cm_idx = service.selectCM_IDX();
		
		model.addAttribute("CM_IDX", next_cm_idx);
		model.addAttribute("CM_NICK", session.getAttribute("US_NICK"));
		
		return "community/board_write";
	}
	
	@PostMapping("communityWrite") // 게시글 등록
	public String communityWritePro(HttpSession session, Model model, @RequestParam Map<String, Object> map,  @RequestPart("CM_IMAGE")MultipartFile[] files) {
		
		// 로그인 확인
		String id = (String)session.getAttribute("US_ID");
		String nick = (String)session.getAttribute("US_NICK");
		map.put("CM_ID", id);
		map.put("CM_NICK", nick);
		
        if(!CheckAuthority.isUser(session, model)) {
			return "err/fail";
		}
        
        // 가상경로
    	String uploadDir = "/resources/upload";
    	
    	// 실제 경로
    	String saveDir = session.getServletContext().getRealPath(uploadDir);
    	
    	// 날짜별 하위 디렉토리를 분류
    	String subDir = "";
    	LocalDate today = LocalDate.now();
    	
    	String datePattern = "yyyy" + File.separator + "MM" + File.separator + "dd"; 
    	DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
    	
    	subDir = today.format(dtf);
    	
    	// 실제 경로에 날짜 경로 추가
    	saveDir += File.separator + subDir;
    	//		System.out.println("파일경로" + saveDir);
    	
    	// 디렉토리 생성
    	try {
    		Path path = Paths.get(saveDir); // 파라미터로 실제 업로드 경로 전달
    		Files.createDirectories(path); // 파라미터로 Path 객체 전달
    	} catch (IOException e) {
    		e.printStackTrace();
    	}
        
        if(!files[0].isEmpty()) {
        	
        	for(int i = 0 ; i < files.length; i++) {
        		MultipartFile file = files[i];
        		if(!file.isEmpty()) {
        			// 난수 생성
        			String uuid = UUID.randomUUID().toString();
        			// 난수 추가
        			String CM_IMAGE = uuid.substring(0,8) + "_" + file.getOriginalFilename();
        			
        			if(!file.getOriginalFilename().equals("")) {
        				map.put("CM_IMAGE" + (i+1), subDir + File.separator + CM_IMAGE);
        				try {
							file.transferTo(new File(saveDir, CM_IMAGE));
						} catch (IllegalStateException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
        			}
        		}
        	}
        	
        } else {
        	map.put("CM_IMAGE1", null);
        	map.put("CM_IMAGE2", null);
        	map.put("CM_IMAGE3", null);

    	}
    		
    		int insertCnt = service.insertBoard(map);
    		
    		if(insertCnt < 0) {
    			model.addAttribute("msg", "게시글 등록에 실패하셨습니다.");
    			return "err/fail";
    		}
    		
        	return "redirect:/boardDetail?CM_IDX=" + map.get("CM_IDX");

	}
	
	@GetMapping("boardDetail") // 게시글 상세보기
	public String boardDetail(Map<String, Object> map, @RequestParam int CM_IDX, Model model) {
		
		map = service.selectBoardDetail(CM_IDX);
		
		if(map == null) {
			model.addAttribute("msg", "게시글을 불러 올 수 없습니다.");
			
			return "err/fail";
		}
		
		
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
	
	@GetMapping("boardDelete")
	public String boardDelete(@RequestParam Map<String, Object> map, Model model) {
		
		int deleteCnt = service.deleteBoard(map);
		
		if(deleteCnt < 0) {
			model.addAttribute("msg", "게시글 삭제에 실패하였습니다. 다시 시도해 주세요.");
			return "err/fail";
		}
		
		return "redirect:/community";
	}
}


