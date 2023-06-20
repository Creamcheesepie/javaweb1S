package com.spring.javaweb1S;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.javaweb1S.service.MemberService;

@Controller
@RequestMapping("member/")
public class MemberController {
	@Autowired
	MemberService memberService;
}
