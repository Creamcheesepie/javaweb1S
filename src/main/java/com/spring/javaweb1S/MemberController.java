package com.spring.javaweb1S;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb1S.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/login" ,method = RequestMethod.GET)
	public String memberLogiunGet() {
		return "member/login";
	}
}
