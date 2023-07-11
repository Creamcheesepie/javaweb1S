package com.spring.javaweb1S;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/message")
public class MessageController {
	
	@RequestMapping(value = "/home", method=RequestMethod.GET)
	public String messageHomeGet() {
		
		return "message/messageList";
	}
	
}
