package com.itwillbs.oi.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.itwillbs.oi.service.UserService;

import lombok.Data;

@Data
@Component
public class CheckAuthority {
	
	
	// 상수 만들어 놓기
	public final static String MAIN = "./";
	public final static String LOGIN = "login";
	
	
	/**
	 * 유저 확인 메소드 <br>
	 * if(!CheckAuthority.isUser(session, model)) { <br>
			return false; <br>
		}  <br>
		사용하면댐
	 * @param session : 권한 확인 세션
	 * @param model : 속성 저장용
	 * @return boolean 으로 리턴함
	 * 
	 */
	public static boolean isUser(HttpSession session, Model model) {
		String id = (String)session.getAttribute("US_ID");
		// 유저가 아닐 경우
		if(id == null) {
			model.addAttribute("msg", "로그인 후 이용이 가능합니다.");
			return false;
		} 
		
		//  전부통과면 맞다면 true 리턴
		return true;
	}
	
	public static boolean checkStatus(HttpSession session, Model model, HttpServletRequest request) {
		if(!request.getServletPath().equals("/myPage") || !request.getServletPath().equals("/userUpdate")) {
			String id = (String)session.getAttribute("US_ID");
			UserService userService = new UserService();
			if(userService.selectStatus(id).equals("US03")) {
				model.addAttribute("msg", "미입력 정보를 입력해주세요");
				model.addAttribute("targetURL", "userUpdate");
				return false;
			}
		}
		return true;
	}
	
	
	/**
	 * 유저 확인 메소드 <br>
	 * if(!CheckAuthority.isUser(session, model, "XXX")) { <br>
			return false; <br>
		}  <br>
		사용하면댐
	 * @param session : 권한 확인 세션
	 * @param model : 속성 저장용
	 * @param targetURL : "XXX" 보내고 싶은 경로 기입(상수 사용하기)
	 * @return boolean 으로 리턴함
	 * 
	 */
	public static boolean isUser(HttpSession session, Model model, String targetURL) {
		
		// 유저가 아닐 경우
		if(!CheckAuthority.isUser(session, model)) {
			model.addAttribute("targetURL", targetURL);
			return false;
		}
		
		return true;
	}
	
	
	
	// ===============================================관리자
	
	/**
	 * 관리자 페이지 접속 시 권한 확인 <br>
	 * 
	 * 유저확인이랑 다르게 무조건 메인으로 보내버림
	 * 
	 * if(!CheckAuthority.isAdmin(session, model)) { <br>
			return false; <br>
		}  <br>
		
		사용하면댐
	 * @param session : 권한 확인 세션
	 * @param model : 속성 저장용
	 * @return 
	 */
	public static boolean isAdmin(HttpSession session, Model model) {
		
		// 관리자가 아닐 경우
		if(session.getAttribute("isAdmin") == null) {
			model.addAttribute("msg", "너 관리자 아니잖아 ㅋ");
			model.addAttribute("targetURL", CheckAuthority.MAIN);
			return false;
		}
		// 관리자가 맞다면 true 리턴
		return true;
	}
	
	
	/**
	 * 슈퍼관리자 페이지 접속 시 권한 확인 <br>
	 * case 1 : 비회원, 회원 등 관리자 페이지가 아닌 강제 접속 시 메인으로 보내버림
	 * case 2 : 관리자이며 관리자 페이지에서 접속하지만 "최고관리자"가 아닐 시 뒤로가기  
	 * 
	 * if(!CheckAuthority.isAdminMaster(session, model)) { <br>
			return false; <br>
		}  <br>
		
	 * @param session : 권한 확인 세션
	 * @param model : 속성 저장용
	 * @return 
	 */
	public static boolean isAdminMaster(HttpSession session, Model model) {
		System.out.println("진입완료");
		
		// 관리자가 아니라면 false 리턴되서옴
		if(!CheckAuthority.isAdmin(session, model)) {
			return false;
		} 
		
		// 관리자는 맞는데 슈퍼 관리자가 아니라면
		if(session.getAttribute("isMaster") == null) {
			model.addAttribute("msg", "권한이 없습니다");
			return false;
		}
		
		// 슈퍼관리자라면 트루 리턴
		return true;
	}
	
}
