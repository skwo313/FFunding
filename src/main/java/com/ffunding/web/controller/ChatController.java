package com.ffunding.web.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class ChatController {
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String chatView() throws Exception {
	
		return "chat.page";
	}
}
