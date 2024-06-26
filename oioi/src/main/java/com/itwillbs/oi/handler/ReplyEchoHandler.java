package com.itwillbs.oi.handler;


import java.io.StringReader;
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
			System.out.println("session.getAttributes()값 전값 : " + session.getAttributes());
			
			String uri = session.getUri().toString();
		    String apdIdx = uri.substring(uri.indexOf("APD_IDX=") + "APD_IDX=".length());
		    System.out.println("session에 넣을 apdIdx 값 : " + apdIdx);
		    session.getAttributes().put("APD_IDX", apdIdx);
		    System.out.println("session.getAttributes()값 전후값 : " + session.getAttributes());
			sessions.add(session);
			
		}
		//어떠한 메세지를 보냈을때
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
			
	        Map<String, Object> attributes = session.getAttributes();
	        String US_ID = (String) attributes.get("US_ID");
	        String APD_IDX = (String) attributes.get("APD_IDX");
	        
	        System.out.println("handleTextMessage(message) : " + message.getPayload());
	        
	        // 받은 메시지를 동일한 APD_IDX를 가진 세션에만 응답으로 보냄
	        JsonObject jo = new JsonObject();
	        jo.addProperty("US_ID", US_ID);
	        jo.addProperty("SESSION_SIZE", getSessionCountApdIdx(APD_IDX)); 
	        jo.addProperty("DATA", message.getPayload());
	        
	        System.out.println("보내기전 sessions 수  : " + sessions.toString());
	        String jsonMessage = jo.toString();
	        
	        for (WebSocketSession sess : sessions) {
	            if (sess.isOpen() && APD_IDX.equals(sess.getAttributes().get("APD_IDX"))) {
	                sess.sendMessage(new TextMessage(jsonMessage));
	            }
	        }
			
		}
		private int getSessionCountApdIdx(String APD_IDX) {
			int count = 0;
	        for (WebSocketSession sess : sessions) {
	            if (APD_IDX.equals(sess.getAttributes().get("APD_IDX"))) {
	                count++;
	            }
	        }
	        return count;
		}
		//커넥션이 끝났을때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			System.out.println("종료");
			//방나가면 세션삭제
			sessions.remove(session);
		}

}
