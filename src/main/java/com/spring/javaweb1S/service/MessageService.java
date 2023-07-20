package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.AskVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReportVO;

public interface MessageService {

	public List<MessageVO> getAllMessageList(PageVO pageVO, int m_idx);

	public MessageVO getSendMessage(int msg_idx);

	public MessageVO getReceiveMessage(int msg_idx);

	public List<MemberVO> getMessageReceiverSearchList(String searchOption, String searchStr);

	public List<MessageVO> getMessageCategoryList();

	public void setSendMessage(MessageVO msg_vo);

	public List<MessageVO> getMessageSendList(int m_idx, PageVO pageVO);

	public List<MessageVO> getMessageReceiveList(int m_idx, PageVO pageVO);

	public MessageVO getSenderInfo(int msg_idx);

	public List<ReportVO> getReportList(int m_idx, PageVO pageVO);

	public List<ReportVO> getReportCategoryList(String tableName);

	public void setSendReport(ReportVO reportVO);

	public ReportVO getMyReport(int rep_idx);

	public boolean getFriendCheck(int m_idx, int t_idx);

	public void setFriendInvitation(int m_idx, int t_idx,String content);

	public void setFrienInviteMessageSend(int m_idx, int t_idx, String content);

	public int setFriendInviteAnswer(int ans,int msg_idx, int t_idx,int m_idx,String nickName);

	public List<AskVO> getMyAskList(int m_idx, PageVO pageVO);

	public List<AskVO> getAskCategoryList();

	public void setSendAsk(AskVO askVO);

	public AskVO getMyAsk(int ask_idx);

	public boolean getBanCheck(int m_idx, int t_idx);

	public void setBanUser(int m_idx, int t_idx, String content);

	
}
