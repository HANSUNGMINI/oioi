package com.itwillbs.oi.handler;

import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class ReplyEchoHandler extends TextWebSocketHandler {

    private static final Logger logger = LoggerFactory.getLogger(ReplyEchoHandler.class);
    private static final Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<>());
    private Map<String, String> userSessions = new ConcurrentHashMap<String,String>();
    // 커넥션이 연결됐을 때(접속을 성공했을 때마다)
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String uri = session.getUri().toString();
        String apdIdx = uri.substring(uri.indexOf("APD_IDX=") + "APD_IDX=".length());
        String usId = (String) session.getAttributes().get("US_ID");
        
        
        userSessions.put(session.getId(), usId);
        session.getAttributes().put("APD_IDX", apdIdx);
        sessions.add(session);
        
        System.out.println("session 누구누구있는지 : " + userSessions.toString());
        
        // 접속 메시지
        JsonObject jo = new JsonObject();
        jo.addProperty("type", "ENTER");
        jo.addProperty("msg", ">> " + usId + " 님이 입장하셨습니다 <<");
        jo.addProperty("SESSION_SIZE", getSessionCount(apdIdx));

        broadcastMessage(apdIdx, jo.toString(), session);
        
        // 접속한 사용자에게만 접속자 수 보내기
// 		JsonObject userJo = new JsonObject();
// 		userJo.addProperty("type", "SESSION_SIZE");
// 		
// 		session.sendMessage(new TextMessage(userJo.toString()));
 		
 		//누구누구 접속했는지 확인
 		JsonObject users = new JsonObject();
 		users.addProperty("type", "USER_LIST");
 		users.add("users", new Gson().toJsonTree(userSessions.values()));
 		users.addProperty("SESSION_SIZE", getSessionCount(apdIdx));
 		session.sendMessage(new TextMessage(users.toString()));
    }

    // 어떠한 메시지를 보냈을 때
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        Map<String, Object> attributes = session.getAttributes();
        String US_ID = (String) attributes.get("US_ID");
        String APD_IDX = (String) attributes.get("APD_IDX");
        JsonObject jo = new JsonObject();
        jo.addProperty("type", "TALK");
        jo.addProperty("US_ID", US_ID);
        jo.addProperty("SESSION_SIZE", getSessionCount(APD_IDX));
        jo.addProperty("DATA", message.getPayload());

        String jsonMessage = jo.toString();

        // 메시지를 자신을 제외한 세션에 전송
        for (WebSocketSession sess : sessions) {
            if (sess.isOpen() && APD_IDX.equals(sess.getAttributes().get("APD_IDX")) && !sess.getId().equals(session.getId())) {
                sess.sendMessage(new TextMessage(jsonMessage));
            }
        }
    }

    // 접속/퇴장 메서드
    private void broadcastMessage(String apdIdx, String message, WebSocketSession sessionAlert) throws Exception {
        for (WebSocketSession sess : sessions) {
            if (sess.isOpen() && apdIdx.equals(sess.getAttributes().get("APD_IDX")) && !sess.equals(sessionAlert)) {
                sess.sendMessage(new TextMessage(message));
            }
        }
    }

    private int getSessionCount(String APD_IDX) {
        int count = 0;
        for (WebSocketSession sess : sessions) {
            if (APD_IDX.equals(sess.getAttributes().get("APD_IDX"))) {
                count++;
            }
        }
        return count;
    }

    // 커넥션이 끝났을 때
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String apdIdx = (String) session.getAttributes().get("APD_IDX");
        String usId = (String) session.getAttributes().get("US_ID");
        sessions.remove(session);
        userSessions.remove(session.getId());
        // 퇴장 메시지
        JsonObject jo = new JsonObject();
        jo.addProperty("type", "LEAVE");
        jo.addProperty("msg", ">> " + usId + " 님이 퇴장하셨습니다 <<");
        jo.addProperty("SESSION_SIZE", getSessionCount(apdIdx));

        broadcastMessage(apdIdx, jo.toString(), session);
    }
}