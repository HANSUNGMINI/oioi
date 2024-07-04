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
	private String US_ID;
	private String PD_IDX;
	
	
	// type 변수에 사용될 값을 상수로 생성
//	public static final String TYPE_SELL = "SELL"; 
//	public static final String TYPE_PAY = "PAY"; 
//	public static final String TYPE_DELIVERY = "DELIVERY"; 
//	public static final String TYPE_REVIEW = "REVIEW"; 
	public static final String TYPE_SYS = "SYS"; 
	public static final String TYPE_TALK = "TALK"; 
	public static final String TYPE_LEAVE = "LEAVE"; 
}
