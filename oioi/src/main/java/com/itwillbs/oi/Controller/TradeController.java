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

import javax.servlet.annotation.MultipartConfig;
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
import com.itwillbs.oi.service.AuctionService;
import com.itwillbs.oi.service.TradeService;

@MultipartConfig
@Controller
public class TradeController {
	String uploadDir = "/resources/upload";
	@Autowired 
	private TradeService tradeService;
	@Autowired
	private AuctionService Auctionservice;
	
	// 거래 메인페이지
	@GetMapping("trade")
	public String goTrade( Model model) {
		
		
		
		 //카테고리 대분류
		List<Map<String, String>> cate1 = Auctionservice.getCategory1();
		model.addAttribute("cate1", cate1);
		
		//중분류
		List<Map<String, String>> cate2 = Auctionservice.getCategory2();
		System.out.println("cate2 : " + cate2);
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
		System.out.println("cate3 : " + cate3);
		JsonArray jCate3 = new JsonArray();
		for(Map<String, String> c3 : cate3) {
			JsonObject jo3 = new JsonObject();
			jo3.addProperty("CTG_CODE", c3.get("CTG_CODE"));
			jo3.addProperty("CTG_NAME", c3.get("CTG_NAME"));
			jo3.addProperty("UP_CTG_CODE", c3.get("UP_CTG_CODE"));
			jCate3.add(jo3);
		}
		model.addAttribute("cate3", jCate3);
		
		System.out.println("카테1" + cate1);
		System.out.println("카테2" + cate2);
		System.out.println("카테3" + cate3);
		
		
		return "trade/trade";
		
	}
	
	@GetMapping("/filterProducts")
    @ResponseBody
    public List<Map<String, Object>> filterProducts(
    		HttpSession session,            
    		@RequestParam Map<String, String> map,
            @RequestParam("pageNum") int pageNum,
            @RequestParam("listLimit") int listLimit,
            @RequestParam("filter") String filter) {
        
        int startRow = (pageNum - 1) * listLimit;
        Map<String, Object> params = new HashMap<>(map);
        params.put("startRow", startRow);
        params.put("listLimit", listLimit);
        params.put("filter", filter);
        params.put("US_ID", session.getAttribute("US_ID"));
        System.out.println("@@@@@@@@필터 값 : " + params.get(filter));
        System.out.println("params 값: " + params);

        return tradeService.getFilteredProducts(params);
    }
	
	
	

	 // 상품 상세 페이지
	@GetMapping("productDetail")
	public String goDetail(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		System.out.println(map);
		System.out.println("PD_IDX :" + map.get("PD_IDX"));
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.addAttribute("targetURL", "login"));
			return "err/fail";
		}
//		if(session.getAttribute("US_ID") != "" || session.getAttribute("US_ID") != null) {
			map.put("US_ID", session.getAttribute("US_ID").toString());
//		}
		
		// 클릭 시 조회 수 + 1
		String pd_idx = map.get("PD_IDX");
		int readCountResult = tradeService.updateReadCount(pd_idx);
		
		// pd_idx에 따른 정보 조회
		Map<String, String> dbMap = tradeService.getProductInfo(map);
		model.addAttribute("productInfo", dbMap);
		System.out.println(dbMap);
//		System.out.println("물건주인 아이디 : " + dbMap.get("US_ID"));
//		System.out.println("세션 아이디 : " + map.get("US_ID"));
			
		return "/trade/product_detail";
	}
		
		
	
	// 상품등록 페이지
	@GetMapping("product")
	public String goProductRegist(Model model, HttpSession session) {
		
		if(!CheckAuthority.isUser(session, model)) {
			System.out.println(model.addAttribute("targetURL", "login"));
			return "err/fail";
		}
		// 카테고리 대분류
		List<Map<String, String>> cate1 = Auctionservice.getCategory1();
		model.addAttribute("cate1", cate1);
		
		//중분류
		List<Map<String, String>> cate2 = Auctionservice.getCategory2();
//		System.out.println("cate2 : " + cate2);
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
//		System.out.println("cate3 : " + cate3);
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
//		System.out.println("상품상태 : " + productCondition);
		
		// 거래 방식
		List<Map<String, String>> tradeMethod = tradeService.getTradeMethod();
		model.addAttribute("tradeMethod", tradeMethod);
//		System.out.println(tradeMethod);
		
		// 상품 결제 상태
		List<Map<String, String>> productStatus = tradeService.getProductStatus();
		model.addAttribute("productStatus", productStatus);
//		System.out.println(productStatus);
		
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
		return "trade/product";
	}
	
	// 상품 등록하기
	@PostMapping("product")
	public String submitProduct(@RequestParam Map<String, Object> map, Model model
			,@RequestPart("addfile") MultipartFile[] files, HttpSession session
			) {
		
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + map); //작성값 다 가져오기
		System.out.println(map.get("PD_TAG"));
		// 사용자 아이디 가져오기
		map.put("US_ID", (String)session.getAttribute("US_ID"));
		// 카테고리 가져오기 
		System.out.println("ASDAD@ASD@!#@!@!#$#@!$@!" + map.get("cate3"));
//		String[] cateName = Auctionservice.categoryName(map);
//		System.out.println("cateName : " + cateName);
//		String cn = "";
//		for (int i = 0; i < cateName.length; i++) {
//			
//		    cn += cateName[i];
//		    if (i != cateName.length - 1) {
//		        cn += "/";
//		    }
//		}
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
		System.out.println("##################" + map);
		

	    // 파일 저장
        String saveDir = session.getServletContext().getRealPath(uploadDir);
	    System.out.println("saveDir" + saveDir);
	    String subDir = "";
	    
	    LocalDate today = LocalDate.now();
//	    LocalDate today = LocalDate.of(2024, 6, 21);
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
     // 태그 배열로 들어와서 따로 맵에 처리
        if(map.get("PD_TAG") != "") {
        	String tagsString = (String) map.get("PD_TAG");
            String[] tags = tagsString.replaceAll("[\\[\\]{}\"]", "").split(",");
            for (int i = 0; i < tags.length && i < 5; i++) {
                map.put("PD_TAG" + (i + 1), tags[i].split(":")[1].trim());
            }
        } 
        
//        System.out.println("!@#@!#@!#@!" + map.get("PD_TAG")); 
        //images테이블에 먼저 넣기
        System.out.println("fileMap : " + fileMap);
        
        int ImgIdx = Auctionservice.insertImg(fileMap);
	    System.out.println("ImgIdx : " + ImgIdx);
	    
	    if(ImgIdx > 0) {
	    	//상품등록 (ImgIdx는 상품등록 PD_IMAGE에 넣기)
	    	map.put("PD_IMAGE", ImgIdx);
		    System.out.println("상품등록하기전 최종 확인 : " + map);
		    
	    	int pdSuccess = tradeService.insertProduct(map);
		    System.out.println("pdSuccess : " + pdSuccess);
		    
		    if(pdSuccess > 0) {
		    	
		    	model.addAttribute("msg", "상품 등록 성공! ");
				model.addAttribute("targetURL", "trade");
				return "err/success";
		    }else {
		    	model.addAttribute("msg", "상품등록에 실패하였습니다.\n다시 상품등록을 해주세요.");
		    	model.addAttribute("targetURL", "product");
		    	
		    	return "err/fail";
		    }
	    }else {
	    	model.addAttribute("msg", "이미지 등록에 실패하였습니다.");
	    	model.addAttribute("targetURL", "product");
	    	
	    	return "err/fail";
	    }
	}
	
	
	// 찜하기 기능 추가
	@ResponseBody
    @PostMapping("addToWishlist")
    public JsonObject addToWishlist(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
        
		JsonObject jo = new JsonObject();
		// 사용자 세션 확인
	    String userId = (String) session.getAttribute("US_ID");
	    System.out.println("세션 id: " + userId);
	    if (userId == null) {
	        jo.addProperty("result", "NotLoggedIn");
	        return jo;
	    }
		System.out.println("받은 map정보 : " + map);
        map.put("WL_US_ID", (String)session.getAttribute("US_ID"));
        System.out.println("세션 확인 map : " + map);
        String checkWishList = tradeService.selectWishList(map);
        
        if(Boolean.parseBoolean(checkWishList)) {
        	tradeService.deleteWishList(map);
        	jo.addProperty("wish_yn", "");
        } else {
        	tradeService.addWishList(map);
        	jo.addProperty("wish_yn", "active");
        }
        
        System.out.println("조회한 찜목록 레코드 : " + checkWishList);
        
//        if(checkWishList > 0) {
//        	int deleteResult = tradeService.deleteWishList(map);
//        	if (deleteResult > 0) {
//                jo.addProperty("result", "Removed");
//            } else {
//                jo.addProperty("result", "RemoveFail");
//            }
//        } else {
//        	int result = tradeService.addWishList(map);
//        	
//        	if(result > 0) {
//        		jo.addProperty("result", "Success");
//        	} else {
//        		jo.addProperty("result", "fail");
//        	}
//        	
//        }
        return jo;
	}
}
//	@ResponseBody
//	@GetMapping("SelectProductList")
//	public String SelectProductList(@RequestParam Map<String, String> map
//								, Model model) {
//		System.out.println(map);
//		return "asdf";
//	}
