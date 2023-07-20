package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.MessageService;
import com.spring.javaweb1S.vo.AskVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReportVO;

@Controller
@RequestMapping("/message")
public class MessageController {
	@Autowired
	MessageService messageService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/home", method=RequestMethod.GET)
	public String messageHomeGet(HttpSession session, Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
			) {
		int blockSize=5;
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		if(m_idx==0) return "redirect:/";
		PageVO pageVO = pageProcess.pageProcesserAllmessage(nowPage,pageSize,blockSize,m_idx);
		
		List<MessageVO> message_vos = messageService.getAllMessageList(pageVO,m_idx);
		
		
		model.addAttribute("message_vos", message_vos);
		return "message/messageList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getSendMessage", method=RequestMethod.POST)
	public MessageVO getSendMessagePost(
			@RequestParam(name="msg_idx", defaultValue="0",required=false)int msg_idx
			){
		MessageVO vo = messageService.getSendMessage(msg_idx);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getReceiveMessage", method=RequestMethod.POST)
	public MessageVO getReceiveMessagePost(
			@RequestParam(name="msg_idx", defaultValue="0",required=false)int msg_idx
			){
		MessageVO vo = messageService.getReceiveMessage(msg_idx);
		return vo;
	}
	
	@RequestMapping(value = "/openWrite", method=RequestMethod.GET)
	public String messageWriteWindowOpenGet(Model model){
		List<MessageVO> msg_categoryVOS = messageService.getMessageCategoryList();
		
		model.addAttribute("msg_categoryVOS", msg_categoryVOS);
		return "message/messageWriteWindow";
	}
	
	@RequestMapping(value = "/openWriteInComunity",method = RequestMethod.GET)
	public String messageWriteWindowInComunityOpenGet(Model model,
			@RequestParam(name="receive_m_idx",defaultValue="",required=false)int receive_m_idx,
			@RequestParam(name="nickName",defaultValue="",required=false) String nickName
			){
		List<MessageVO> msg_categoryVOS = messageService.getMessageCategoryList();
		
		model.addAttribute("receive_m_idx", receive_m_idx);
		model.addAttribute("nickName", nickName);
		model.addAttribute("msg_categoryVOS", msg_categoryVOS);
		return "message/messageWriteWindowInComunity";
	}
	
	@ResponseBody
	@RequestMapping(value = "/receiverSearch",method=RequestMethod.POST)
	public List<MemberVO> getMessageReceiverSearchList(
			@RequestParam(name="searchOption",defaultValue="",required=false)String searchOption,
			@RequestParam(name="searchStr",defaultValue="",required=false)String searchStr
			){
		List<MemberVO> vos = messageService.getMessageReceiverSearchList(searchOption,searchStr);
		System.out.println(vos);
		return vos;
	}
	
	@RequestMapping(value="/send",method=RequestMethod.POST)
	public String messageSendGet(MessageVO msg_vo,Model model,
			@RequestParam(name="answerCheck",defaultValue="0",required=false) int answerCheck
			) {
		messageService.setSendMessage(msg_vo);
		
		
		model.addAttribute("sendedSw", "ok");
		if (answerCheck==1) return "message/messageAnswerWindow";
		else return "message/messageWriteWindow";
	}
	
	@RequestMapping(value = "/sendList", method=RequestMethod.GET)
	public String messageSendList(Model model, HttpSession session,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
			) {
		int blockSize=5;
		int m_idx = (int)session.getAttribute("sM_idx");
		
		PageVO pageVO = pageProcess.pageProcesserByM_idx("message2", nowPage, pageSize,blockSize,m_idx);
		List<MessageVO> message_vos = messageService.getMessageSendList(m_idx, pageVO);
		
		model.addAttribute("message_vos", message_vos);
		model.addAttribute("pageVO", pageVO);
		return "message/messageSendList";
	}
	
	@RequestMapping(value = "/receiveList", method=RequestMethod.GET)
	public String messageReceiveListGet(Model model, HttpSession session,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
			) {
		int blockSize=5;
		int m_idx = (int)session.getAttribute("sM_idx");
		
		PageVO pageVO = pageProcess.pageProcesserByM_idxReceive(nowPage, pageSize,blockSize,m_idx);
		List<MessageVO> message_vos = messageService.getMessageReceiveList(m_idx, pageVO);
		
		model.addAttribute("message_vos", message_vos);
		model.addAttribute("pageVO", pageVO);
		return "message/messageReceiveList";
	}
	
	@RequestMapping(value = "/openAnswer/{msg_idx}",method = RequestMethod.GET)
	public String messageAnswerOpenGet(Model model,
			@PathVariable("msg_idx")int msg_idx
			) {
		MessageVO messageVO = messageService.getSenderInfo(msg_idx);
		
		model.addAttribute("messageVO", messageVO);
		return "message/messageAnswerWindow";
	}
	
	@RequestMapping(value = "/reportList",method=RequestMethod.GET)
	public String messageReportListGet(HttpSession session, Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize			
			) {
		int blockSize = 5;
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		PageVO pageVO = pageProcess.pageProcesserByM_idx("report2", nowPage, pageSize, blockSize, m_idx);
		List<ReportVO> report_vos = messageService.getReportList(m_idx, pageVO);
		
		model.addAttribute("report_vos", report_vos);
		model.addAttribute("pageVO", pageVO);
		return "message/reportList";
	}
	
	@RequestMapping(value = "/reportWindow/{tableName}/{idx}",method = RequestMethod.GET)
	public String messageReportWindowOpenGet(Model model,
			@PathVariable("tableName") String tableName,
			@PathVariable("idx")int idx,
			@RequestParam(name="title",defaultValue="",required=false)String title
			) {
		List<ReportVO> categoryVOS = messageService.getReportCategoryList(tableName);
		System.out.println(categoryVOS);
		
		model.addAttribute("reported_idx", idx);
		model.addAttribute("title", title);
		model.addAttribute("categoryVOS", categoryVOS);
		return "message/reportWriteWindow";
	}
	
	@RequestMapping(value = "/reportSend",method= RequestMethod.POST)
	public String messageReportSendPost(ReportVO reportVO, Model model) {
		messageService.setSendReport(reportVO);
		model.addAttribute("sendedSw", "ok");
		return "message/reportWriteWindow";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMyReport",method = RequestMethod.POST)
	public ReportVO messgeGetmyReportPost(
			@RequestParam(name="rep_idx",defaultValue="",required=false)int rep_idx
			) {
		ReportVO reportVO = messageService.getMyReport(rep_idx);
		System.out.println(reportVO);
		return reportVO;
	}
	
	@RequestMapping(value = "/friendInvite/{m_idx}",method = RequestMethod.GET)
	public String messageFriendInviteFormGet(Model model,
			@PathVariable("m_idx")int m_idx,
			@RequestParam(name="title",defaultValue="",required=false)String title
			) {
		model.addAttribute("t_idx",m_idx);
		model.addAttribute("title", title);
		return "message/friendInvite";
	}
	
	//친구초대 보내기:  1. 친구 리스트에 있는 사람인지 여부 확인 이미 친구인 경우? 2. 친구 리스트에 등재 3.친구 신청 쪽지 보내기
	@ResponseBody
	@RequestMapping(value="/friendInviteSend", method = RequestMethod.POST)
	public int messageFriendInviteSendPost(Model model,HttpSession session,
			@RequestParam(name="content", defaultValue="",required=false)String content,
			@RequestParam(name="t_idx", defaultValue="", required=false)int t_idx
			) {
		int res= 0;
		int m_idx = (int)session.getAttribute("sM_idx");
		boolean friendChecker = messageService.getFriendCheck(m_idx,t_idx);
		
		if(friendChecker){
			res=1;
		}
		else {
			messageService.setFriendInvitation(m_idx,t_idx,content);
			messageService.setFrienInviteMessageSend(m_idx,t_idx,content);
		}

		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/friendInviteAnswer", method = RequestMethod.POST)
	public int messageFriendInviteAnswerPost(HttpSession session,
			@RequestParam(name="t_idx",defaultValue="0",required=false) int t_idx,
			@RequestParam(name="msg_idx",defaultValue="0",required=false) int msg_idx,
			@RequestParam(name="ans",defaultValue="0",required=false) int ans
			) {
		int res=0;
		int m_idx = (int)session.getAttribute("sM_idx");
		String nickName = (String)session.getAttribute("sNickName");
		res = messageService.setFriendInviteAnswer(ans,msg_idx,t_idx,m_idx,nickName);
		
		return res;
	}
	
	@RequestMapping(value = "/setBanUser/{m_idx}",method = RequestMethod.GET)
	public String messagebanInviteFormGet(Model model,
			@PathVariable("m_idx")int m_idx,
			@RequestParam(name="title",defaultValue="",required=false)String title
			) {
		model.addAttribute("t_idx",m_idx);
		model.addAttribute("title", title);
		return "message/setBanUser";
	}
	
	@ResponseBody
	@RequestMapping(value="/setBanUserSend", method = RequestMethod.POST)
	public int messagesetBanUserSendPost(Model model,HttpSession session,
			@RequestParam(name="content", defaultValue="",required=false)String content,
			@RequestParam(name="t_idx", defaultValue="", required=false)int t_idx
			) {
		int res= 0;
		int m_idx = (int)session.getAttribute("sM_idx");
		boolean banChecker = messageService.getBanCheck(m_idx,t_idx);
		
		if(banChecker){
			res=1;
			return res;
		}
		else {
			messageService.setBanUser(m_idx,t_idx,content);
		}
		
		model.addAttribute("sendedSw", "ok");
		return res;
	}
	
	@RequestMapping(value = "/askList", method=RequestMethod.GET)
	public String messageGetAskListGet(HttpSession session, Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
			) {
		int blockSize = 5;
		int m_idx = (int)session.getAttribute("sM_idx");
		PageVO pageVO = pageProcess.pageProcesserByM_idx("ask2", nowPage, pageSize,blockSize , m_idx);
		
		List<AskVO> ask_vos = messageService.getMyAskList(m_idx,pageVO);
		System.out.println(ask_vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("ask_vos", ask_vos);
		return "message/askList";
	}
	
	@RequestMapping(value = "/openAskForm",method=RequestMethod.GET)
	public String messageGetAskWindowOpenGet(Model model) {
		List<AskVO> ask_categoryVOS = messageService.getAskCategoryList();
		model.addAttribute("ask_categoryVOS", ask_categoryVOS);
		return "message/askWriteWindow";
	}
	
	@RequestMapping(value = "/askSend",method = RequestMethod.POST)
	public String messageAskSendPost(AskVO askVO,Model model) {
		messageService.setSendAsk(askVO);
		model.addAttribute("sendedSw", "ok");
		return "message/askWriteWindow";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMyAsk", method=RequestMethod.POST)
	public AskVO messageGetMyAskPost(
			@RequestParam(name="ask_idx",defaultValue="0",required=false)int ask_idx
			) {
		AskVO askVO = messageService.getMyAsk(ask_idx); 
		return askVO;
	}

}
