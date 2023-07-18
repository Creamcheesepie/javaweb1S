package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.MemberDAO;
import com.spring.javaweb1S.dao.MessageDAO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReportVO;

@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDAO messageDAO;
	
	@Autowired
	MemberDAO memberDAO;

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
		messageDAO.setReadSwOn(msg_idx);
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

	@Override
	public List<MessageVO> getMessageSendList(int m_idx, PageVO pageVO) {
		return messageDAO.getMessageSendList(m_idx,pageVO);
	}

	@Override
	public List<MessageVO> getMessageReceiveList(int m_idx, PageVO pageVO) {
		return messageDAO.getMessageReceiveList(m_idx,pageVO);
	}

	@Override
	public MessageVO getSenderInfo(int msg_idx) {
		return messageDAO.getSenderInfo(msg_idx);
	}

	@Override
	public List<ReportVO> getReportList(int m_idx, PageVO pageVO) {
		return messageDAO.getReportList( m_idx, pageVO);
	}

	@Override
	public List<ReportVO> getReportCategoryList(String tableName) {
		return messageDAO.getReportCategoryList(tableName);
	}

	@Override
	public void setSendReport(ReportVO reportVO) {
		messageDAO.setSendReport(reportVO);
	}

	@Override
	public ReportVO getMyReport(int rep_idx) {
		ReportVO vo = messageDAO.getMyReportByRep_idx(rep_idx);
		if(vo.getTableName().equals("board2")) {
			vo.setReportedTitle(messageDAO.getBoardTitle(vo));
		}
		else if(vo.getTableName().equals("member2")) {
			vo.setReportednickName(messageDAO.getMemberNickName(vo));
		}
		else if(vo.getTableName().equals("board2_reply")) {
			vo.setReportedContent(messageDAO.getReplyContent(vo));
		}
		
		return vo;
	}

	@Override
	public boolean getFriendCheck(int m_idx, int t_idx) {
		boolean res = false;
		String extra = messageDAO.getFriendExtraByIdxs(m_idx,t_idx);
		if(extra!=null) res=true;
		
		return res;
	}

	@Override
	public void setFriendInvitation(int m_idx, int t_idx,String content) {
		messageDAO.setFreindInvitation(m_idx,t_idx,content);
	}

	@Override
	public void setFrienInviteMessageSend(int m_idx, int t_idx, String content) {
		String nickName = memberDAO.getNickNameBym_idx(m_idx);
		MessageVO msg_vo = new MessageVO();
		msg_vo.setM_idx(m_idx);
		msg_vo.setReceive_m_idx(t_idx);
		msg_vo.setTitle(nickName+"님의 친구신청입니다.");
		msg_vo.setContent(content);
		msg_vo.setMsg_category(120);
		messageDAO.setSendMessage(msg_vo);
	}


	
	
	
}
