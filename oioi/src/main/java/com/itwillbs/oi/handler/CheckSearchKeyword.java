package com.itwillbs.oi.handler;

import org.springframework.stereotype.Component;

@Component
public class CheckSearchKeyword {

	// 자음만 입력
	public boolean isConsonantOnly(String input) {
		return input.matches("[ㄱ-ㅎ]+");
	}
	
	// 모음만 입력
	 public boolean containsVowel(String input) {
        return input.matches(".*[ㅏ-ㅣ]+.*");
    }
}
