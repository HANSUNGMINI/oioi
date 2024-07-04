package com.itwillbs.oi.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.itwillbs.oi.service.AuctionService;

@Component
public class PushHandler extends TextWebSocketHandler {

    @Autowired
    private AuctionService auctionService;

    private static final Logger logger = LoggerFactory.getLogger(PushHandler.class);

    List<WebSocketSession> sessions = new ArrayList<>();
    
    Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<String, WebSocketSession>();
    Map<String, WebSocketSession> adminSessions = new HashMap<>();
    private Gson gson = new Gson();
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	String senderId = getUserId(session);
    	boolean isAdmin = session.getAttributes().get("isAdmin") == null ? false : true;
    	System.out.println("흠");
    	
    	 if (senderId != null) {
             logger.info(senderId + " 연결됨");
             userSessions.put(senderId, session);
         } else if (isAdmin) {
             Map<String, Object> map = (Map<String, Object>) session.getAttributes().get("admin");
             adminSessions.put((String) map.get("AD_ID"), session);
         }
    	 
    	 System.out.println("asdddddddddddddddd : " + userSessions);
     }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	System.out.println(message.getPayload());
    	String msg = message.getPayload();
    	Map<String, Object> map = gson.fromJson(msg, Map.class);
    	String type = (String)map.get("type");
    	System.out.println(type);
    	if(type.equals("toAdmin")) {
    		for(WebSocketSession admins : adminSessions.values()) {
    			admins.sendMessage(new TextMessage(msg));
    		}
    	} else if (type.equals("toUsers")) {
    		// 새로운 경매 물품 등록 정보 조회
    		   Map<String, Object> newItem = auctionService.getNewAuctionItems();
               JSONObject jsonItem = new JSONObject();
               jsonItem.put("APD_IMAGE", newItem.get("APD_IMAGE"));
               jsonItem.put("APD_IDX", newItem.get("APD_IDX"));
               jsonItem.put("APD_NAME", newItem.get("APD_NAME"));
               jsonItem.put("APD_REG_DATE", newItem.get("APD_REG_DATE"));
               jsonItem.put("APD_START_PRICE", newItem.get("APD_START_PRICE"));
               jsonItem.put("APD_BUY_NOW_PRICE", newItem.get("APD_BUY_NOW_PRICE"));

               JSONObject notificationMessage = new JSONObject();
               notificationMessage.put("msg", "registAPD");
               notificationMessage.put("item", jsonItem);
               
               for (WebSocketSession user : userSessions.values()) {
            	   System.out.println("유저수 : " + userSessions.size());
            	   System.out.println("asddddddddddddddd2222222d한명의 유저 : " + user);
                   user.sendMessage(new TextMessage(notificationMessage.toString()));
               }
    	}
	}
    	
    

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String senderId = getUserId(session);
        if (senderId != null) {
            logger.info(senderId + " 연결 종료됨");
            userSessions.remove(senderId);
            sessions.remove(session);
        }
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        logger.error(session.getId() + " 에러 발생: " + exception.getMessage());
    }

    private String getUserId(WebSocketSession session) {
        Map<String, Object> httpSession = session.getAttributes();
        String userId = (String) httpSession.get("US_ID");
        return userId == null ? null : userId;
    }

    // 클라이언트에게 알림을 전송하는 메소드
    private void sendNotificationToClient(WebSocketSession session, String message) {
        try {
            session.sendMessage(new TextMessage(message));
        } catch (Exception e) {
            logger.error("알림 전송 실패: " + e.getMessage());
        }
    }
    
    private void sendNotificationToAdmin(WebSocketSession session, String message) {
    	// TODO
    }
}
