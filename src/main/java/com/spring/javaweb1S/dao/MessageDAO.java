package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;

public interface MessageDAO {

	List<MessageVO> getAllMessageList(@Param("vo") PageVO pageVO,@Param("m_idx") int m_idx);

	MessageVO getSendMessage(@Param("msg_idx") int msg_idx);

	MessageVO getReceiveMessage(@Param("msg_idx") int msg_idx);

	List<MemberVO> getMessageReceiverSearchList(@Param("searchOption") String searchOption,@Param("searchStr") String searchStr);

	List<MessageVO> getMessageCategoryList();

	void setSendMessage(@Param("vo") MessageVO msg_vo);

}