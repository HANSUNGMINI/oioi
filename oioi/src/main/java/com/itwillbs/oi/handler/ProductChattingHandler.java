package com.itwillbs.oi.handler;

import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.reflection.SystemMetaObject;
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
import com.itwillbs.oi.vo.ProductChatRoomVO;
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

            ProductChatVO chatMessage = gson.fromJson(jsonMsg, ProductChatVO.class);
            System.out.println("수신된 메세지 : " + chatMessage);
            
            String FROM_ID = chatMessage.getFROM_ID();
            String TO_ID = chatMessage.getTO_ID();
            int PD_IDX = chatMessage.getPD_IDX();
            
            // 수신된 메세지 타입 판별
            if(chatMessage.getType().equals(ProductChatVO.TYPE_INIT)) { // 채팅 페이지 초기 진입 메세지
            	// 기존의 채팅방 목록 조회 후 목록 전송
            	sendMessage(session, chatMessage, true);
            	
            } else if(chatMessage.getType().equals(ProductChatVO.TYPE_INIT_COMPLETE)){
            	
            	// 1. 채팅방 존재 여부 확인
            	Map<String, Object> chatRoom = service.getChatRoom(TO_ID, FROM_ID, PD_IDX);
            	
            	if(chatRoom == null) {
            		System.out.println("채팅방 x ");
            		GenerateRandomCode code = new GenerateRandomCode();
            		// 채팅방 생성
            		chatMessage.setCR_ID(code.getRandomCode(8).toString());
            		
            		// DB 저장
            		List<ProductChatRoomVO> chatRoomList = new ArrayList<ProductChatRoomVO>();
					chatRoomList.add(new ProductChatRoomVO(chatMessage.getCR_ID(), TO_ID , FROM_ID, PD_IDX));
					service.createRoom(chatMessage);
					
					// chatMessage에 message에 '' 설정
					chatMessage.setMsg("");
					chatMessage.setType(ProductChatVO.TYPE_START);
					sendMessage(session, chatMessage, false);
					  
            	} else { // 채팅방 있을 경우
            		
            		// 채팅 내역 출력
            		System.out.println("채팅방 있음");
            		
            		// msg에 US_ID 넣기 (꼼수)
            		chatMessage.setCR_ID((String) chatRoom.get("CR_ID"));
            		chatMessage.setFROM_ID(FROM_ID);
            		chatMessage.setTO_ID(TO_ID);
            		chatMessage.setPD_IDX(PD_IDX);
            		chatMessage.setMsg(session.getAttributes().get("US_ID").toString());
            		chatMessage.setType(ProductChatVO.TYPE_SHOW_CHATMESSAGE);
            		
            		sendMessage(session, chatMessage, true);
            	}
            	
            } else if (chatMessage.getType().equals(ProductChatVO.TYPE_TALK)) {
            	// 채팅방 번호 가져오기
            	Map<String, Object> chatRoom = service.getChatRoom(TO_ID, FROM_ID, PD_IDX);
            	
            	// 채팅방 번호 저장 
            	chatMessage.setCR_ID((String)chatRoom.get("CR_ID"));
            	System.out.println("VO에 저장된 메세지 : " + chatMessage); // ProductChatVO(type=TALK, msg=하이, TO_ID=siyun_9094, FROM_ID=soeunee1, PD_IDX=80, CR_ID=61667950)
            	
            	// DB에 채팅 메세지 저장하기
            	int saveCnt = service.saveChatting(chatMessage);
            	
            	TO_ID = chatMessage.getTO_ID();
            	System.out.println("수신자의 웹소켓세션객체 아이디 " + userSessions.get(TO_ID));
    			
    			if(userSessions.get(TO_ID) != null) {
    				WebSocketSession TO_WS = users.get(userSessions.get(TO_ID));
    				// sendMessage() 메서드 호출하여 메세지 전송 요청
    				sendMessage(TO_WS, chatMessage, false);
    			}
            	
            } else if (chatMessage.getType().equals(ProductChatVO.TYPE_LEAVE)) {
            	// 채팅방 번호 가져오기
            	Map<String, Object> chatRoom = service.getChatRoom(TO_ID, FROM_ID, PD_IDX);
            	
            	// 채팅방 번호 저장 
            	chatMessage.setCR_ID((String)chatRoom.get("CR_ID"));
            	chatMessage.setMsg("");
            	
            	service.removeRoom(chatMessage);
            	chatMessage.setMsg( chatMessage.getFROM_ID() + "님이 대화방을 나가셨습니다");
            	
            	TO_ID = chatMessage.getTO_ID();
            	System.out.println("수신자의 웹소켓세션객체 아이디 " + userSessions.get(TO_ID));
            	
            	// 채팅 종료 신호를 다른 사용자에게도 전달
    			if(userSessions.get(FROM_ID) != null) {
    				WebSocketSession FROM_WS = users.get(userSessions.get(FROM_ID));
    				sendMessage(FROM_WS, chatMessage, true);
    			}
            	
            } else if (chatMessage.getType().equals(ProductChatVO.TYPE_SYS)) {
            }
        }
        
        // 각 웹소켓 세션들에게 메세지 전송
        public void sendMessage(WebSocketSession session, ProductChatVO chat, boolean isToSender) throws Exception{
        	
        	if(isToSender) { // 송신자에게 전송하는 메세지
    			session.sendMessage(new TextMessage(gson.toJson(chat)));
    		} else { // 수신자에게 전송하는 메세지
    			session.sendMessage(new TextMessage(gson.toJson(chat)));
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
            userSessions.put(session.getAttributes().get("US_ID").toString(), "");
            System.out.println("사용자 목록 ( " + userSessions.keySet().size() + "명 ) : " + userSessions);
            
        }
}