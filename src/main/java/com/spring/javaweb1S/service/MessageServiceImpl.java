package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.MessageDAO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;

@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDAO messageDAO;

	@Override
	public List<MessageVO> getAllMessageList(PageVO pageVO, int m_idx) {
		return messageDAO.getAllMessageList(pageVO,m_idx);
	}

	@Override
	public MessageVO getSendMessage(int msg_idx) {
		return messageDAO.getSendMessage(msg_idx);
	}

	@Override
	public MessageVO getReceiveMessage(int msg_idx) {
		return messageDAO.getReceiveMessage(msg_idx);
	}

	@Override
	public List<MemberVO> getMessageReceiverSearchList(String searchOption, String searchStr) {
		return messageDAO.getMessageReceiverSearchList(searchOption,searchStr);
	}

	@Override
	public List<MessageVO> getMessageCategoryList() {
		return messageDAO.getMessageCategoryList();
	}

	@Override
	public void setSendMessage(MessageVO msg_vo) {
		messageDAO.setSendMessage(msg_vo);
	}
	
	
}
