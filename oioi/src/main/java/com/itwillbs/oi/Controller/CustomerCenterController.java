package com.itwillbs.oi.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class CustomerCenterController {
	// 공지사항
	@GetMapping("notice")
	public String goNotice() {
		return "customerCenter/notice";
	}
	
	// 공지사항 작성
	@GetMapping("noticeWrite")
	public String goNoticeWriteForm() {
		return "customerCenter/notice_write";
	}
	
	// 챗봇
	@GetMapping("chatbot")
	public String goChatbot() {
		return "customerCenter/chatbot";
	}
	
	// 큐엔에이
	@GetMapping("qna")
	public String goqna() {
		return "customerCenter/qna";
	}
	
	// 큐엔에이 작성 폼
	@GetMapping("qnaWrite")
	public String goqnaWrite() {
		return "customerCenter/qna_write";
	}
}
