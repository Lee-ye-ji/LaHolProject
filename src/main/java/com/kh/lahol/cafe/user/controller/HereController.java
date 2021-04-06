package com.kh.lahol.cafe.user.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HereController {
	
	private static final Logger logger = LoggerFactory.getLogger(HereController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/cafe/here", method = RequestMethod.GET)
	public String Here(Locale locale, Model model) {
		
		
		return "cafe/user/here";
	}

}
