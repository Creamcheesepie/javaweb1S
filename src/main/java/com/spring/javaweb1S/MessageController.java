package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.MessageService;
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
	
	@RequestMapping(value = "/openReportWrite", method=RequestMethod.GET)
	public String messageReportWriteWindowOpenGet() {
		
		return "message/reportWriteWindow";
	}
	
	
	
	
}
