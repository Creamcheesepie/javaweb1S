package com.spring.javaweb1S;

import java.util.List;
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

import com.spring.javaweb1S.common.JavaProvide;
import com.spring.javaweb1S.common.LevelToString;
import com.spring.javaweb1S.service.MemberService;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.DomainVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.ReplyVO;

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
			@RequestParam(name="pwd",defaultValue="",required=false)String pwd,
			@RequestParam(name="from",defaultValue="",required=false)String from
			) {
		MemberVO vo = memberService.getLogin(mid,pwd);
		if(vo==null) {
			model.addAttribute("loginFail", "로그인 실패! 아이디 또는 비밀번호를 확인해 주세요.");
			return "member/login";
		}
		else { //세션에 로그인 후 필요한 정보를 저장
			//임시정지 대상과 정지대상 회원은 session에 정보를 저장하지 않고 내보냄.
			if(vo.getLevel() == 5) return "redirect:/badUser";
			if(vo.getLevel() == 6) return "redirect:/banUser";
		
			
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
			
			if(!from.equals("")) {
				System.out.println(from);//왜 , 가 들어오는지????
				from = from.substring(0, from.length()-1);
				System.out.println(from);
			}
			
			if(from.equals("attendanceList")) {
				return "redirect:/attendance/list";
			}
			else {
				return "redirect:/";
			}
		}
	}
	
	//회원가입 창 불러오기
	@RequestMapping(value = "/signIn", method = RequestMethod.GET)
	public String memberSignInGet(Model model) {
		List<DomainVO> domain_vos = memberService.getDomainlist();
		model.addAttribute("domain_vos",domain_vos);
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
	public String sendVerificationEmailPost(String emailName,String dom_idx,HttpSession session) throws MessagingException {
		int dom_idx_ = Integer.parseInt(dom_idx);
		MemberVO vo = memberService.getEmailNameSearch(emailName,dom_idx_);
		String res="0";
		if(vo!=null) {
			res="1";
		}
		else {
			
			String domain= memberService.getDomainDom_idx(dom_idx_);
			String verCode = UUID.randomUUID().toString().substring(0, 6);
			/*
			String toMail = emailName+domain;
			String title = "본인인증 메일입니다.";
			String content = "<h2>본인인증 코드입니다</h2><hr/>"+verCode+"<hr/>이 코드를 인증 창에 입력해 주시기 바랍니다."	;
			
			
			//메일 전송을위한 객체 2개
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content,true);
			
			mailSender.send(message);
			*/
			//이메일을 전송하고 나면 인증 코드를 세션에 저장한다.
			System.out.println(verCode);
			session.setAttribute("verCode", verCode);
			session.setMaxInactiveInterval(300);
		}
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
			HttpServletRequest request
			) {
		System.out.println(vo);
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/memberprofile/");
		String sfName = memberService.fileUpload(fName,realPath);
		vo.setPhoto(sfName);
		
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
		String domain = memberService.getDomainDom_idx(mvo.getDom_idx());
		List<BoardVO> boardVOS = memberService.getMyPageBoardList(m_idx);
		List<ReplyVO> replyVOS = memberService.getMyPageReplyList(m_idx);
		
		model.addAttribute("replyVOS", replyVOS);
		model.addAttribute("boardVOS", boardVOS);
		model.addAttribute("domain", domain);
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
	
	//정보 수정 폼 접근하기
	@RequestMapping(value="/infoCorrectForm",method=RequestMethod.GET)
	public String infoCorrectFormGet(HttpSession session,Model model) {
		String vFlag = (String) session.getAttribute("vFlag");
		if(vFlag.equals("1")) { //지금 방법대로라면 새로고침시 인증정보날아가는 문제로 불편함이 야기됨 >> 이부분 어떻게 고칠지 생각해보기
			session.setAttribute("vFlag", "0");
			int m_idx = (int) session.getAttribute("sM_idx");
			MemberVO vo = memberService.getM_idxInfo(m_idx);
			List<DomainVO> domain_vos= memberService.getDomainlist();
			JavaProvide javaProvide = new JavaProvide();
			
			String strAddress = javaProvide.splitArrMakeOneString(vo.getAddress(), "/");
			
			model.addAttribute("address", strAddress);
			model.addAttribute("domain_vos",domain_vos);
			model.addAttribute("vo", vo);
			return "member/infoCorrectForm";
		}
		else {
			session.setAttribute("vFlag", "0");
			return "unusualApproach";
		}
	}
	
	//닉네임 변경
	@ResponseBody
	@RequestMapping(value = "/nickNameChange",method=RequestMethod.POST)
	public int nickNameChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="nickName",defaultValue="",required=false)String nickName
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setNickName(nickName);
		int res = memberService.setMemberNickNameUpdate(vo);
		return res;
	}
	
	//이름 변경
	@ResponseBody
	@RequestMapping(value="/nameChange",method=RequestMethod.POST)
	public void nameChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="name",defaultValue="",required=false)String name
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setName(name);
		memberService.setMemberNameUpdate(vo);
	}
	
	// 나이 변경
	@ResponseBody
	@RequestMapping(value="/ageChange",method=RequestMethod.POST)
	public void ageChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="age",defaultValue="",required=false)int age
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setAge(age);
		memberService.setMemberAgeUpdate(vo);
	}
	
	//성별 변경
	@ResponseBody
	@RequestMapping(value="/genderChange",method=RequestMethod.POST)
	public void genderChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="gender",defaultValue="",required=false)String gender
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setGender(gender);
		memberService.setMembergenderUpdate(vo);
	}
	
	//인증코드 비교/확인 후 이메일 변경
	@ResponseBody
	@RequestMapping(value="/emailChange", method=RequestMethod.POST)
	public String emailChange(String verCode, HttpSession session,
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="dom_idx",defaultValue="0",required=false)int dom_idx,
			@RequestParam(name="emailName",defaultValue="0",required=false)String emailName
			) {
		String res="1";
		MemberVO vo = new MemberVO();
		
		vo.setM_idx(m_idx);
		vo.setDom_idx(dom_idx);
		vo.setEmailName(emailName);
		
		String sCode =(String)session.getAttribute("verCode");
		if(verCode.equals(sCode)) {
			memberService.setMemberEmailUpdate(vo);
			res="2";
		}
		return res;
	}
	
	//전화번호 변경
	@ResponseBody
	@RequestMapping(value="/telChange",method=RequestMethod.POST)
	public void telChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="tel",defaultValue="",required=false)String tel
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setTel(tel);
		memberService.setMemberTelUpdate(vo);
	}
	
	//생일 변경
	@ResponseBody
	@RequestMapping(value="/birthdayChange",method=RequestMethod.POST)
	public void birthdayChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="birthday",defaultValue="",required=false)String birthday
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setBirthday(birthday);
		memberService.setMemberBirthdayUpdate(vo);
	}
	
	//자기소개 변경
	@ResponseBody
	@RequestMapping(value="/instChange",method=RequestMethod.POST)
	public void instChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="inst",defaultValue="",required=false)String inst
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setInst(inst);
		memberService.setMemberInstUpdate(vo);
	}
	
	//주소변경
	@ResponseBody
	@RequestMapping(value="/addressChange",method=RequestMethod.POST)
	public void addressChangePost(
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx,
			@RequestParam(name="address",defaultValue="",required=false)String address
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setAddress(address);
		memberService.setMemberAddressUpdate(vo);
	}
	
	//전화번호 변경
	@RequestMapping(value="/photoChange",method=RequestMethod.POST)
	public String photoChangePost(MultipartFile fName,HttpServletRequest request) {
	 String realPath = request.getSession().getServletContext().getRealPath("/resources/data/memberprofile/");
	 String sfName = memberService.fileUpload(fName, realPath);
	 int m_idx = (int) request.getSession().getAttribute("sM_idx");
	 
	 memberService.setMemberPhotoUpdate(m_idx,sfName);
	
	 request.getSession().setAttribute("vFlag", "1");
		return "redirect:/member/infoCorrectForm";
	}
	
	//비밀번호 변경
	@RequestMapping(value="/pwdChange",method=RequestMethod.POST)
	public String pwdChangePost(Model model,HttpSession session) {
		int m_idx = (int) session.getAttribute("sM_idx");
		MemberVO emailInfoVo = memberService.getEmailNameByM_idx(m_idx); 
		
		model.addAttribute("emailInfoVo", emailInfoVo);
		return "member/pwdChangeForm";
	}
	
	@RequestMapping(value="/pwdChange",method=RequestMethod.GET)
	public String pwdChangeGet() {
		return "unusualApproach";
	}
	
	@ResponseBody
	@RequestMapping(value = "sendPwdVerificationEmail",method=RequestMethod.POST)
	public String sendPwdVerificationEmailPost(HttpSession session,
			@RequestParam(name="emailName",defaultValue="",required=false)String emailName,
			@RequestParam(name="dom_idx",defaultValue="0",required=false)int dom_idx
			) throws MessagingException {
		String domain= memberService.getDomainDom_idx(dom_idx);
		String verCode = UUID.randomUUID().toString().substring(0, 6);
		
		String toMail = emailName+domain;
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
		
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value="pwdChangeCheck",method=RequestMethod.POST)
	public String pwdChangeCheckPost(HttpSession session,
			@RequestParam(name="pwd",defaultValue="",required=false)String pwd,
			@RequestParam(name="m_idx",defaultValue="0",required=false)int m_idx
			) {
		MemberVO vo = new MemberVO();
		vo.setM_idx(m_idx);
		vo.setPwd(pwd);
		memberService.setMemberPwdUpdate(vo);
		session.invalidate();
		
		return "1";
	}
	
	
}
