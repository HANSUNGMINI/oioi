package com.itwillbs.oi.Controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.StoreService;
import com.itwillbs.oi.service.UserService;

@Controller
public class MyStoreController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private StoreService storeService;
	
	@GetMapping("myStore")
	public String myStore(@RequestParam Map<String, Object>map,Model model) {
		System.out.println("여기에는 뭐가 있을까요 ? " + map);
		System.out.println(map.get("userId"));
		
		// 유저가 아님
//		if(!CheckAuthority.isUser(session, model)) {
//			System.out.println(model.getAttribute("msg"));
//			System.out.println(model.getAttribute("targetURL"));
//			return "err/fail";
//		}
		
//		String id = (String)session.getAttribute("US_ID");
		String userId = (String)map.get("userId");
		
		Map<String, String> user = userService.selectMyUser(userId);
		if (user == null ) {
			model.addAttribute("msg", "존재하지 않는 회원입니다");
			return "err/fail";
		}
		
        // 공통 코드를 조회하여 모델에 추가
        List<Map<String, String>> code = storeService.getCommonCode("PD_STATUS");
		List<Map<String, Object>> myPD = storeService.selectMyPd(userId);
		System.out.println(myPD);
		// 상품 목록을 역순으로 정렬
		Collections.reverse(myPD);
		
		// 상품 목록을 스트림으로 처리하여 각 상품의 등록 시간을 현재 시간과 비교한 결과를 추가
        List<Map<String, Object>> productList = myPD.stream()
        	.map(product -> {
        		
        	// new
        	String dateString = (String)product.get("PD_REG_DATE"); // 변환할 문자열 날짜
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
            LocalDateTime regDate = LocalDateTime.parse(dateString, formatter);
//            LocalDateTime regDate = (LocalDateTime) product.get("PD_REG_DATE");
            // new
            
            String timeAgo = dateTimeAgo(regDate);
            product.put("timeAgo", timeAgo);
//            System.out.println("각 상품들의 정보 : " + product);
            return product;
        }).collect(Collectors.toList());
		
		model.addAttribute("user", user);
		model.addAttribute("myPD", productList);
		
		return "myStore/my_store";
	}
	
	
	@GetMapping("editStore")
	public String editStore(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		String id = (String)session.getAttribute("US_ID");
		Map<String, String> user = userService.selectMyUser(id);
		List<Map<String, Object>> myPD = storeService.selectMyPd(id);
		
        // 공통 코드를 조회하여 모델에 추가
        List<Map<String, String>> code = storeService.getCommonCode("PD_STATUS");
        
        model.addAttribute("code", code);
		model.addAttribute("user", user);
		model.addAttribute("myPD", myPD);
		
		return "myStore/edit_my_store";
	}
	
	
	// 상품 상태 업데이트
	@ResponseBody
	@PostMapping("updatePDS")
	public ResponseEntity<?> updateProductStatus(@RequestParam Map<String, Object> params) {
	    String pdId = (String) params.get("pdId");
	    String status = (String) params.get("status");
	    
//	    System.out.println("IDX : " + pdId);
//	    System.out.println("status : " + status);
	    
	    boolean result = storeService.updatePDStatus(pdId, status);
	    
	    if (result) {
	        return ResponseEntity.ok().build();
	    } else {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update product status");
	    }
	}
	
	
	
	
	
	

    private String dateTimeAgo(LocalDateTime regDate) {
        LocalDateTime now = LocalDateTime.now(ZoneId.systemDefault());
        long minutes = ChronoUnit.MINUTES.between(regDate, now);
        long hours = ChronoUnit.HOURS.between(regDate, now);
        long days = ChronoUnit.DAYS.between(regDate, now);
        long months = ChronoUnit.MONTHS.between(regDate, now);

        if (minutes < 60) {
            return minutes + " 분 전";
        } else if (hours < 24) {
            return hours + " 시간 전";
        } else if (days < 30) {
            return days + " 일 전";
        } else {
            return months + " 달 전";
        }
    }
}
