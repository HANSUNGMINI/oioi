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
		
		// 상품 상태
		List<Map<String, String>> productCondition = TradeService.getProductCondition();
		model.addAttribute("productCondition", productCondition);
//		System.out.println(productCondition);
		
		// 거래 방식
		List<Map<String, String>> tradeMethod = TradeService.getTradeMethod();
		model.addAttribute("tradeMethod", tradeMethod);
		System.out.println(tradeMethod);
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
//		System.out.println(map); //작성값 다 가져오기 
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

	        // 파라미터 및 파일 정보 서비스로 전달
	        map.put("US_ID", (String)session.getAttribute("US_ID"));
	        map.putAll(fileMap);
	        TradeService.submitProduct(map);

	        return "./";
		
	}
}
