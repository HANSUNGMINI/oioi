package com.itwillbs.oi.handler;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class ReplyEchoHandler extends TextWebSocketHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyEchoHandler.class);
		List<String> sessions = new ArrayList<>();
	
	
		//커넥션이 연결 됫을때(접속을 성공했을때마다)
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			logger.info("Connection Established: " + session);
			System.out.println("afterConnectionEstablished : " + session.getAttributes());
			
			Map<String, Object> attributes = session.getAttributes();
			String US_ID = (String) attributes.get("US_ID");
			
			System.out.println("US_ID : " + US_ID);
			
			// 중복 확인
			if (!sessions.contains(US_ID)) {
			    sessions.add(US_ID);
			}
			System.out.println("확인 : "+sessions.toString());
			
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
			
			String jsonMessage = message.getPayload(); 
			
			session.sendMessage(new TextMessage(jsonMessage));
			
		}
		//커넥션이 끝났을때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		}

}
