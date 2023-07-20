package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.MemberDAO;
import com.spring.javaweb1S.dao.MessageDAO;
import com.spring.javaweb1S.vo.AskVO;
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

	@Override
	public int setFriendInviteAnswer(int ans,int msg_idx, int t_idx,int m_idx,String nickName) {
		int res = 0;
		MessageVO msgVO = new MessageVO();
		msgVO.setM_idx(m_idx);
		msgVO.setReceive_m_idx(t_idx);
		msgVO.setMsg_category(121);
		
		if(ans==1) {
			msgVO.setTitle(nickName+"님이 회원님의 친구 요청을 수락하였습니다.");
			msgVO.setContent("앞으로 좋은 활동 기대하겠습니다.");
			messageDAO.setRepliedMessageRdateUpdate(msg_idx);
			messageDAO.setSendMessage(msgVO);
			messageDAO.setFriendInviteAgree(t_idx,m_idx,"친구요청 승낙");
			messageDAO.setFriendInviteUpdate(t_idx,m_idx,2);
			res = 1 ;
		}
		else if(ans ==2) {
			msgVO.setTitle(nickName+"님이 회원님의 친구 요청을 거절하였습니다.");
			msgVO.setContent("다음 번엔 좋은 기회가 있기를 바라겠습니다.");
			messageDAO.setRepliedMessageRdateUpdate(msg_idx);
			messageDAO.setSendMessage(msgVO);
			messageDAO.setFriendInviteDisagree(t_idx,m_idx,"친구요청 거절");
			res = 2;
		}
		return res;
	}

	@Override
	public List<AskVO> getMyAskList(int m_idx, PageVO pageVO) {
		return messageDAO.getMyAskList(m_idx,pageVO);
	}

	@Override
	public List<AskVO> getAskCategoryList() {
		return messageDAO.getAskCategoryList();
	}

	@Override
	public void setSendAsk(AskVO askVO) {
		messageDAO.setSendAsk(askVO);
		
	}

	@Override
	public AskVO getMyAsk(int ask_idx) {
		return messageDAO.getMyAsk(ask_idx);
	}

	@Override
	public boolean getBanCheck(int m_idx, int t_idx) {
		boolean res = false;
		String extra = messageDAO.getBanExtraByIdxs(m_idx,t_idx);
		if(extra!=null) res=true;
		
		return res;
	}

	@Override
	public void setBanUser(int m_idx, int t_idx, String content) {
		messageDAO.setBanUser(m_idx, t_idx, content);
	}


	
	
	
}
