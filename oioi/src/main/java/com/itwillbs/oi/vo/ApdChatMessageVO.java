package com.itwillbs.oi.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 웹소켓 채팅 메세지를 자동으로 파싱하기 위한 클래스 정의
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ApdChatMessageVO {
	private String type;
	private String sender_id;
	private String msg;
	
	// type 변수에 사용될 값을 상수로 생성
	public static final String TYPE_ENTER = "ENTER"; 
	public static final String TYPE_TALK = "TALK"; 
	public static final String TYPE_LEAVE = "LEAVE"; 
}
