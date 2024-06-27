package com.itwillbs.oi.handler;



import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonObject;


public class ProductChattingHandler extends TextWebSocketHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(ProductChattingHandler.class);
		private static final Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());
	
		//커넥션이 연결 됫을때(접속을 성공했을때마다)
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			System.out.println("session값 : " + session);
			System.out.println("session.getAttributes()값 : " + session.getAttributes());
			sessions.add(session);
		}
		
		//어떠한 메세지를 보냈을때
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			
			Map<String, Object> attributes = session.getAttributes();
			String US_ID = (String) attributes.get("US_ID");
			System.out.println("handleTextMessage(message) : " + message.getPayload());
			
			// 받은 메시지를 그대로 클라이언트에게 응답으로 보냄
			
			JsonObject jo = new JsonObject();
			jo.addProperty("US_ID", US_ID);
			jo.addProperty("SESSION_SIZE", sessions.size());
			jo.addProperty("DATA", message.getPayload());
			
			System.out.println("보내기전 sessions 수  : " + sessions.toString());
			String jsonMessage = jo.toString();
			for (WebSocketSession sess : sessions) {
	            if (sess.isOpen()) {
	                sess.sendMessage(new TextMessage(jsonMessage));
	            }
	        }
//			session.sendMessage(new TextMessage(jsonMessage));
			
		}
		//커넥션이 끝났을때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			System.out.println("종료");
			//방나가면 세션삭제
			sessions.remove(session);
		}

}