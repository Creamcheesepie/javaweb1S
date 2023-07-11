package com.spring.javaweb1S;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.MessageService;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;

@Controller
@RequestMapping("/message")
public class MessageController {
	@Autowired
	MessageService messageService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/home", method=RequestMethod.GET)
	public String messageHomeGet() {
		PageVO pageVO = pageProcess.pageProcesserAllmessage();
		//쪽지, 신고, 문의는 전부 테이블과 카테고리를 따로 관리하고 있음, totalrecordCount를 가져오는 방법은 전부 유사함.
		//고로, 테이블 이름만 갈아쳐서 사용 가능할듯함. 송수신 전부 가져오는건 일반쪽지 뿐이다.
		//혹시 모르니 테이블 명 기준으로 totla
		
		List<CategoryVO> categor_vos = messageService.getAllMessageList();
		
		
		
		return "message/messageList";
	}
	
}
