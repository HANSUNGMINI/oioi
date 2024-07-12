package com.itwillbs.oi.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.UserService;

@Controller
public class MyPageController {
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private UserService service;
	
	@GetMapping("myPage")
	public String myPage(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model, CheckAuthority.LOGIN)) {
			return "err/fail";
		}
		
		String id = (String)session.getAttribute("US_ID");
		
		Map<String, String> user = service.selectMyUser(id);
		
		model.addAttribute("user", user);

		return "mypage/mypage";
	}
	
	// 	회원 정보 수정
	@GetMapping("userUpdate")
	public String userUpdate(Model model) {
		
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
		String id = (String)session.getAttribute("US_ID");
		Map<String, String> user = service.selectMyUser(id);
		
		// 주소 결합
//		String ad1 = user.get("US_ADDRESS1"); 
//		String ad2 = user.get("US_ADDRESS2");
//		String ad = ad1 + ", " + ad2;
//		user.put("ad", ad);

		model.addAttribute("user", user);
		
		return "mypage/mypage_user";
	}
	
    @PostMapping("checkNickname")
    @ResponseBody
    public Map<String, Object> checkNickname(@RequestParam String nickname) {
//    	Map<String, Object> result = new HashMap<String, Object>();
    	
        boolean isValidNick = service.isNicknameAvailable(nickname);
        return Map.of("isValidNick", isValidNick);
    }
	
    // 필드를 업데이트하는 메소드
    @PostMapping("updateField")
    @ResponseBody
    public Map<String, Object> updateField(@RequestParam String field, @RequestParam String value) {
        // 세션에서 사용자 ID를 가져옴
        String id = (String) session.getAttribute("US_ID");
        
        System.out.println(value);
        // 서비스 호출을 통해 필드 업데이트
        boolean updateResult = service.updateField(id, field, value);

        // 업데이트 결과에 따라 JSON 형식의 응답을 반환
        if (updateResult) {
        	if(service.selectStatus(id).equals("US03")) {
        		service.updateStatus(id);
        	}
            return Map.of("result", true);
        } else {
            return Map.of("result", false, "message", "필드 변경 실패!");
        }
    }
	
    @GetMapping("userLogout")
    public String userLogout() {
    	session.invalidate();
    	
    	return "redirect:/";
    }
    
    @GetMapping("myTrade")
    public String myTrade(Model model) {
        String id = (String) session.getAttribute("US_ID");

        System.out.println(id);

        // 유저가 아님
        if (!CheckAuthority.isUser(session, model)) {
            System.out.println(model.getAttribute("msg"));
            System.out.println(model.getAttribute("targetURL"));
            return "err/fail";
        }

        List<Map<String, Object>> tradeList = service.getTradeList(id);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        List<Map<String, Object>> purchaseList = tradeList.stream()
            .filter(trade -> trade.get("TD_BUYER_ID").equals(id))
            .peek(trade -> trade.put("TD_TIME", convertStringToDate((String) trade.get("TD_TIME"), dateFormat)))
            .collect(Collectors.toList());

        List<Map<String, Object>> saleList = tradeList.stream()
            .filter(trade -> trade.get("TD_SELLER_ID").equals(id))
            .peek(trade -> trade.put("TD_TIME", convertStringToDate((String) trade.get("TD_TIME"), dateFormat)))
            .collect(Collectors.toList());

        System.out.println("구매 정보 : @@@@@@@@@@@@ " + purchaseList);
        System.out.println("판매 정보 : @@@@@@@@@@@@ " + saleList);

        model.addAttribute("purchaseList", purchaseList);
        model.addAttribute("saleList", saleList);

        return "mypage/my_trade";
    }

    private Date convertStringToDate(String dateString, SimpleDateFormat dateFormat) {
        try {
            return dateFormat.parse(dateString);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    
    @GetMapping("myAuction")
    public String myAuction(Model model) {
    	
		String id = (String)session.getAttribute("US_ID");

//    	System.out.println("아이디는 :? " + id);
    	
		// 유저가 아님
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.getAttribute("msg"));
			System.out.println(model.getAttribute("targetURL"));
			return "err/fail";
		}
		
        // 경매 데이터 가져오기
        List<Map<String, Object>> auctionList = service.getAuctionList(id);

        System.out.println("경매 모든 정보 : " + auctionList);
        
        // 모델에 경매 데이터 추가
        model.addAttribute("auctionList", auctionList);
		
        
    	return "mypage/my_auction";
    }
	
	
	
}
