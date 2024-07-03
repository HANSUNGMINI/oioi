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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
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
import com.itwillbs.oi.service.AuctionService;
import com.itwillbs.oi.service.ChattingService;
import com.itwillbs.oi.service.TradeService;

@Controller
public class AuctionController {
   
   String uploadDir = "/resources/upload";
   
   @Autowired
   private AuctionService service;
   
   @Autowired
   private TradeService TradeService;
   
   @Autowired
   private ChattingService ChatReportService;
   
   @GetMapping("auction")
   public String Auction(Model model) {
	   List<Map<String, Object>> map = service.apdPopular();
	   System.out.println("apdPopular(map) : " + map);
	   
	   model.addAttribute("apdPopular", map);
      return "auction/auction";
   }
   
   @ResponseBody
   @PostMapping("auction")
   public List<Map<String, Object>> AuctionPro(
		   Model model,
		   @RequestParam("APD_STATUS") String APD_STATUS,
		   @RequestParam("pageNum") int pageNum,
           @RequestParam("listLimit") int listLimit) {
	   System.out.println("APD_STATUS : " + APD_STATUS);
	   System.out.println("pageNum : " + pageNum);
	   System.out.println("listLimit : " + listLimit);
	   int startRow = (pageNum - 1) * listLimit;
	   Map<String, Object> params = new HashMap<>();
       params.put("startRow", startRow);
       params.put("listLimit", listLimit);
       params.put("APD_STATUS", APD_STATUS);
	   
	   List<Map<String, Object>> apdList = service.selectApdList(params);
	   System.out.println("apdList : " + apdList);
	   return apdList;
   }
   
   @GetMapping("auctionDetail")
   public String auctionDetail(@RequestParam Map<String, String> map, Model model,HttpSession session) {
      System.out.println("auctionDetail(map) : " + map);
      
      //상품정보가져오기
      Map<String, String> dbMap = service.selectApdDetail(map);
      System.out.println("상품정보 확인 : " + dbMap);
      dbMap.put("US_ID", (String) session.getAttribute("US_ID"));
      model.addAttribute("apdDetail", dbMap);
      
      // 신고 카테고리 불러오기
   	  List<Map<String, String>> reportMap = ChatReportService.getReportCategory();
   	  model.addAttribute("reportMap", reportMap); // [공통코드] 신고 카테고리
      
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
   public String auctionRegistPro(Model model, @RequestParam Map<String, Object> map,
         @RequestPart("APD_IMAGE") MultipartFile[] files,
         @RequestPart("APD_MAIN_IMAGE") MultipartFile mainFile,
         HttpSession session) {
      System.out.println("auctionRegist - post(map) : " + map);
      System.out.println("auctionRegist - post(files) : " + files);
      System.out.println("auctionRegist - post(file) : " + mainFile);
      
      //US_ID 담기
      map.put("APD_OWNER", session.getAttribute("US_ID"));
      
      String cate3 = (String)map.get("cate3");
      
      map.put("APD_CATEGORY", cate3);
      
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
       //상세이미지
       Map<String, String> fileMap = new HashMap<>();
        for (int i = 0; i < files.length && i < 5; i++) {
            MultipartFile file = files[i];
            if (!file.isEmpty()) {
                String uuid = UUID.randomUUID().toString();
                String fileName = uuid.substring(0, 8) + "_" + file.getOriginalFilename();
                try {
                    file.transferTo(new File(saveDir, fileName));
                    fileMap.put("image" + (i+1),subDir + File.separator + fileName);
                    
                    
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }
        }
        
        //메인이미지 넣기
        if(!mainFile.isEmpty()) {
        	String uuid = UUID.randomUUID().toString();
            String fileName = uuid.substring(0, 8) + "_" + mainFile.getOriginalFilename();
            try {
            	mainFile.transferTo(new File(saveDir, fileName));
            	map.put("APD_MAIN_IMAGE", subDir + File.separator + fileName);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
        }
        
        //images테이블에 먼저 넣기
        System.out.println("fileMap : "+fileMap);
        
        int ImgIdx = service.insertImg(fileMap);
       System.out.println("ImgIdx : " + ImgIdx);
       
       
       if(ImgIdx > 0) {
          //상품등록 (ImgIdx는 상품등록 APD_IMAGE에 넣기)
          map.put("APD_IMAGE", ImgIdx);
          System.out.println("상품등록하기전 최종 확인 : " + map);
          
          int apdSuccess = service.insertAPD(map);
          System.out.println("apdSuccess : " + apdSuccess);
          
          if(apdSuccess > 0) {
             
            model.addAttribute("msg", "등록성공! 1차검수가 완료되면 상품을 보내주세요.");
            model.addAttribute("targetURL", "auction");
            model.addAttribute("notify", true);
            return "err/success";
          }else {
             model.addAttribute("msg", "상품등록에 실패하였습니다.\n다시 상품등록을 해주세요.");
             model.addAttribute("targetURL", "auctionRegist");
             
             return "err/fail";
          }
       }else {
          model.addAttribute("msg", "이미지 등록에 실패하였습니다.");
          model.addAttribute("targetURL", "auctionRegist");
          
          return "err/fail";
       }
       
      
   }
   
   @ResponseBody
   @PostMapping("saveMsg")
   public Map<String, Object> saveMsg(@RequestParam Map<String, Object> map) {
      System.out.println("메세지 ajax : " + map);
      
      //채팅칠때 채팅방이 없다면 채팅방먼저 개설
      String APD_IDX = (String)map.get("APD_IDX");
      Map<String, String> selectACR = service.selectACR(APD_IDX);
      System.out.println("챗룸있는지 :" + selectACR);
      if(selectACR == null) {
         int insertACR = service.insertACR(APD_IDX);
         System.out.println("채팅방개설 : " + insertACR);
      }
      //채팅insert
      int insertACM = service.insertACM(map);
      System.out.println("채팅 저장 : " + insertACM);
      
      Map<String, Object> response = new HashMap<>();
       if (insertACM > 0) {
           response.put("status", "success");
           response.put("data", map);
       } else {
           response.put("status", "fail");
       }
       return response;
   }
   
   @ResponseBody
   @PostMapping("auctionBid")
   public String auctionBid(@RequestParam Map<String, Object> map,Model model) {
      System.out.println("auctionBid : " + map);
      //기록을 위해 bidding 테이블에 추가
      
//      int updateBid = service.updateBid(map);
//      System.out.println("updateBid 성공 여부" + updateBid);
//      if(updateBid > 0) {
//         //상태값을 입찰예정으로 변경
//         service.updateApdStatus((String)map.get("APD_IDX")); 
//         return (String)map.get("BID_PRICE");
//      }else {
//         model.addAttribute("msg", "입찰에 실패하였습니다.");
//         model.addAttribute("targetURL", "auctionRegist");
//          return "err/fail";
//      }
      
      int updateApdStatus = service.updateApdStatus((String)map.get("APD_IDX"));
      if(updateApdStatus > 0) {
         System.out.println("경매중 상태 변경 성공");
         //경매테이블 갱신
         service.updateApdBid(map);
         System.out.println("경매테이블 경신 성공!");
         //기록을 위해 bidding 테이블에 추가
         int insertBidSuccess = service.insertBid(map);
         if(insertBidSuccess == 0) {
            model.addAttribute("msg", "입찰실패");
            model.addAttribute("targetURL", "./");
             return "err/fail";
         }
         
         return (String)map.get("FINAL_BID_PRICE");
      }else {
         model.addAttribute("msg", "입찰기간이 아닙니다.");
         model.addAttribute("targetURL", "./");
          return "err/fail";
      }
      
   }
   
   @ResponseBody
   @PostMapping("biddingChart")
   public List<Map<String, String>> biddingChart(@RequestParam int APD_IDX) {
	   System.out.println("biddingChart : " + APD_IDX);
	   List<Map<String, String>> dbMap = service.selectBidChart(APD_IDX);
	   System.out.println("biddingChart(dbMap) : " + dbMap);
	   return dbMap;
   }
   

}
