package com.ffunding.web.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.ffunding.web.vo.MemberVO;

@Component("echoHandler")
public class EchoHandler extends TextWebSocketHandler {
	//세션 리스트
	private Map<String, WebSocketSession> users = new ConcurrentHashMap();

    //클라이언트가 연결 되었을 때 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.put(session.getId(), session); 
		log(session.getId()+"님 접속합니다!! 현재 접속자 수:"+users.size());
		
	}
	// 2. 소켓 서버에 메시지 전송시 처리 메서드
	///   하나의 클라이언트가 메서지를 넘겨줄 때 : wsocket.send("msg:"+$("#id").val()+":메시지 전달");
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 1) 특정한 client를 통해 전달해온 메시지를 출력
		log(session.getId()+"에서 온 메시지:"+message.getPayload());
		// 2) 현재 접속한 모든 계정에 메시지 전달
		for(WebSocketSession ws:users.values()) {
			// 1. 각 접속한 클라이언트에게 메시지 전달
			ws.sendMessage(new TextMessage(message.getPayload()));
			log(ws.getId()+"에게 전달 메시지:"+message.getPayload());
		}
	}
	// 3. 소켓 서버 종료시 처리 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 1) 기능 등록자에서 제거 처리
		users.remove(session.getId());
		log(session.getId()+" 접속 종료합니다.");
	}
	// 4. 에러발생시 처리 메서드 
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		 log(session.getId()+"에러 발생! 에러내용"+exception.getMessage());
		 //session.sendMessage( "에러 발생! 에러내용"+exception.getMessage());
	}
	// # 기본 로그 처리
	private void log(String logMsg) {
		System.out.println(new Date()+":"+logMsg);
	}
}
