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
	
	// 공지사항 보기
	@GetMapping("noticeDetail")
	public String goNoticeDetail() {
		return "customerCenter/notice_detail";
	}
	
	// 공지사항 수정
	@GetMapping("noticeModify")
	public String goNoticeModify() {
		return "customerCenter/notice_modify";
	}
	
	// 챗봇
	@GetMapping("chatbot")
	public String goChatbot() {
		return "customerCenter/chatbot2";
	}
	
	// 큐엔에이
	@GetMapping("qna")
	public String goQna() {
		return "customerCenter/qna";
	}
	
	// 큐엔에이 작성 폼
	@GetMapping("qnaWrite")
	public String goQnaWrite() {
		return "customerCenter/qna_write";
	}
	
	// 큐엔에이 확인 폼
	@GetMapping("qnaDetail")
	public String goQnaDetail() {
		return "customerCenter/qna_detail";
	}
}
