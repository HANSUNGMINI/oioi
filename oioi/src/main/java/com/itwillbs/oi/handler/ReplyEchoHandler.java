package com.itwillbs.oi.handler;


import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;

import kotlinx.serialization.json.Json;


public class ReplyEchoHandler extends TextWebSocketHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyEchoHandler.class);
//		List<String> sessions = new ArrayList<>();
		private static final Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());
	
		//커넥션이 연결 됫을때(접속을 성공했을때마다)
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			System.out.println("session값 : " + session);
			System.out.println("session.getAttributes()값 : " + session.getAttributes());
//			Map<String, Object> attributes = session.getAttributes();
//			String US_ID = (String) attributes.get("US_ID");
			sessions.add(session);
//			logger.info("Connection Established: " + session);
//			System.out.println("afterConnectionEstablished : " + session.getAttributes());
//			Map<String, Object> attributes = session.getAttributes();
//			System.out.println("dd : " + attributes.get("US_ID"));
//			
//			sessions.add((WebSocketSession)attributes.get("US_ID"));
//			WebSocketSession US_ID = (WebSocketSession) attributes.get("US_ID");
//			
//			System.out.println("US_ID : " + US_ID);
			
//			// 중복 확인
//			if (!sessions.contains(US_ID)) {
//			    sessions.add(US_ID);
//			}
			
//			System.out.println("확인 : "+sessions.toString());
			
		}
		//어떠한 메세지를 보냈을때
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			
			Map<String, Object> attributes = session.getAttributes();
			String US_ID = (String) attributes.get("US_ID");
			System.out.println("handleTextMessage(message) : " + message.getPayload());
			
			// 받은 메시지를 그대로 클라이언트에게 응답으로 보냄
			
//			JsonObject jo = new JsonObject();
//			jo.addProperty("US_ID", US_ID);
//			jo.addProperty("MSG", message.getPayload());
			
			System.out.println("보내기전 sessions 수  : " + sessions.toString());
			String jsonMessage = message.getPayload();
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
