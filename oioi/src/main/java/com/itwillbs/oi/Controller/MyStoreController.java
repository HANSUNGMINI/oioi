package com.itwillbs.oi.Controller;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
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
	public String myStore(@RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "3") int pageSize, Model model) {
	    // 유저가 아님
	    if(!CheckAuthority.isUser(session, model)) {
	        System.out.println(model.getAttribute("msg"));
	        System.out.println(model.getAttribute("targetURL"));
	        return "err/fail";
	    }
	    
	    String id = (String)session.getAttribute("US_ID");
	    Map<String, String> user = userService.selectMyUser(id);
	    List<Map<String, Object>> myPD = storeService.selectMyPd(id);
	    PageInfo<Map<String, Object>> pageInfo = storeService.pageMyPd(id, pageNum, pageSize);
	    
	    // 상품 목록을 역순으로 정렬
	    Collections.reverse(myPD);
	    
	    // 상품 목록을 스트림으로 처리하여 각 상품의 등록 시간을 현재 시간과 비교한 결과를 추가
	    List<Map<String, Object>> productList = myPD.stream()
	        .map(product -> {
	        LocalDateTime regDate = (LocalDateTime) product.get("PD_REG_DATE");
	        String timeAgo = dateTimeAgo(regDate);
	        product.put("timeAgo", timeAgo);
	        return product;
	    }).collect(Collectors.toList());
	    
	    model.addAttribute("user", user);
	    model.addAttribute("myPD", productList);
	    model.addAttribute("pageInfo", pageInfo);
	    
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
		
		model.addAttribute("user", user);
		model.addAttribute("myPD", myPD);
		
		return "myStore/edit_my_store";
	}
	
	@PostMapping("updatePdStatus")
	@ResponseBody
	public Map<String, String> updatePdStatus(@RequestBody Map<String, Object> payload) {
		int pdId = (int) payload.get("id");
		String newStatus = (String) payload.get("status");
		
		storeService.updatePdStatus(pdId, newStatus);
		
		Map<String, String> response = new HashMap<>();
		response.put("message", "Success");
		return response;
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
