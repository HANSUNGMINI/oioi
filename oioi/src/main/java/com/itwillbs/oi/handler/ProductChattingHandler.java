package com.itwillbs.oi.handler;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.itwillbs.oi.service.ChattingService;
import com.itwillbs.oi.vo.ProductChatVO;


public class ProductChattingHandler extends TextWebSocketHandler{
    
		@Autowired
		private ChattingService service;
	
        private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>(); // 현재 들어와 있는 세션 정보 
        private Map<String, String> userSessions = new ConcurrentHashMap<String, String>(); // 저장된 세션 정보들
        private Gson gson = new Gson();
        
        //커넥션이 연결 됫을때(접속을 성공했을때마다)
        @Override
        public void afterConnectionEstablished(WebSocketSession session) throws Exception {
            
            users.put(session.getId(), session);
            System.out.println("클라이언트 목록 ( " + users.keySet().size() + " 명)");
            
            System.out.println("세션 아이디 : " + session.getAttributes().get("US_ID"));
            // Map 객체(userSessions) 에 사용자 정보 저장
            userSessions.put(session.getAttributes().get("US_ID").toString(), session.getId());
            System.out.println("사용자 목록 ( " + userSessions.keySet().size() + "명 ) : " + userSessions);
        }
        
        
        // 텍스트
        @Override
        public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { 
            
            String jsonMsg = message.getPayload();
            System.out.println("전송받은 메세지의 payload : " + jsonMsg); // {"type":"TALK","msg":"ㅎㅇ"} 
            
            ProductChatVO chat = gson.fromJson(jsonMsg, ProductChatVO.class); // 

            System.out.println("chat >>> " + chat);
            sendMessage(session, chat);
        
        }
        
        // 각 웹소켓 세션들에게 메세지 전송
        public void sendMessage(WebSocketSession session, ProductChatVO chat) {
            // 각 세션에 메세지 전송
//          System.out.println(chat); ProductChatVO(type=TALK, msg=ㅎㅇ)
//          System.out.println(gson.toJson(chat)); {"type":"TALK","msg":"ㅎㅇ"}
            
            for(WebSocketSession ws : users.values()) {
                if(!ws.getId().equals(session.getId())) {
                    // [1. 메세지 타입 판별]
                    
                    // send() 메서들 호출하여 메세지 전송 --> ChatMessageVO 객체를 JSON 문자열 형식으로 변환 후 전송
                    // ( Gson 객체의 toJson() 메서드 활용)
                    try { ws.sendMessage(new TextMessage(gson.toJson(chat))); } catch (IOException e) {e.printStackTrace();}
                }
            }
        }
        
        // 파일 업로드
        @Override
        protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message)  {
//          super.handleTextMessage(session, message);
            
        }
        
        //커넥션이 끝났을때
        @Override
        public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
            System.out.println("연결 해제 session값 : " + session + " status : " + status);
            
            users.remove(session.getId());
            System.out.println("클라이언트 목록 : " + users.keySet().size() + " 명");
            
            // 사용자 정보 저장된 Map 객체 (userSession) 내에서 종료 요청이 발생한 웹소켓의 세션 아이디 제거
            // (HttpSession의 세션 아이디는 유지)
            userSessions.put(session.getAttributes().get("id").toString(), "");
            System.out.println("사용자 목록 ( " + userSessions.keySet().size() + "명 ) : " + userSessions);
        }
}