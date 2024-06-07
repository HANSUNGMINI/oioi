package com.itwillbs.oi.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class MyExceptionHandler {
	
	@ExceptionHandler(Exception.class)
	public String myException(Exception e) {
		e.printStackTrace();
		
		return "error/error_500";
	}
}
