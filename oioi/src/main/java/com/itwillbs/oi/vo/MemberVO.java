package com.itwillbs.oi.vo;

import java.time.LocalDateTime;

import lombok.Data;


@Data
public class MemberVO {
	private int member_idx;
	private String member_id;
	private String member_name;
	private String member_email;
	private String member_post_code;
	private String address1;
	private String address2;
	private String member_phone;
	private String member_passwd;
	private LocalDateTime member_reg_date;
	private int member_status;
}
