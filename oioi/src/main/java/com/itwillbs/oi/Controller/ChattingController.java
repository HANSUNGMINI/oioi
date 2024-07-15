package com.itwillbs.oi.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.handler.ReportHandler;
import com.itwillbs.oi.service.ChattingService;
import com.itwillbs.oi.service.OipayService;

@Controller
public class ChattingController {
	
	@Autowired
	private HttpSession session;

	@Autowired
	private ChattingService service;
	@Autowired
	private OipayService payService;
	
	@GetMapping("ChatList")
	public String goChatList(Model model, @RequestParam Map map) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			model.addAttribute("isClose", true);
			return "err/fail";
		}
		
		// [내 채팅 목록 가져오기]
		// System.out.println(map); --> 세션 아이디 들어있음
		
		// 1. 필요한 정보 가져오기 (from_id, to_id, cr_id, pd_idx)
		List<Map<String, Object>> chatInfo = service.getMyChatInfo(map); 
		
		String US_ID = (String) map.get("US_ID");
		
		// FROM_ID랑 TO_ID 설정하기
	    for (Map<String, Object> chat : chatInfo) {
	        // seller_id와 buyer_id를 추출합니다.
	        Object SELLER_ID = chat.get("SELLER_ID");
	        Object BUYER_ID = chat.get("BUYER_ID");

	        // 내가 판매자로 저장되어 있다면, TO_ID에 구매자 아이디
	        if (US_ID.equals(SELLER_ID)) {
	            chat.put("FROM_ID", SELLER_ID);
	            chat.put("TO_ID", BUYER_ID);
	        } else {
	        	chat.put("FROM_ID", BUYER_ID);
	        	chat.put("TO_ID", SELLER_ID);
	        }
	        
	    }
		
		// 2. 마지막 대화 및 시간 가져오기
		List<Map<String, Object>> chatList =  new LinkedList<>();
		List<Map<String, Object>> cnt = new LinkedList<>();
		
		for (Map<String, Object> chatContent : chatInfo) {
			
            // CR_ID 값을 가져오기
			String crId = (String) chatContent.get("CR_ID");
            map.put("crId", crId);
            Map<String, Object> list = service.getMyChatList(crId);

            // 안 읽은 메세지의 개수 가져오기
            List<Map<String, Object>> readInfo = service.getReadCount(map);
            
            int readCount = (readInfo == null) ? 0 : readInfo.size();
            
            // readCount를 chatList 항목에 포함
            Map<String, Object> chatEntry = new HashMap<>();
            chatEntry.put("list", list);
            chatEntry.put("readCount", readCount);
            
            chatList.add(chatEntry);
        }
		
		System.out.println("유저 채팅방 정보 >> " + chatInfo);
		System.out.println("대화 정보 >> " + chatList);

		
		// 두개 합치기
		List<Map<String, Object>> combinedList = new LinkedList<>();
		
		for (int i = 0; i < chatInfo.size() && i < chatList.size(); i++) {
		    Map<String, Object> combined = new HashMap<>();
		    combined.put("info", chatInfo.get(i));
		    combined.put("list", chatList.get(i));
		    
		    combinedList.add(combined);
		}

		System.out.println("합쳐진 정보 " + combinedList);
		model.addAttribute("combinedList", combinedList); // 총 합친 정보
		
		return "chatting/chatting_list";
	}
	
	@GetMapping("Chatting")
	public String goChatting(Model model, @RequestParam Map<String, Object> map) {
		
		System.out.println(map);
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			model.addAttribute("isClose", true);
			return "err/fail";
		}
		
		// 당연히 상대반은 TO_ID
		// 메세지 보내는 당시에 나(= 세션 아이디)는 FROM_ID
		
		String TO_ID = (String) map.get("TO_ID");
		String FROM_ID = (String) map.get("FROM_ID");
		String sId = (String) map.get("US_ID");
		int PD_IDX = Integer.parseInt((String)map.get("PD_IDX"));
		
		// 상품 정보 가져오기
		Map<String, String> pdInfo = service.getProductInfo(map);
		System.out.println("상품 정보 " + pdInfo);
		
		// 상대방 정보
		Map<String, String> otherInfo = service.getOtherInfo(map);
		System.out.println("상대방 정보 " + otherInfo);
		
		// 내 프로필 불러오기
		Map<String, String> myInfo = service.getMyInfo(map);
		System.out.println("내 정보 " + myInfo);
		
		// 채팅방 번호 가져오기
    	Map<String, Object> chatRoom = service.getChatRoom(TO_ID, FROM_ID, PD_IDX);
    	
    	if(chatRoom != null) {
    		map.put("CR_ID", chatRoom.get("CR_ID"));
    	}
    	
		// 채팅방의 구매자 및 판매자 가져오기
		Map<String, String> userRole = service.getUserRole(map);
		System.out.println("판매자 및 구매자 아이디 " + userRole);
		
		// 안 읽은 회수 차감
		int updateCnt = service.updateUnreadCnt(map);
		
		// 리뷰 카테고리 불러오기
		List<Map<String, String>> reviewMap = service.getReviewCategory();
		
		// 신고 카테고리 불러오기
		List<Map<String, String>> reportMap = service.getReportCategory();
		
		// 리뷰 내역 있는지 확인
		int existReview = service.selectReview(map);
		
		if(existReview < 1) {
			pdInfo.put("existReview", "no");
		}
		
		System.out.println("리뷰 내역 : " + existReview);
		
		// 운송장 등록 여부 가져오기 + 구매자 아이디 + 시간
		Map<String, Object> deliveryInfo = service.getDeliveryinfo(map);
		System.out.println("운송장 있는 지 -->" + deliveryInfo);
		
		if(deliveryInfo != null) {
			deliveryInfo.put("add", "ok");
			
			// 3일 지났는데 구매확정 안 누를 시, 자동 이체
			int status = service.eventDelivery(map);
			System.out.println("택배 status2인거 : " + status);
			
			if(status > 0) {
				pdInfo.put("BUYER_ID", userRole.get("BUYER_ID"));
				service.updateDelivery(pdInfo);
				payService.decidePerchase(pdInfo);

				model.addAttribute("msg", "구매확정 미등록으로 자동 이체 되셨습니다");
	        	return "err/success";
			}
		}
		
		System.out.println("아아ㅓ아어ㅏ러ㅣㅏㅇ니럼");
		
		// 거래 테이블에 내 정보가 있는지
		int tradeCnt = service.getMyTradeInfo(map);
		
		if(tradeCnt > 0) {
			model.addAttribute("tradeinfo", "ok"); // 거래 내역 존재 저장
		}
		
		// model에 담아서 정보 보내기
		model.addAttribute("pdInfo", pdInfo); // 상품 정보 
		model.addAttribute("myInfo", myInfo); // 내 프로필 
		model.addAttribute("otherInfo", otherInfo); // 상대방 프로필 
		model.addAttribute("userRole", userRole); // 판매자 구매자 정보
		
		model.addAttribute("deliveryInfo", deliveryInfo); // 운송장 등록 여부
		model.addAttribute("existReview", existReview); // 리뷰 썼는지
		
		model.addAttribute("reportMap", reportMap); // [공통코드] 신고 카테고리
		model.addAttribute("reviewMap", reviewMap); // [공통코드] 리뷰 카테고리
		
		return "chatting/chattingRoom";
	}
	
	// 채팅 가져오기
	@ResponseBody
	@GetMapping("getChatList")
	public List<Map<String, String>> getChatList(@RequestParam Map<String, Object> map, Model model) {
//		System.out.println("아무것도 없으? "+  map); // {TO_ID=siyun_9094, FROM_ID=soeunee1, CR_ID=61667950, US_ID=soeunee1, PD_IDX=80}
		List<Map<String, String>> chatMsg = service.getChatMsg(map);
		System.out.println("채팅방 메세지들 " + chatMsg);
		
		model.addAttribute("chatMsg", chatMsg);
		return chatMsg;
	}
	
	@PostMapping("report")
	public String reportUser(@RequestParam Map<String, String> map
							, @RequestParam("RP_IMG") MultipartFile[] files
							, Model model) {
		System.out.println("report(map) : " + map);
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
        	model.addAttribute("notify", true);
        	return "err/success";
        }
        
	}
	
	// 운송장 등록
	@PostMapping("delivery")
	public String goDelivery(@RequestParam Map<String, Object> map, Model model) {
		System.out.println("운송장 map : " + map);
		
		int registDelivery = service.registDelivery(map);
		
		 if(registDelivery < 1) {
        	model.addAttribute("msg","운송장 등록 실패하셨습니다. \\n 다시 시도해 주세요");
			return "err/fail";
        } else {
        	model.addAttribute("msg", "운송장 등록이 완료되었습니다");
        	return "err/success";
        }
		
	}
	
	// 판매 완료
	@GetMapping("tradeDecide")
	public String goTradeDecide(@RequestParam Map<String, String> map, Model model) {
//		System.out.println("판매완료 map : " + map);
		System.out.println(map);
		int PD_IDX = Integer.parseInt(map.get("PD_IDX"));
		Map<String, Object> product = payService.selectTradePDInfo(PD_IDX);
		map.put("PD_PRICE", product.get("PD_PRICE").toString());
		payService.decidePerchase(map);
		
		System.out.println("여기오나ㅣ");
		model.addAttribute("msg", "송금이 완료되었습니다");
		model.addAttribute("reload", true);
    	return "err/success";
	}
	
	// 리뷰 작성
	@PostMapping("reviewWrite")
	public String goReviewWrite(@RequestParam Map<String, String> map, Model model) {
		System.out.println("리뷰 작성 map : " + map);

		int successCnt = service.insertReview(map);
		
		if(successCnt < 1) {
        	model.addAttribute("msg","리뷰 작성 실패하셨습니다. \\n 다시 시도해 주세요");
			return "err/fail";
        } else {
        	
        	String Rvcategories = map.get("RV_CATEGORYS");
            List<String> categories = Arrays.asList(Rvcategories.split("/"));
            int star = Integer.parseInt(map.get("RV_STAR"));
            
            double freshness = calculateFreshness(star, categories);
//            System.out.println("+++++++++++++++++++++++++++++++++++++" + freshness);
            map.put("freshness", String.valueOf(freshness));
            service.updateFreshness(map);
        	
        	model.addAttribute("msg", "리뷰 작성 완료되었습니다");
        	return "err/success";
        }
	}
	
	// 신선도 계산
	private double calculateFreshness(int rating, List<String> categories) {
        Map<String, Double> categoryWeights = new HashMap<>();
        categoryWeights.put("RVC01", 0.2);
        categoryWeights.put("RVC02", 0.1);
        categoryWeights.put("RVC03", 0.2);
        categoryWeights.put("RVC04", 0.1);
        categoryWeights.put("RVC05", -0.3);
        categoryWeights.put("RVC06", -0.3);
        categoryWeights.put("RVC07", -0.4);

        double baseChange = (rating - 3) * 0.2; // 기본 별점 변화, 3점은 변화 없음
        double categoryChange = categories.stream()
                                          .mapToDouble(categoryWeights::get)
                                          .sum();
        return baseChange + categoryChange;
    }
	
}
