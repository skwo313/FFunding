package com.ffunding.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("manager")
@Controller
public class ManagerController {
	
	//http://localhost:8000/web/manager/dashboard
	@GetMapping("dashboard")
	public String dashboard() {
		return "manager/dashboard";
	}
}
