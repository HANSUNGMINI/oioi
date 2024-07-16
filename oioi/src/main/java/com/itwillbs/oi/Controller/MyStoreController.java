package com.itwillbs.oi.Controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
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
            cookie.setMaxAge(60 * 60 * 24); // 쿠키 유효기간 1일
            cookie.setPath("/"); // 모든 경로에서 유효하도록 설정
            response.addCookie(cookie);
        }
        
        int salesCount = storeService.getSalesCount(userId);
        model.addAttribute("salesCount", salesCount);
        
        int visitCount = storeService.getVisitCount(userId);
        
        String openDate = user.get("US_REG_DATE");
        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime userOpenDate = LocalDateTime.parse(openDate, formatter1);
        String open = dateTimeAgo(userOpenDate);
        user.put("open", open);
        model.addAttribute("visitCount", visitCount);
        
        // 리뷰 데이터 가져오기
        List<Map<String, Object>> reviews = storeService.getReviewsByStoreId(userId);
        List<Map<String, String>> reviewCategories = storeService.getCommonCode("REVIEW_CATEGORY");

        // 리뷰 카테고리 매핑
        Map<String, String> categoryMap = reviewCategories.stream()
            .collect(Collectors.toMap(c -> c.get("code"), c -> c.get("value")));

        for (Map<String, Object> review : reviews) {
            String[] categories = ((String) review.get("RV_CATEGORY")).split("/");
            List<String> categoryNames = Arrays.stream(categories)
                    .map(code -> categoryMap.getOrDefault(code, code))
                    .collect(Collectors.toList());
            review.put("RV_CATEGORY_NAMES", categoryNames);
        }

        model.addAttribute("reviews", reviews);

        // 공통 코드와 상품 목록 조회
        List<Map<String, String>> code = storeService.getCommonCode("PD_STATUS");
        List<Map<String, Object>> myPD = storeService.selectMyPd(userId);
        
        System.out.println(myPD);

        // 상품 목록을 역순으로 정렬
        Collections.reverse(myPD);

        // 상품 목록을 스트림으로 처리하여 각 상품의 등록 시간을 현재 시간과 비교한 결과를 추가
        List<Map<String, Object>> productList = myPD.stream()
                .map(product -> {
                    String dateString = (String) product.get("PD_REG_DATE");
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                    LocalDateTime regDate = LocalDateTime.parse(dateString, formatter);

                    String timeAgo = dateTimeAgo(regDate);
                    product.put("timeAgo", timeAgo);
                    return product;
                }).collect(Collectors.toList());

        model.addAttribute("user", user);
        model.addAttribute("myPD", productList);
        
        // 찜 리스트 추가
        List<Map<String, Object>> wishList = storeService.getWishListByUserId(userId).stream()
            .map(wish -> {
                String dateString = (String) wish.get("PD_REG_DATE");
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                LocalDateTime regDate = LocalDateTime.parse(dateString, formatter);

                String timeAgo = dateTimeAgo(regDate);
                wish.put("timeAgo", timeAgo);
                return wish;
            }).collect(Collectors.toList());

        model.addAttribute("wishList", wishList);

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
    
    @PostMapping("productModify2")
    public String editProduct(@RequestParam Map<String, Object> map, Model model,
                                @RequestPart("addfile") MultipartFile[] files, HttpSession session) {
        System.out.println("!@#!@#");
    	System.out.println(map);
    	
    	// 사용자 아이디 추가
        map.put("US_ID", (String) session.getAttribute("US_ID"));
        map.put("PD_CATEGORY", map.get("cate3"));
        if(map.get("PD_PRICE_OFFER") != null) {
            map.put("PD_PRICE_OFFER", "PPO01");
        } else {
            map.put("PD_PRICE_OFFER", "PPO02");
        }
        if(map.get("PD_SAFE_TRADE") != null) {
            map.put("PD_SAFE_TRADE", "PST01");
        } else {
            map.put("PD_SAFE_TRADE", "PST02");
        }

        // 파일 저장 로직
        String saveDir = session.getServletContext().getRealPath(uploadDir);
        LocalDate today = LocalDate.now();
        String subDir = today.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
        saveDir += "/" + subDir;

        try {
            Path path = Paths.get(saveDir);
            Files.createDirectories(path);
        } catch (IOException e) {
            e.printStackTrace();
        }

        Map<String, String> fileMap = new HashMap<>();
        for (int i = 0; i < files.length && i < 5; i++) {
            MultipartFile file = files[i];
            if (!file.isEmpty()) {
                String uuid = UUID.randomUUID().toString();
                String fileName = uuid.substring(0, 8) + "_" + file.getOriginalFilename();
                try {
                    file.transferTo(new File(saveDir, fileName));
                    fileMap.put("image" + (i+1), subDir + File.separator + fileName);
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // 태그 처리
        if(map.get("PD_TAG") != "") {
            String tagsString = (String) map.get("PD_TAG");
            String[] tags = tagsString.replaceAll("[\\[\\]{}\"]", "").split(",");
            for (int i = 0; i < tags.length && i < 5; i++) {
                map.put("PD_TAG" + (i + 1), tags[i].split(":")[1].trim());
            }
        }

        // 기존 이미지 업데이트 로직 추가
        System.out.println("fileMap : " + fileMap);
        map.put("IMG_IDX", map.get("PD_IMAGE"));  // PD_IMAGE는 기존 이미지의 IDX

        int pdSuccess = storeService.updateProduct(map, fileMap);
        System.out.println("pdSuccess : " + pdSuccess);

        if(pdSuccess > 0) {
            model.addAttribute("msg", "상품 수정 성공! ");
            model.addAttribute("targetURL", "trade");
            return "err/success";
        } else {
            model.addAttribute("msg", "상품 수정에 실패하였습니다. 다시 시도해 주세요.");
            model.addAttribute("targetURL", "product");
            return "err/fail";
        }
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
        System.out.println("상품 정보 : " + product);
        
        
        
        // 카테고리 대분류
    	List<Map<String, String>> cate1 = Auctionservice.getCate1Edit(map);
 		model.addAttribute("cate1", cate1);
 		//중분류
 		List<Map<String, String>> cate2 = Auctionservice.getCate2Edit(map);
		model.addAttribute("cate2", cate2);
		// 소분류
 		List<Map<String, String>> cate3 = Auctionservice.getCate3Edit(map);
 		model.addAttribute("cate3", cate3);
 		
 		List<Map<String, String>> cate2All = Auctionservice.getCategory2();
 		JsonArray jCate2 = new JsonArray();
 		for(Map<String, String> c2 : cate2All) {
 			JsonObject jo = new JsonObject();
 			jo.addProperty("CTG_CODE", c2.get("CTG_CODE"));
 			jo.addProperty("CTG_NAME", c2.get("CTG_NAME"));
 			jo.addProperty("UP_CTG_CODE", c2.get("UP_CTG_CODE"));
 			jo.addProperty("SELECTED", c2.get("SELECTED"));
 			jCate2.add(jo);
 		}
 		model.addAttribute("jCate2", jCate2);
 		
 		//소분류
 		List<Map<String, String>> cate3All = Auctionservice.getCategory3();
 		JsonArray jCate3 = new JsonArray();
 		for(Map<String, String> c3 : cate3All) {
 			JsonObject jo3 = new JsonObject();
 			jo3.addProperty("CTG_CODE", c3.get("CTG_CODE"));
 			jo3.addProperty("CTG_NAME", c3.get("CTG_NAME"));
 			jo3.addProperty("UP_CTG_CODE", c3.get("UP_CTG_CODE"));
 			jo3.addProperty("SELECTED", c3.get("SELECTED"));
 			jCate3.add(jo3);
 		}
 		model.addAttribute("jCate3", jCate3);
 		
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

 	    // 태그를 JSON 형식으로 변환하여 모델에 추가
 	    List<String> tags = new ArrayList<>();
 	    for (int i = 1; i <= 5; i++) {
 	        String tag = (String) product.get("PD_TAG" + i);
 	        if (tag != null && !tag.isEmpty()) {
 	            tags.add(tag);
 	        }
 	    }
 	    String tagsJson = new Gson().toJson(tags);
 	    product.put("PD_TAG_JSON", tagsJson);
 		
        model.addAttribute("product", product);
        System.out.println("상품 ~  " + product);
        
        return "trade/product_edit";
    }
    
    @PostMapping("productModify")
    public String submitProduct(@RequestParam Map<String, Object> map, Model model,
                                @RequestPart("addfile") MultipartFile[] files, HttpSession session) {
        // 사용자 아이디 추가
        map.put("US_ID", (String) session.getAttribute("US_ID"));
        map.put("PD_CATEGORY", map.get("cate3"));
        map.put("PD_PRICE_OFFER", map.getOrDefault("PD_PRICE_OFFER", "PPO02"));
        map.put("PD_SAFE_TRADE", map.getOrDefault("PD_SAFE_TRADE", "PST02"));

        // 파일 저장 로직
        String saveDir = session.getServletContext().getRealPath(uploadDir);
        LocalDate today = LocalDate.now();
        String subDir = today.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
        saveDir += "/" + subDir;

        try {
            Path path = Paths.get(saveDir);
            Files.createDirectories(path);
        } catch (IOException e) {
            e.printStackTrace();
        }

        Map<String, String> fileMap = new HashMap<>();
        for (int i = 0; i < files.length && i < 5; i++) {
            MultipartFile file = files[i];
            if (!file.isEmpty()) {
                String uuid = UUID.randomUUID().toString();
                String fileName = uuid.substring(0, 8) + "_" + file.getOriginalFilename();
                try {
                    file.transferTo(new File(saveDir, fileName));
                    fileMap.put("image" + (i+1), subDir + "/" + fileName);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        
        System.out.println("이미지 파일 정보 좀 보겠습니다 ." + fileMap);

        // 태그 처리
        if (!map.get("PD_TAG").toString().isEmpty()) {
            String tagsString = (String) map.get("PD_TAG");
            String[] tags = tagsString.replaceAll("[\\[\\]{}\"]", "").split(",");
            for (int i = 0; i < tags.length && i < 5; i++) {
                map.put("PD_TAG" + (i + 1), tags[i].split(":")[1].trim());
            }
        }

        // 이미지 및 상품 정보 업데이트
        int updateResult = storeService.updateProduct(map, fileMap);
        if (updateResult > 0) {
            model.addAttribute("msg", "상품 수정 성공!");
            model.addAttribute("targetURL", "trade");
            return "err/success";
        } else {
            model.addAttribute("msg", "상품 수정에 실패하였습니다. 다시 시도해 주세요.");
            model.addAttribute("targetURL", "product");
            return "err/fail";
        }
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
    
    @ResponseBody
    @PostMapping("deleteProduct")
    public String deleteProduct(@RequestParam("pdId") String pdId) {
        try {
            storeService.deleteProductById(pdId);
            return "success";
        } catch (Exception e) {
            return "failure";
        }
    }

    @ResponseBody
    @PostMapping("productUp")
    public String productUp(@RequestParam("pdId") String pdId) {
    	System.out.println("끌어올리기 : " + pdId);
    	storeService.updatePDtime(pdId);
    	
    	
    	return "success";
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
