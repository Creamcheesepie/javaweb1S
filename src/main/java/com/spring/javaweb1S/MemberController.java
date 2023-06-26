package com.spring.javaweb1S;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb1S.service.MemberService;
import com.spring.javaweb1S.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value = "/login" ,method = RequestMethod.GET)
	public String memberLogiunGet() {
		return "member/login";
	}
	
	@RequestMapping(value = "/signIn", method = RequestMethod.GET)
	public String memberSignInGet() {
		return "member/signIn";
	}
	
	@ResponseBody
	@RequestMapping(value ="/nickNameCheck",method=RequestMethod.POST)
	public String nickNameCheckPost(String nickName) {
		String res =""; 
		MemberVO vo = memberService.getNickSearch(nickName);
		
		 if(vo!=null) {
			 res="1";
		 }
		 else res="0";
		 
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value ="/midCheck",method=RequestMethod.POST)
	public String midCheckPost(String mid) {
		String res =""; 
		MemberVO vo = memberService.getMidSearch(mid);
		
		if(vo!=null) {
			res="1";
		}
		else res="0";
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/sendVerificationEmail", method=RequestMethod.POST)
	public String sendVerificationEmailPost(String email,HttpSession session) throws MessagingException {
		String verCode = UUID.randomUUID().toString().substring(0, 6);
		String res="";
		
		String toMail = email;
		String title = "본인인증 메일입니다.";
		String content = "<h2>본인인증 코드입니다</h2><hr/>"+verCode+"<hr/>이 코드를 인증 창에 입력해 주시기 바랍니다."	;
		
		
		//메일 전송을위한 객체 2개
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content,true);
		
		mailSender.send(message);
		//이메일을 전송하고 나면 인증 코드를 세션에 저장한다.
		session.setAttribute("verCode", verCode);
		session.setMaxInactiveInterval(300);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/verCodeCheck", method=RequestMethod.POST)
	public String verCodeCheck(String verCode, HttpSession session) {
		String res="1";
		
		String sCode =(String)session.getAttribute("verCode");
		if(verCode.equals(sCode)) {
			res="2";
		}

		return res;
	}
	
	
	
	
	
}
