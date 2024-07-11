package com.itwillbs.oi.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ChatBotController {
	
//	@GetMapping("chatbot")
//	public String chatBot(HttpSession session, Model model) {
//		
//		String sId = (String) session.getAttribute("sId");
//		
//		return "chat/chat_bot";
//	}
	
	
}

//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import com.itwillbs.oi.handler.PlzDTO;
//import com.itwillbs.oi.vo.KeyboardVO;
//import com.itwillbs.oi.vo.MessageButtonVO;
//import com.itwillbs.oi.vo.MessageVO;
//import com.itwillbs.oi.vo.PhotoVO;
//import com.itwillbs.oi.vo.RequestMessageVO;
//import com.itwillbs.oi.vo.ResponseMessageVO;
//
//@Controller
//public class ChatBotController {
//	
//	@RequestMapping(value = "/keyboard", method = RequestMethod.GET)
//	public KeyboardVO keyboard()
//	{
//		KeyboardVO keyboard=new KeyboardVO(new String[] {"사진", "라벨", "에코메세지"});
//	
//		return keyboard;
//	}
//	
//	@RequestMapping(value = "/message", method = RequestMethod.POST)
//	public ResponseMessageVO message(@RequestBody RequestMessageVO vo)
//	{
//		ResponseMessageVO res_vo=new ResponseMessageVO();
//		MessageVO mes_vo=new MessageVO();
//		
//		if(vo.getContent().equals("메인화면"))
//		{
//			mes_vo.setText("첫 화면을 호출합니다.");
//			
//			KeyboardVO keyboard=new KeyboardVO(new String[] {"사진", "라벨", "에코메세지"});
//			
//			res_vo.setKeyboard(keyboard);
//		}
//		else if(vo.getContent().equals("사진"))
//		{
//			PhotoVO photo=new PhotoVO();
//			
//			photo.setUrl("http://placehold.it/640x480.jpg");
//			photo.setWidth(640);
//			photo.setHeight(480);
//			
//			mes_vo.setPhoto(photo);
//			mes_vo.setText(vo.getContent());
//		}
//		else if(vo.getContent().equals("라벨"))
//		{
//			MessageButtonVO messageButton=new MessageButtonVO();
//			
//			messageButton.setLabel("GITHUB");
//			messageButton.setUrl("https://github.com/sjh836/Spring_KakaoBot_Sample");
//			
//			mes_vo.setMessage_button(messageButton);
//			mes_vo.setText("많은 피드백부탁드립니다! STAR는 개발자를 춤추게 만들어요!");
//		}
//		else //에코메시지
//		{
//			mes_vo.setText(vo.getContent());
//		}
//		
//		res_vo.setMessage(mes_vo);
//		return res_vo;
//	}
//	
//}
