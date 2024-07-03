package com.itwillbs.oi.handler;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;



public class ProductChattingHandler extends TextWebSocketHandler{
	
		private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>(); // 현재 들어와 있는 세션 정보 
		private Map<String, String> userSessions = new ConcurrentHashMap<String, String>(); // 저장된 세션 정보들
		private Gson gson = new Gson();
	
		//커넥션이 연결 됫을때(접속을 성공했을때마다)
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			
			users.put(session.getId(), session);
			System.out.println("클라이언트 목록 ( " + users.keySet().size() + " 명)");
			
			// Map 객체(userSessions) 에 사용자 정보 저장
//			userSessions.put(session.getAttributes().get("id").toString(), session.getId());
//			System.out.println("사용자 목록 ( " + userSessions.keySet().size() + "명 ) : " + userSessions);
		}
		
		
		// 텍스트
		@Override
	    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { 

			// 만약 1:1 채팅 기능을 통해 상대방을 지정하여 메세지 전송 시
			// 세션 아이디로 상대방의 객체 알아내는 방법
			
			System.out.println("어떤 메세지" + message.getPayload());
			
			// 각 세션에 메세지 전송
			for(WebSocketSession ws : users.values()) {
				
				if(!ws.getId().equals(session.getId())) {
					ws.sendMessage(new TextMessage( message.getPayload()));
				}
			}
		
		}
		
		// 각 웹소켓 세션들에게 메세지 전송
		
		// 파일 업로드
		@Override
		protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message)  {
//			super.handleTextMessage(session, message);
			
		}

		//커넥션이 끝났을때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			System.out.println("연결 해제 session값 : " + session + " status : " + status);
			
			users.remove(session.getId());
			System.out.println("클라이언트 목록 : " + users.keySet().size() + " 명");
			
			// 사용자 정보 저장된 Map 객체 (userSession) 내에서 종료 요청이 발생한 웹소켓의 세션 아이디 제거
			// (HttpSession의 세션 아이디는 유지)
			
		}

}
