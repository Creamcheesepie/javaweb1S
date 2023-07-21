package com.spring.javaweb1S;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb1S.service.GetherService;

@Controller
@RequestMapping("/gether")
public class GetherController {
	@Autowired
	GetherService getherService;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String getherHomeGet() {
		
		return "gether/getherHome";
	}
	
	
}
