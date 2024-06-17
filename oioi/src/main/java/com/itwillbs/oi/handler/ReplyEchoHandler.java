package com.itwillbs.oi.handler;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ReplyEchoHandler extends TextWebSocketHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyEchoHandler.class);
	
	//커넥션이 연결 됫을때(접속을 성공했을때마다)
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		 logger.info("Connection Established: " + session);
		System.out.println("afterConnectionEstablished : " + session);
	}
	//어떠한 메세지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	}
	//커넥션이 끝났을때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	}

}
