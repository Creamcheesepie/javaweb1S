package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		//쪽지, 신고, 문의는 전부 테이블과 카테고리를 따로 관리하고 있음, totalrecordCount를 가져오는 방법은 전부 유사함.
		//고로, 테이블 이름만 갈아쳐서 사용 가능할듯함. 송수신 전부 가져오는건 일반쪽지 뿐이다.
		//혹시 모르니 테이블 명 기준으로 totalrecordCount를 가져오는 메소드를 만들자.>> 아마 내 게시글 조회에 써먹을 수 있을듯?
		
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
	public String messageSendGet(MessageVO msg_vo,Model model) {
		messageService.setSendMessage(msg_vo);
		
		
		model.addAttribute("sendedSw", "ok");
		return "message/messageWriteWindow";
	}
	
}
