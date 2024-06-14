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

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
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

@Controller
public class AuctionController {
	
	String uploadDir = "/resources/upload";
	
	@Autowired
	private AuctionService service;
	
	@Autowired
	private TradeService TradeService;
	
	
	@GetMapping("auction")
	public String Auction() {
		return "auction/auction";
	}
	
	@GetMapping("auctionDetail")
	public String auctionDetail() {
		return "auction/auction_detail";
	}
	
	@GetMapping("auctionRegist")
	public String auctionRegist(Model model) {
		System.out.println("auctionRegist - controller");
		
		//대분류
		List<Map<String, String>> cate1 = service.getCategory1();
		model.addAttribute("cate1", cate1);
		
		//중분류
		List<Map<String, String>> cate2 = service.getCategory2();
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
		List<Map<String, String>> cate3 = service.getCategory3();
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
		
		return "auction/auction_regist";
	}
	
	@PostMapping("auctionRegist")
	public String auctionRegistPro(Model model,@RequestParam Map<String, String> map,
			@RequestPart("APD_IMAGE") MultipartFile[] files,
			HttpSession session) {
		System.out.println("auctionRegist - post(map) : " + map);
		System.out.println("auctionRegist - post(files) : " + files);
		
		
		
		
		//상품등록
	    String saveDir = session.getServletContext().getRealPath(uploadDir);
	    System.out.println("saveDir" + saveDir);
	    String subDir = "";
	    
	    LocalDate today = LocalDate.now();
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
                    fileMap.put("image" + (i+1), uploadDir + "/" + fileName);
                    
                    
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }
        }
        //images테이블에 먼저 넣기
        System.out.println("fileMap : "+fileMap);
        
        int mapImgSuccess = service.insertImg(fileMap);
	    System.out.println("mapImgSuccess : " + mapImgSuccess);
		return "";
	}
	

}
