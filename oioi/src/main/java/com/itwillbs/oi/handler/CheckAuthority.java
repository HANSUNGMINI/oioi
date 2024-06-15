package com.itwillbs.oi.handler;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import lombok.Data;

@Data
public class CheckAuthority {
	// 상수 만들어 놓기
	
	public final static String MAIN = "./";

	
	/**
	 * 유저 확인 메소드
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
			
		// 유저가 아닐 경우
		if(session.getAttribute("US_ID") == null) {
			model.addAttribute("msg", "로그인 후 이용이 가능합니다.");
			return false;
		}
		
		//  유저 가 맞다면 true 리턴
		return true;
	}
	
	/**
	 * 유저 확인 오버로딩 targetURL 메소드
	 * if(!CheckAuthority.isUser(session, model, "XXX")) {
			return false;
		} 
		사용하면댐
	 * @param session : 권한 확인 세션
	 * @param model : 속성 저장용
	 * @param targetURL : "XXX" 보내고 싶은 경로 기입
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
	 * 관리자 페이지 접속 시 권한 확인 
	 * 
	 * @param session : 권한 확인 세션
	 * @param model : 속성 저장용
	 * @return 
	 */
	public static boolean isAdmin(HttpSession session, Model model) {
		
		// 관리자가 아닐 경우
		if(session.getAttribute("isAdmin") == null) {
			System.out.println("관리자가 아님");
			model.addAttribute("targetURL", "./");
			model.addAttribute("msg", "잘못된 진입입니다. 너 관리자 아니잖아 ㅋ");
			return false;
		}
		
		// 관리자가 맞다면 true 리턴
		return true;
	}
	
	
	/**
	 * 슈퍼관리자 페이지 접속 시 권한 확인 
	 * 어드민 계정이 접속하면 history.bakc(), 이외의 것들이면 메인으로 돌려보내기
	 * 
	 * @param session : 권한 확인 세션
	 * @param model : 속성 저장용
	 * @return boolean 타입으로 권한을 가지고 있다면 true 아니라면 false니까<br>
	 * 			!(not)을 붙여서 if문에 사용 할 것<br>
	 *  		ex) if(!CheckAuthority.XXX) {
	 */
	public static boolean isAdminMaster(HttpSession session, Model model) {
		System.out.println("진입완료");
		
		// 관리자가 아니라면 false 리턴되서옴
		if(!CheckAuthority.isAdmin(session, model)) {
			System.out.println("관리자도 아님 ㅋ");
			System.out.println(model);
			return false;
		} 
		
		// 관리자는 맞는데 슈퍼 관리자가 아니라면
		if(session.getAttribute("isMaster") == null) {
			System.out.println("일단 관리자긴함");
			model.addAttribute("msg", "권한이 없습니다");
			return false;
		}
		
		System.out.println("슈퍼 관리자 맞음");
		// 슈퍼관리자라면 트루 리턴
		return true;
	}
	
}
