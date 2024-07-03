package com.itwillbs.oi.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.itwillbs.oi.service.AuctionService;
import com.mysql.cj.protocol.x.SyncFlushDeflaterOutputStream;

@Component
public class PushHandler extends TextWebSocketHandler {

    @Autowired
    private AuctionService auctionService;

    private static final Logger logger = LoggerFactory.getLogger(PushHandler.class);

    List<WebSocketSession> sessions = new ArrayList<>();
    Map<String, WebSocketSession> userSessions = new HashMap<>();
    Map<String, WebSocketSession> adminSessions = new HashMap<>();

    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	String senderId = getUserId(session);
    	boolean isAdmin = session.getAttributes().get("isAdmin") == null ? false : true;
    	
        if (senderId != null) {
            logger.info(senderId + " 연결됨");
            userSessions.put(senderId, session);

            // 웹소켓 연결 시 최신 3개의 APD05인 상품이 있는지 조회하여 알림을 클라이언트로 전송
            List<Map<String, Object>> newItems = auctionService.getNewAuctionItems();
            
            // 최신순 3개까지만 출력
            int count = 0;
            JSONArray jsonArray = new JSONArray();
            for (Map<String, Object> item : newItems) {
                JSONObject jsonItem = new JSONObject();
                jsonItem.put("APD_IMAGE", item.get("APD_IMAGE"));
                jsonItem.put("APD_NAME", item.get("APD_NAME"));
                jsonItem.put("APD_REG_DATE", item.get("APD_REG_DATE"));
                jsonItem.put("APD_START_PRICE", item.get("APD_START_PRICE"));
                jsonItem.put("APD_BUY_NOW_PRICE", item.get("APD_BUY_NOW_PRICE"));
                jsonArray.put(jsonItem);
                
                count++;
                if (count >= 3) {
                    break;
                }
            }
                sendNotificationToClient(session, jsonArray.toString());
            } else if (isAdmin) {
            	adminSessions.put("admin", session);
            }
        }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	String msg = message.getPayload();
    	
    	if(msg.equals("moreReport")) {
    		for(WebSocketSession admins : adminSessions.values()) {
        		admins.sendMessage(new TextMessage("report"));
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
}
