package com.spring.javaweb1S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.service.BoardService;
import com.spring.javaweb1S.service.GetherService;
import com.spring.javaweb1S.service.MemberService;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.GetherMemberVO;
import com.spring.javaweb1S.vo.GetherReviewVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.OffendListVO;

@Controller
public class HomeController {
	@Autowired
	BoardService boardService;
	
	@Autowired
	GetherService getherService;
	
	@Autowired
	MemberService memberService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		List<BoardVO> boardList_vos = boardService.getNewBoardList();
		List<BoardVO> boardHotList_vos = boardService.getHotBoardList();
		List<BoardVO> noticeList_vos = boardService.getNoticeList();
		List<BoardVO> newsList_vos = boardService.getNewsList();
		List<GetherReviewVO> getherListVOS = getherService.getGetherFrontReviewList();
		List<GetherMemberVO> longestRiderVOS = getherService.getLongestRider();
		List<GetherMemberVO> fastestRiderVOS = getherService.getfastestRider();
		List<GetherMemberVO> highestRiderVOS = getherService.gethighestRider();
		List<MemberVO> mostBoardVOS = memberService.getMostBoardMember();
		List<MemberVO> mostReplyVOS = memberService.getMostReplyMember();
		List<MemberVO> mostGetherReviewVOS = getherService.getMostGetherReviewMember();
		
		System.out.println(noticeList_vos);
		
		model.addAttribute("MGRVOS", mostGetherReviewVOS);
		model.addAttribute("MRVOS", mostReplyVOS);
		model.addAttribute("MBVOS", mostBoardVOS);
		model.addAttribute("HR", highestRiderVOS);
		model.addAttribute("FR", fastestRiderVOS);
		model.addAttribute("LLR", longestRiderVOS);
		model.addAttribute("getherListVOS", getherListVOS);
		model.addAttribute("noticeList_vos", noticeList_vos);
		model.addAttribute("newsList_vos",  newsList_vos);
		model.addAttribute("boardHotList_vos", boardHotList_vos);
		model.addAttribute("boardList_vos", boardList_vos);
		return "home";
	}
	
	@RequestMapping(value="/unusualapproach", method = RequestMethod.GET)
	public String usualApproachGet() {
		return "unusualApproach";
	}
	
	@RequestMapping(value="/badUser", method = RequestMethod.GET)
	public String badUserGet(HttpSession session) {
		session.invalidate();
		return "badUser";
	}
	
	@RequestMapping(value="/banUser", method = RequestMethod.GET)
	public String banUserGet(HttpSession session) {
		session.invalidate();
		return "banUser";
	}
	
	@RequestMapping(value = "/clearUser", method= RequestMethod.GET)
	public String clearUserGet(HttpSession session) {
		session.invalidate();
		return "clearUser";
	}
	
	@RequestMapping(value="/boardAbuseUser/{rule_idx}", method = RequestMethod.GET)
	public String boardAbuseUserGet(HttpSession session,Model model,
			@PathVariable("rule_idx") int rule_idx
			) {
		int m_idx = (int)session.getAttribute("sM_idx");
		OffendListVO offendvo = boardService.getBoardAbuseInfo(rule_idx,m_idx);
		
		model.addAttribute("offendvo", offendvo);
		if(offendvo == null)return "redirect:/";
		return "boardAbuseUser";
	}
	
	
	@RequestMapping(value ="tempImage")
	public void tempImageGet(MultipartFile upload, HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		//저장할 폴더의 실제 경로를 찾고 파일의 이름을 유일성을 가지게 변환한다.
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/boardTemp/");
		String ofName = upload.getOriginalFilename();
		
		UUID uid = UUID.randomUUID();
		String strUid = uid.toString().substring(0,6);
		ofName = strUid+"_"+ofName;
		
		//ck에디터에서 전송한 파일을 서버의 파일시스템에 저장 처리한다.
		byte[] bytes = upload.getBytes();
		
		FileOutputStream fos = new FileOutputStream(new File(realPath+ofName));
		fos.write(bytes);
		
		//서버 파일 시스템에 저장되어 있는 그림파일을 브라우저 편집화면(text area)에 보여주는 처리
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath()+"/boardTemp/"+ofName; //servletContext에 지정된 경로는 실제 경로와 다르기 때문에 이렇게 저장.
		out.println("{\"orginalFilename\":\""+ofName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		fos.close();
	}
	
	
	@RequestMapping(value ="tempGetherImage")
	public void tempGetherImageGet(MultipartFile upload, HttpServletRequest request,HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		//저장할 폴더의 실제 경로를 찾고 파일의 이름을 유일성을 가지게 변환한다.
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/getherTemp/");
		String ofName = upload.getOriginalFilename();
		
		UUID uid = UUID.randomUUID();
		String strUid = uid.toString().substring(0,6);
		ofName = strUid+"_"+ofName;
		
		//ck에디터에서 전송한 파일을 서버의 파일시스템에 저장 처리한다.
		byte[] bytes = upload.getBytes();
		
		FileOutputStream fos = new FileOutputStream(new File(realPath+ofName));
		fos.write(bytes);
		
		//서버 파일 시스템에 저장되어 있는 그림파일을 브라우저 편집화면(text area)에 보여주는 처리
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath()+"/getherTemp/"+ofName; //servletContext에 지정된 경로는 실제 경로와 다르기 때문에 이렇게 저장.
		out.println("{\"orginalFilename\":\""+ofName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		fos.close();
	}
	
}
