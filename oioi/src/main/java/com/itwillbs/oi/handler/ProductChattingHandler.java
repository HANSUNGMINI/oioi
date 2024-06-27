package com.itwillbs.oi.handler;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;



public class ProductChattingHandler extends TextWebSocketHandler{
	
	List<WebSocketSession> sessions = new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	
    private static final String  uploadDir = "/resources/upload"; // 파일 저장 경로
	private static final Logger logger = LoggerFactory.getLogger(ProductChattingHandler.class);
	
		//커넥션이 연결 됫을때(접속을 성공했을때마다)
		@Override
		public void afterConnectionEstablished(WebSocketSession session) throws Exception {
			
			// << 세션에 필요한 정보를 저장한다 >> 
			// 현재 대화창을 보내는 사람, 판매자, 물건 아이디
			// 현재 대화창을 보내는 사람 == 판매자일 경우, 후에 DB에 TO_ID에 저장
			// 현재 대화창을 보내는 사람 != 판매자일 경우, 후에 DB에 FROM_ID에 저장
			
			System.out.println("session값 : " + session);
			System.out.println("session.getAttributes()값 전값 : " + session.getAttributes()); // US_NICK=배소금, US_ID=soeunee1
			
			String uri = session.getUri().toString(); 
			System.out.println("uri :" + uri); // ws://localhost:8081/oi/productChat?TO_ID=siyun_9094&PD_IDX=49
			String toId = (String) uri.subSequence(uri.indexOf("=")+1, uri.indexOf("&")); // siyun_9094
			String pdIdx = (String) uri.subSequence(uri.lastIndexOf("=")+1, uri.length()); // 49

			System.out.println("to_id : " + toId + " pdIdx : " + pdIdx); // to_id : siyun_9094 pdIdx : 49
			session.getAttributes().put("TO_ID", toId);
			session.getAttributes().put("PD_IDX", pdIdx);
		    System.out.println("session.getAttributes()값 후값 : " + session.getAttributes()); // US_NICK=배소금, US_ID=soeunee1, TO_ID=siyun_9094, PD_IDX=49
			
			sessions.add(session);
		}
		
		
		// 텍스트
		@Override
	    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { 
			System.out.println("메세지 session값 : " + session + " message : " + message);

			 Map<String, Object> attributes = session.getAttributes();
	        String US_ID = (String) attributes.get("US_ID"); // 세션 아이디 (현재 대화창에 들어와 있는 사람)
	        String TO_ID = (String) attributes.get("TO_ID"); // 판매자 (물건을 올린 사람)
	        String PD_IDX = (String) attributes.get("PD_IDX"); // 물건 아이디
	        
	        System.out.println("세션 아이디 : " + US_ID + " 판매자 아이디 : " + TO_ID + " 물건 아이디 : " + PD_IDX); // 세션 아이디 : soeunee1 판매자 아이디 : siyun_9094 물건 아이디 : 49
			
			String msg = message.getPayload();
		
		}
		
		// 파일 업로드
		@Override
		protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message)  {
//			super.handleTextMessage(session, message);
			
		}

		//커넥션이 끝났을때
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
			System.out.println("연결 해제 session값 : " + session + " status : " + status);
		}

}
