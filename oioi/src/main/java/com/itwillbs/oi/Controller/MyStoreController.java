package com.itwillbs.oi.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.oi.handler.CheckAuthority;
import com.itwillbs.oi.service.AuctionService;
import com.itwillbs.oi.service.StoreService;
import com.itwillbs.oi.service.TradeService;
import com.itwillbs.oi.service.UserService;

@Controller
public class MyStoreController {

    @Autowired
    HttpSession session;
    
	String uploadDir = "/resources/upload";
	
	@Autowired 
	private TradeService tradeService;
	
	@Autowired
	private AuctionService Auctionservice;

    @Autowired
    private UserService userService;

    @Autowired
    private StoreService storeService;

    @GetMapping("myStore")
    public String myStore(@RequestParam Map<String, Object> map, Model model, 
    		@CookieValue(value = "storeVisit", defaultValue = "false") String storeVisit,
    		HttpServletResponse response) {
        System.out.println("여기에는 뭐가 있을까요 ? " + map);
        System.out.println(map.get("userId"));

        // 유저가 아님
        // if(!CheckAuthority.isUser(session, model)) {
        //     System.out.println(model.getAttribute("msg"));
        //     System.out.println(model.getAttribute("targetURL"));
        //     return "err/fail";
        // }

        // String id = (String)session.getAttribute("US_ID");
        String userId = (String) map.get("userId");

        Map<String, String> user = userService.selectMyUser(userId);
        if (user == null) {
            model.addAttribute("msg", "존재하지 않는 회원입니다");
            return "err/fail";
        }
        
        // 방문자 수 증가
        if (!storeVisit.equals("true")) {
        	storeService.VisitCount(userId);
            Cookie cookie = new Cookie("storeVisit", "true");
            cookie.setMaxAge(60 * 60 * 24); // 쿠키 유효기간 1시간
            response.addCookie(cookie);
        }
        int salesCount = storeService.getSalesCount(userId);
        model.addAttribute("salesCount", salesCount);
        
        int visitCount = storeService.getVisitCount(userId);
        
        String openDate = user.get("US_REG_DATE");
        System.out.println("시작 날짜 : <<<<<<<<" + openDate);
        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime userOpenDate = LocalDateTime.parse(openDate, formatter1);
        String open = dateTimeAgo(userOpenDate);
        user.put("open", open);
        model.addAttribute("visitCount", visitCount);
        
        // 공통 코드를 조회하여 모델에 추가
        List<Map<String, String>> code = storeService.getCommonCode("PD_STATUS");
        List<Map<String, Object>> myPD = storeService.selectMyPd(userId);
        System.out.println("상품" + myPD);
        // 상품 목록을 역순으로 정렬
        Collections.reverse(myPD);

        // 상품 목록을 스트림으로 처리하여 각 상품의 등록 시간을 현재 시간과 비교한 결과를 추가
        List<Map<String, Object>> productList = myPD.stream()
                .map(product -> {
                    // new
                    String dateString = (String) product.get("PD_REG_DATE"); // 변환할 문자열 날짜
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                    LocalDateTime regDate = LocalDateTime.parse(dateString, formatter);
                    // LocalDateTime regDate = (LocalDateTime) product.get("PD_REG_DATE");
                    // new

                    String timeAgo = dateTimeAgo(regDate);
                    product.put("timeAgo", timeAgo);
                    // System.out.println("각 상품들의 정보 : " + product);
                    return product;
                }).collect(Collectors.toList());
        
        model.addAttribute("user", user);
        model.addAttribute("myPD", productList);

        return "myStore/my_store";
    }

    @GetMapping("editStore")
    public String editStore(Model model) {
        // 유저가 아님
        if (!CheckAuthority.isUser(session, model)) {
            System.out.println(model.getAttribute("msg"));
            System.out.println(model.getAttribute("targetURL"));
            return "err/fail";
        }

        String id = (String) session.getAttribute("US_ID");
        Map<String, String> user = userService.selectMyUser(id);
        List<Map<String, Object>> myPD = storeService.selectMyPd(id);

        // 공통 코드를 조회하여 모델에 추가
        List<Map<String, String>> code = storeService.getCommonCode("PD_STATUS");

        model.addAttribute("code", code);
        model.addAttribute("user", user);
        model.addAttribute("myPD", myPD);

        return "myStore/edit_my_store";
    }

    @PostMapping("/uploadProfilePic")
    @ResponseBody
    public Map<String, Object> uploadProfilePic(@RequestParam("profilePic") MultipartFile profilePic) {
        Map<String, Object> response = new HashMap<>();
        if (profilePic.isEmpty()) {
            response.put("success", false);
            response.put("message", "파일이 비어 있습니다.");
            return response;
        }

        String uploadDir = "/resources/upload/profile_pics";
        String saveDir = session.getServletContext().getRealPath(uploadDir);

        String uuid = UUID.randomUUID().toString();
        String fileName = uuid.substring(0, 8) + "_" + profilePic.getOriginalFilename();
        File saveFile = new File(saveDir, fileName);

        try {
            Path path = Paths.get(saveDir);
            if (!Files.exists(path)) {
                Files.createDirectories(path);
            }
            profilePic.transferTo(saveFile);

            String fileUrl = session.getServletContext().getContextPath() + uploadDir + "/" + fileName;
            String userId = (String) session.getAttribute("US_ID");

            // DB에 저장하는 로직 추가
            boolean isUpdated = userService.updateUserProfile(userId, fileUrl);
            if (isUpdated) {
                response.put("success", true);
                response.put("imageUrl", fileUrl);
            } else {
                response.put("success", false);
                response.put("message", "DB 업데이트 중 오류가 발생했습니다.");
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "파일 업로드 중 오류가 발생했습니다.");
        }

        return response;
    }
    
    
    @PostMapping("editText")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> saveIntro(@RequestParam("editText") String editText) {
        String userId = (String) session.getAttribute("US_ID");

        Map<String, Object> response = new HashMap<>();

        // 유저 아이디가 없으면 에러 반환
        if (userId == null) {
            System.out.println("로그인이 필요합니다.");
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        // 소개글 저장 로직
        boolean isUpdated = userService.updateText(userId, editText);
        System.out.println("결과 " + isUpdated);
        if (isUpdated) {
            response.put("success", true);
            return ResponseEntity.ok(response);
        } else {
            System.out.println("소개글 저장 중 오류가 발생했습니다.");
            response.put("success", false);
            response.put("message", "소개글 저장 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    
    
    
    
    // 상품 수정
    
    @GetMapping("productModify")
    public String productModify(@RequestParam Map<String, Object> map, Model model) {
    	System.out.println("상품 수정 컨트롤러 : " + map.get("PD_IDX"));
    	int pdIdx = Integer.parseInt((String) map.get("PD_IDX"));
        // 상품 정보를 DB에서 가져오기
        Map<String, Object> product = storeService.getProductById(pdIdx);

        if (product == null) {
            model.addAttribute("msg", "존재하지 않는 상품입니다.");
            return "err/fail";
        }
        
     // 카테고리 대분류
     		List<Map<String, String>> cate1 = Auctionservice.getCategory1();
     		model.addAttribute("cate1", cate1);
     		
     		//중분류
     		List<Map<String, String>> cate2 = Auctionservice.getCategory2();
//     		System.out.println("cate2 : " + cate2);
     		JsonArray jCate2 = new JsonArray();
     		for(Map<String, String> c2 : cate2) {
     			JsonObject jo = new JsonObject();
     			jo.addProperty("CTG_CODE", c2.get("CTG_CODE"));
     			jo.addProperty("CTG_NAME", c2.get("CTG_NAME"));
     			jo.addProperty("UP_CTG_CODE", c2.get("UP_CTG_CODE"));
     			jCate2.add(jo);
     		}
     		model.addAttribute("cate2", jCate2);
     		
     		//소분류
     		List<Map<String, String>> cate3 = Auctionservice.getCategory3();
//     		System.out.println("cate3 : " + cate3);
     		JsonArray jCate3 = new JsonArray();
     		for(Map<String, String> c3 : cate3) {
     			JsonObject jo3 = new JsonObject();
     			jo3.addProperty("CTG_CODE", c3.get("CTG_CODE"));
     			jo3.addProperty("CTG_NAME", c3.get("CTG_NAME"));
     			jo3.addProperty("UP_CTG_CODE", c3.get("UP_CTG_CODE"));
     			jCate3.add(jo3);
     		}
     		model.addAttribute("cate3", jCate3);
     		
     		// 상품 상태
     		List<Map<String, String>> productCondition = tradeService.getProductCondition();
     		model.addAttribute("productCondition", productCondition);
//     		System.out.println("상품상태 : " + productCondition);
     		
     		// 거래 방식
     		List<Map<String, String>> tradeMethod = tradeService.getTradeMethod();
     		model.addAttribute("tradeMethod", tradeMethod);
//     		System.out.println(tradeMethod);
     		
     		// 상품 결제 상태
     		List<Map<String, String>> productStatus = tradeService.getProductStatus();
     		model.addAttribute("productStatus", productStatus);
//     		System.out.println(productStatus);
     		
     		// 상품 가격 제안 유무 
     		List<Map<String, String>> productPriceOffer = tradeService.getProductPriceOffer();
     		model.addAttribute("productPriceOffer", productPriceOffer);
     		System.out.println(productPriceOffer);
     		
     		// 상품 안전 거래 사용 유무 
     		List<Map<String, String>> productSafeTrade = tradeService.getProductSafeTrade();
     		model.addAttribute("productSafeTrade", productSafeTrade);
     		System.out.println(productSafeTrade);
     		
     		System.out.println("카테1" + cate1);
     		System.out.println("카테2" + cate2);
     		System.out.println("카테3" + cate3);

        model.addAttribute("product", product);
        return "trade/product_edit";
    }

    // 상품 상태 업데이트
    @ResponseBody
    @PostMapping("updatePDS")
    public ResponseEntity<?> updateProductStatus(@RequestParam Map<String, Object> params) {
        String pdId = (String) params.get("pdId");
        String status = (String) params.get("status");

        // System.out.println("IDX : " + pdId);
        // System.out.println("status : " + status);

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
