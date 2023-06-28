package com.spring.javaweb1S;

import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.common.LevelToString;
import com.spring.javaweb1S.service.MemberService;
import com.spring.javaweb1S.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	JavaMailSender mailSender;
	
	//로그인 창 불러오기
	@RequestMapping(value = "/login" ,method = RequestMethod.GET)
	public String memberLoginGet() {
		return "member/login";
	}
	
	//로그인 시 계정 확인
	@RequestMapping(value ="/login", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session,Model model,
			@RequestParam(name="mid",defaultValue="",required=false)String mid,
			@RequestParam(name="pwd",defaultValue="",required=false)String pwd
			) {
		MemberVO vo = memberService.getLogin(mid,pwd);
		if(vo==null) {
			return "member/login";
		}
		else { //세션에 로그인 후 필요한 정보를 저장
			LevelToString levelToString = new LevelToString();
			String strLevel = levelToString.levelToString(vo.getLevel());
			
			session.setAttribute("sM_idx", vo.getM_idx());
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName",vo.getNickName());
			session.setAttribute("sLogin","ok");
			session.setAttribute("sSpeed", vo.getSpeed());
			session.setAttribute("sDuration", vo.getDuration());
			session.setAttribute("sGetheight", vo.getGetHeight());
			session.setAttribute("sPoint", vo.getPoint());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			return "redirect:/";
		}
	}
	
	//회원가입 창 불러오기
	@RequestMapping(value = "/signIn", method = RequestMethod.GET)
	public String memberSignInGet() {
		return "member/signIn";
	}
	
	//닉네임 중복체크 메소드
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
	
	//아이디 중복체크 메소드
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
	
	//인증 메일 보내는 메소드
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
	
	//인증코드 비교/확인 메소드
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
	
	//프론트 검사가 끝나면 회원 정보를 DB에 저장
	@RequestMapping(value="/signIn", method = RequestMethod.POST)
	public String signInPost(Model model,MemberVO vo,MultipartFile fName,
			HttpServletRequest request,
			@RequestParam(name="fullmail", defaultValue="",required=false)String email
			) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/memberprofile/");
		String sfName = memberService.fileUpload(fName,realPath);
		vo.setPhoto(sfName);
		vo.setEmail(email);
		System.out.println(vo);
		
		memberService.setMemberSignIn(vo);
		
		return "member/signInOk";
	}
	
	@RequestMapping(value = "/logout",method=RequestMethod.GET)
	public String logoutGet(HttpSession session,Model model) {
		model.addAttribute("logoutFlag", "ok");
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value="/myPage",method=RequestMethod.GET)
	public String myPageGet(HttpSession session,
			Model model
			) {
		int m_idx = (int) session.getAttribute("sM_idx");
		MemberVO mvo = memberService.getM_idxInfo(m_idx);
		
		model.addAttribute("mvo", mvo);
		
		return "member/mypage";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/pwdCheck",method = RequestMethod.POST)
	public String pwdCheckPost(
			@RequestParam(name="pwd",defaultValue="",required=false)String pwd,
			@RequestParam(name="m_idx",defaultValue="",required=false)int m_idx,
			HttpSession session
			) {
		String res= "0";
		boolean check = memberService.getOnlyPwdCheck(m_idx,pwd);
		if(check) res="1";
		session.setAttribute("vFlag", "1");
		
		return res;
	}
	
	@RequestMapping(value="/infoCorrectForm",method=RequestMethod.GET)
	public String infoCorrectFormGet(HttpSession session,Model model) {
		int m_idx = (int) session.getAttribute("sM_idx");
		MemberVO vo = memberService.getM_idxInfo(m_idx);
		model.addAttribute("vo", vo);
		String vFlag = (String) session.getAttribute("vFlag");
		if(vFlag.equals("1")) { //지금 방법대로라면 새로고침시 인증정보날아가는 문제로 불편함이 야기도미 >> 이부분 어떻게 고칠지 생각해보기
			session.setAttribute("vFlag", "0");
			return "member/infoCorrectForm";
		}
		else {
			session.setAttribute("vFlag", "0");
			return "redirect:/";
		}
			
	}
	
	
	
}
