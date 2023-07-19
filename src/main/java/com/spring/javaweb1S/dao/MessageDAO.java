package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.AskVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReportVO;

public interface MessageDAO {

	public List<MessageVO> getAllMessageList(@Param("vo") PageVO pageVO,@Param("m_idx") int m_idx);

	public MessageVO getSendMessage(@Param("msg_idx") int msg_idx);

	public MessageVO getReceiveMessage(@Param("msg_idx") int msg_idx);

	public List<MemberVO> getMessageReceiverSearchList(@Param("searchOption") String searchOption,@Param("searchStr") String searchStr);

	public List<MessageVO> getMessageCategoryList();

	public void setSendMessage(@Param("vo") MessageVO msg_vo);

	public List<MessageVO> getMessageSendList(@Param("m_idx") int m_idx,@Param("vo") PageVO pageVO);

	public List<MessageVO> getMessageReceiveList(@Param("m_idx")int m_idx,@Param("vo") PageVO pageVO);

	public MessageVO getSenderInfo(@Param("msg_idx") int msg_idx);

	public void setReadSwOn(@Param("msg_idx") int msg_idx);

	public List<ReportVO> getReportList(@Param("m_idx") int m_idx,@Param("vo") PageVO pageVO);

	public List<ReportVO> getReportCategoryList(@Param("tableName")String tableName);

	public ReportVO setTableInfo(@Param("tableName") String tableName);

	public void setSendReport(@Param("vo") ReportVO reportVO);

	public ReportVO getMyReportByRep_idx(@Param("rep_idx") int rep_idx);

	public String getBoardTitle(@Param("vo") ReportVO vo);

	public String getMemberNickName(@Param("vo") ReportVO vo);

	public String getReplyContent(@Param("vo") ReportVO vo);

	public String getFriendExtraByIdxs(@Param("m_idx") int m_idx,@Param("t_idx") int t_idx);

	public void setFreindInvitation(@Param("m_idx") int m_idx,@Param("t_idx") int t_idx,@Param("content") String content);

	public void setFriendInviteAgree(@Param("t_idx")int t_idx,@Param("m_idx") int m_idx,@Param("extra") String Extra);

	public void setFriendInviteUpdate(@Param("m_idx") int m_idx,@Param("t_idx") int t_idx,@Param("i") int i) ;

	public void setFriendInviteDisagree(@Param("t_idx") int t_idx,@Param("m_idx") int m_idx,@Param("extra") String Extra);

	public void setRepliedMessageRdateUpdate(@Param("msg_idx") int msg_idx);

	public List<AskVO> getMyAskList(@Param("m_idx") int m_idx,@Param("vo") PageVO pageVO);

	public List<AskVO> getAskCategoryList();

	public void setSendAsk(@Param("vo")AskVO askVO);

	public AskVO getMyAsk(@Param("ask_idx") int ask_idx);


}
