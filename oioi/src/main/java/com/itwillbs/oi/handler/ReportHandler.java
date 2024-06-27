package com.itwillbs.oi.handler;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.oi.service.ChattingService;

@Component
public class ReportHandler {

	@Autowired
	private ChattingService service;
	
	@Autowired
	HttpSession session;
	
	public int reportProcess(@RequestParam Map<String, String> map
							, @RequestParam("RP_IMG") MultipartFile[] files) {
	
		// [파일 업로드 처리] ---------------------------------------------------------
		
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
	    System.out.println("saveDir" + saveDir);
	    String subDir = "";
	    
	    LocalDate today = LocalDate.now();
//			    LocalDate today = LocalDate.of(2024, 6, 21);
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
	    
//			    Map<String, String> fileMap = new HashMap<>();
        for (int i = 0; i < files.length && i < 2; i++) {
            MultipartFile file = files[i];
            if (!file.isEmpty()) {
            	
                String uuid = UUID.randomUUID().toString();
                String fileName = uuid.substring(0, 8) + "_" + file.getOriginalFilename();
                
                try {
                    file.transferTo(new File(saveDir, fileName));
                    map.put("RP_IMG" + (i+1), subDir + File.separator + fileName);
                    
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }  else {
            	map.put("RP_IMG" + (i+1), null);
            }
            
            
        }
        
        // 신고자 아이디 및 피신고자 아이디 저장
        map.put("FROM_US_ID", (String)session.getAttribute("US_ID"));
        System.out.println("이미지 파일 저장 후 "+ map);
        
        // DB 저장하기
        int insertCount = service.insertReport(map);
		
		return insertCount;
	}
}
