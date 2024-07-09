package com.itwillbs.oi.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ProductChatRoomVO {
	private String CR_ID;
	private String TO_ID;
	private String FROM_ID;
	private int PD_IDX;

	// type 변수에 사용될 값을 상수로 생성
	public static final String TYPE_INIT = "INIT";
	
}
