package com.itwillbs.oi.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.MailService;
import com.itwillbs.oi.service.UserService;

@Controller
public class MyPageController {
    
    @Autowired
    private HttpSession session;
    
    @Autowired
    private UserService service;

    @Autowired
    private MailService mailService;

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
    
    //  회원 정보 수정
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

        model.addAttribute("user", user);
        
        return "mypage/mypage_user";
    }
    
    @PostMapping("checkNickname")
    @ResponseBody
    public Map<String, Object> checkNickname(@RequestParam String nickname) {
        boolean isValidNick = service.isNicknameAvailable(nickname);
        return Map.of("isValidNick", isValidNick);
    }
    
    @PostMapping("changePassword")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> changePassword(@RequestBody Map<String, String> passwordMap, BCryptPasswordEncoder passwordEncoder) {
        String currentPassword = passwordMap.get("currentPassword");
        String newPassword = passwordMap.get("newPassword");
        String userId = (String) session.getAttribute("US_ID");

        // 현재 비밀번호와 새로운 비밀번호가 동일한지 확인
        if (currentPassword.equals(newPassword)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "message", "새 비밀번호는 현재 비밀번호와 달라야 합니다."));
        }

        // 현재 비밀번호가 맞는지 확인
        boolean isSameAsCurrent = service.isSameAsCurrentPassword(userId, currentPassword, passwordEncoder);
        if (!isSameAsCurrent) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "message", "현재 비밀번호가 일치하지 않습니다."));
        }

        // 새로운 비밀번호 암호화
        String encodedNewPassword = passwordEncoder.encode(newPassword);

        // 비밀번호 변경
        boolean isPasswordChanged = service.changePassword(userId, encodedNewPassword);
        if (isPasswordChanged) {
            return ResponseEntity.ok(Map.of("success", true, "message", "비밀번호가 성공적으로 변경되었습니다."));
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "message", "비밀번호 변경 실패!"));
        }
    }
    
    @PostMapping("updateField")
    @ResponseBody
    public Map<String, Object> updateField(@RequestParam String field, @RequestParam String value) {
        String id = (String) session.getAttribute("US_ID");
        
        System.out.println(value);
        boolean updateResult = service.updateField(id, field, value);

        if (updateResult) {
            if(service.selectStatus(id).equals("US03")) {
                service.updateStatus(id);
            }
            return Map.of("result", true);
        } else {
            return Map.of("result", false, "message", "필드 변경 실패!");
        }
    }
    
    @ResponseBody
    @PostMapping("sendAuthMail")
    public ResponseEntity<Map<String, Object>> sendAuthMail(@RequestBody Map<String, Object> userMap) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("여기에 뭐가 있냐" + userMap);
            Map<String, Object> mailAuthInfoMap = mailService.sendChangeEmailAuthMail(userMap);
            response.put("success", true);
            response.put("auth_code", mailAuthInfoMap.get("auth_code"));
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "인증메일 발송에 실패했습니다. 다시 시도해주세요.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @ResponseBody
    @PostMapping("verifyEmailAuthCode")
    public ResponseEntity<Map<String, Object>> verifyEmailAuthCode(@RequestBody Map<String, Object> request) {
        String email = (String) request.get("email");
        String authCode = (String) request.get("authCode");
        String storedAuthCode = mailService.getAuthCode(email);

        if (storedAuthCode != null && storedAuthCode.equals(authCode)) {
            Map<String, Object> updateFieldResult = updateField("email", email);
            if ((boolean) updateFieldResult.get("result")) {
                return ResponseEntity.ok(Map.of("success", true));
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "message", "이메일 변경 실패!"));
            }
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("success", false, "message", "인증 코드가 일치하지 않습니다."));
        }
    }

    @PutMapping("mypageReload")
    public void reloadUser(HttpSession session, Model model) {
        Map<String, String> user = service.selectMyUser((String)session.getAttribute("US_ID"));
        session.setAttribute("US_ID", user.get("US_ID"));
        session.setAttribute("US_EMAIL", user.get("US_EMAIL"));
        session.setAttribute("US_NICK", user.get("US_NICK"));
        session.setAttribute("US_STATUS", user.get("US_STATUS"));
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

        if(!CheckAuthority.isUser(session, model)) {
            System.out.println(model.getAttribute("msg"));
            System.out.println(model.getAttribute("targetURL"));
            return "err/fail";
        }
        
        List<Map<String, Object>> auctionList = service.getAuctionList(id);

        System.out.println("경매 모든 정보 : " + auctionList);
        
        model.addAttribute("auctionList", auctionList);
        
        return "mypage/my_auction";
    }
    
    @PostMapping("userWithdraw")
    @ResponseBody
    public Map<String, Object> userWithdraw(@RequestParam("password") String password, HttpSession session, Model model) {
        // 세션에서 사용자 ID를 가져옴
        String userId = (String) session.getAttribute("US_ID");
        System.out.println(" 회원탈퇴의 아이디: " + userId);
        
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        Map<String, Object> response = new HashMap<>();

        // 비밀번호 검증
        if (service.checkPassword(userId, password, passwordEncoder)) {
            // 사용자 탈퇴 처리
            service.withdrawUser(userId);

            // 세션 무효화
            session.invalidate();

            response.put("success", true);
            response.put("message", "회원 탈퇴가 성공적으로 완료되었습니다.");
        } else {
            // 비밀번호가 틀린 경우
            response.put("success", false);
            response.put("message", "비밀번호가 일치하지 않습니다.");
        }

        return response;
    }
}
