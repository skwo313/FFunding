package com.ffunding.web.controller;

import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ffunding.web.service.HomeService;

@Controller
public class HomeController {

	@Inject
	HomeService service;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) throws Exception {

		logger.info("Welcome home! The client locale is {}.", locale);
		model.addAttribute("sellRank", service.sellRank());
		model.addAttribute("goalRank", service.goalRank());
		model.addAttribute("expected", service.expected());
		return "home.page";
	}

}
