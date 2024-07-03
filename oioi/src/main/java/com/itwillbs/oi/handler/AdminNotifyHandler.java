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

import com.itwillbs.oi.service.AdminService;
import com.itwillbs.oi.service.AuctionService;

@Component
public class AdminNotifyHandler extends TextWebSocketHandler {
    @Autowired
    private AuctionService auctionService;
    
    @Autowired
    private AdminService AdminService;

    private static final Logger logger = LoggerFactory.getLogger(AdminNotifyHandler.class);
    List<WebSocketSession> sessions = new ArrayList<>();
    Map<String, WebSocketSession> userSessions = new HashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	Map<String, Object> httpSession = session.getAttributes();
        String senderId = getUserId(session);
        if ((boolean)httpSession.get("isAdmin")) {
            logger.info(senderId + " 연결됨");
            userSessions.put(senderId, session);

            // 웹소켓 연결 시 APD05인 상품이 있는지 조회하여 알림을 클라이언트로 전송
            List<Map<String, Object>> newItems = auctionService.getNewAuctionItems();
            if (!newItems.isEmpty()) {
                JSONArray jsonArray = new JSONArray();
                for (Map<String, Object> item : newItems) {
                    JSONObject jsonItem = new JSONObject();
                    jsonItem.put("APD_IMAGE", item.get("APD_IMAGE"));
                    jsonItem.put("APD_NAME", item.get("APD_NAME"));
                    jsonItem.put("APD_REG_DATE", item.get("APD_REG_DATE"));
                    jsonItem.put("APD_START_PRICE", item.get("APD_START_PRICE"));
                    jsonItem.put("APD_BUY_NOW_PRICE", item.get("APD_BUY_NOW_PRICE"));
                    jsonArray.put(jsonItem);
                }
                sendNotificationToClient(session, jsonArray.toString());
            }
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 클라이언트에서 메시지를 받았을 때 처리할 로직
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
