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
	private String PD_IDX;
	private String CR_ID;

	public static final String TYPE_SYS = "SYS"; 
	public static final String TYPE_TALK = "TALK"; 
	public static final String TYPE_LEAVE = "LEAVE"; 
}
