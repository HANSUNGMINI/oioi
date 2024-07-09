package com.itwillbs.oi.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductChatVO {
	private String type;
	private String msg;
	private String TO_ID;
	private String FROM_ID;
	private int PD_IDX;
	private String CR_ID;

	// type 변수에 사용될 값을 상수로 생성
	public static final String TYPE_INIT = "INIT"; 
	public static final String TYPE_INIT_COMPLETE = "INIT_COMPLETE";
	public static final String TYPE_SHOW_CHATMESSAGE = "SHOW_CHATMESSAGE";
	
	public static final String TYPE_ADD_LIST = "ADD_LIST"; 
	public static final String TYPE_START= "START"; 
	public static final String TYPE_ENTER = "ENTER";
	
	public static final String TYPE_TALK = "TALK";
	
	public static final String TYPE_LEAVE = "LEAVE";
	
	public static final String TYPE_ERROR = "ERROR";
}
