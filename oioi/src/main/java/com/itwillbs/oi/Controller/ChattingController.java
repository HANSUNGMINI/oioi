package com.itwillbs.oi.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.handler.ReportHandler;
import com.itwillbs.oi.service.ChattingService;

@Controller
public class ChattingController {
	
	@Autowired
	private HttpSession session;

	@Autowired
	private ChattingService service;
	
	@GetMapping("ChatList")
	public String goChatList(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			model.addAttribute("isClose", true);
			return "err/fail";
		}
		
		return "chatting/chatting_list";
	}
	
	@GetMapping("Chatting")
	public String goChatting(Model model, @RequestParam Map<String, String> map) {
		
		System.out.println(">>>> map " + map);
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			model.addAttribute("isClose", true);
			return "err/fail";
		}
		
		// 닉네임 및 상품 제목 가져오기
		Map<String, String> info = service.getUserInfo(map);
		System.out.println(">>>>>> " + info);
		
		// 채팅 목록 불러오기 
		
		// 리뷰 카테고리 불러오기
		List<Map<String, String>> reviewMap = service.getReviewCategory();
		
		// 신고 카테고리 불러오기
		List<Map<String, String>> reportMap = service.getReportCategory();

		// model에 담아서 정보 보내기
		model.addAttribute("info", info); // 상대방 닉네임 + 상품 정보
		model.addAttribute("reportMap", reportMap); // [공통코드] 신고 카테고리
		model.addAttribute("reviewMap", reviewMap); // [공통코드] 리뷰 카테고리
		
		return "chatting/chattingRoom";
	}
	
	@PostMapping("report")
	public String reportUser(@RequestParam Map<String, String> map
							, @RequestParam("RP_IMG") MultipartFile[] files
							, Model model) {
		
//		ReportHandler report = new ReportHandler();
//		int insertCount = report.reportProcess(map, files);
		
		
		// [파일 업로드 처리] ---------------------------------------------------------
			System.out.println(">>>>>" + files);
				String uploadDir = "/resources/upload";
				String saveDir = session.getServletContext().getRealPath(uploadDir);
			    System.out.println("saveDir" + saveDir);
			    String subDir = "";
			    
			    LocalDate today = LocalDate.now();
//					    LocalDate today = LocalDate.of(2024, 6, 21);
			    String datePattern = "yyyy/MM/dd";
			    DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
			    subDir = today.format(dtf);
			    saveDir += "/" + subDir;
			    
			    try {
		            Path path = Paths.get(saveDir);
		            Files.createDirectories(path);
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
			    
//				Map<String, String> fileMap = new HashMap<>();
		        for (int i = 0; i < files.length && i < 2; i++) {
		            MultipartFile file = files[i];
		            if (!file.isEmpty()) {
		            	
		                String uuid = UUID.randomUUID().toString();
		                String fileName = uuid.substring(0, 8) + "_" + file.getOriginalFilename();
		                
		                try {
		                    file.transferTo(new File(saveDir, fileName));
		                    map.put("RP_IMG" + (i+1), subDir + File.separator + fileName);
		                    
		                } catch (IllegalStateException | IOException e) {
		                    e.printStackTrace();
		                }
		            } else {
		            	map.put("RP_IMG" + (i+1), null);
		            }
		            
		        }
		        
		        // 신고자 아이디 및 피신고자 아이디 저장
		        map.put("FROM_US_ID", (String)session.getAttribute("US_ID"));
		        System.out.println("이미지 파일 저장 후 "+ map);
		        
		        // DB 저장하기
		        int insertCount = service.insertReport(map);
				
        if(insertCount < 1) {
        	model.addAttribute("msg","신고 접수 실패하셨습니다. \\n 다시 시도해 주세요");
			return "err/fail";
        } else {
        	model.addAttribute("msg", "신고 접수 완료되었습니다");
        	return "err/success";
        }
        
	}
	
}
