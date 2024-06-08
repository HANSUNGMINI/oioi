package com.itwillbs.oi.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * [ 회원 인증 정보를 관리할 spring_mvc_board3.mail_auth_info 테이블 정의 ]
 * -------------------------------------------------------------------------
 * 아이디(id) - 16글자, PK, 참조키 : member 테이블의 id 컬럼(DELETE 옵션)
 * 인증코드(auth_code) - 50글자, NOT NULL
   -------------------------------------------------------------------------
   CREATE TABLE mail_auth_info (
   		id VARCHAR(16) PRIMARY KEY,
   		auth_code VARCHAR(50) NOT NULL,
   		FOREIGN KEY (id) REFERENCES member(id) ON DELETE CASCADE
   );
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MailAuthInfoVO {
	private String member_email;
	private String auth_code;
}












