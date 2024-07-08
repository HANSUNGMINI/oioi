package com.itwillbs.oi.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.oi.handler.PlzDTO;

@Controller
public class ChatBotController {
	
	@RequestMapping(value = "/plz", method = RequestMethod.POST, headers = "Accept=application/json")
	public PlzDTO icandoit(@RequestBody String chatbot) {
	Map<String, String> first = new HashMap<>();
	Map<String, Map> second = new HashMap<>();
	Map<String, List<Map>> third = new HashMap<>();
	first.put("text", "간단한 텍스트요소입니다");
	second.put("simpleText", first);
	List<Map> tmp = new ArrayList<>();
	tmp.add(second);
	
	third.put("outputs", tmp);
	
	PlzDTO plzDTO = new PlzDTO();
	plzDTO.setVersion("2.0");
	plzDTO.setTemplate(third);
	System.out.println("plzDTO = " + plzDTO);
	
	return plzDTO;
	}
	
}
