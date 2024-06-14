package com.itwillbs.oi.Controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.oi.service.AuctionService;
import com.itwillbs.oi.service.TradeService;

@MultipartConfig
@Controller
public class TradeController {
	
	@Autowired 
	private TradeService TradeService;
	@Autowired
	private AuctionService Auctionservice;
	
	@GetMapping("trade")
	public String goTrade() {
		return "trade";
	}
	
	@GetMapping("product")
	public String goProductRegist(Model model) {
		// 카테고리 
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
		
		// 상품 상태
		List<Map<String, String>> productCondition = TradeService.getProductCondition();
		model.addAttribute("productCondition", productCondition);
//		System.out.println(productCondition);
		
		// 거래 방식
		List<Map<String, String>> tradeMethod = TradeService.getTradeMethod();
		model.addAttribute("tradeMethod", tradeMethod);
		System.out.println(tradeMethod);
		
		System.out.println("카테1" + cate1);
		System.out.println("카테2" + cate2);
		System.out.println("카테3" + cate3);
		return "product";
	}
	
	@GetMapping("detail")
	public String goDetail() {
		return "detailView";
	}
	
	@PostMapping("product")
	public String submitProduct(@RequestParam Map<String, Object> map, Model model
			,@RequestPart("addfile") MultipartFile[] files, HttpSession session
			) {
		
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + map); //작성값 다 가져오기 
//		for(MultipartFile mf : files) {
//			System.out.println(mf);
//		} //이미지 들고오기
//		System.out.println(session.getAttribute("US_ID"));
//		System.out.println(map.get("subject"));
//		Map<String, String> fileMap = new HashMap();
//		fileMap.put("setCar_images_1", null);
		 String uploadDir = "/resources/upload";
        String saveDir = session.getServletContext().getRealPath(uploadDir);

	        // 파일 저장
        Map<String, String> fileMap = new HashMap<>();
        for (int i = 0; i < files.length && i < 5; i++) {
            MultipartFile file = files[i];
            if (!file.isEmpty()) {
                String uuid = UUID.randomUUID().toString();
                String fileName = uuid.substring(0, 8) + "_" + file.getOriginalFilename();
                try {
                    file.transferTo(new File(saveDir, fileName));
                    fileMap.put("PD_IMAGE" + (i+1), uploadDir + "/" + fileName);
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }
        }
        System.out.println("$%$#%$#%$#%$#%$#%$#%#$ " + map.get("cate1"));
        System.out.println("$%$#%$#%$#%$#%$#%$#%#$ " + map.get("cate2"));
        System.out.println("$%$#%$#%$#%$#%$#%$#%#$ " + map.get("cate3"));
        
        map.put("US_ID", (String)session.getAttribute("US_ID"));
        map.put("PD_CATEGORY", map.get("cate1").toString() + "/" 
        						+ map.get("cate2").toString() + "/" 
        						+ map.get("cate3").toString());
//	        map.put("PD_SUBJECT", map.get("subject"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_PRICE", map.get("content"));
        map.put("PD_CONDITION", map.get("productCondition"));
        map.put("PD_TRADE_METHOD", map.get("tradeMethod"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_CONTENT", map.get("content"));
//	        map.put("PD_CONTENT", map.get("content"));
        
        // 파라미터 및 파일 정보 서비스로 전달
        map.putAll(fileMap);
        
        System.out.println("######################################" + map); //작성값 다 가져오기
        TradeService.submitProduct(map);
        
        return "home";
		
	}
}
