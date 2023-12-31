package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.DomainVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;

public interface MemberDAO {

	public MemberVO getNickSearch(@Param("nickName") String nickName);

	public MemberVO getMidSearch(@Param("mid") String mid);

	public void setMemberSignIn(@Param("vo") MemberVO vo);
	
	public void setEmailInput(@Param("vo") MemberVO vo);

	public void setLoginFirstSetting(@Param("m_idx") int m_idx,@Param("point") int point,@Param("totalCnt") int totalCnt,@Param("todayCnt") int todayCnt);

	public void setLoginSetting(@Param("m_idx") int m_idx,@Param("todayCnt") int todayCnt);

	public MemberVO getM_idxInfo(@Param("m_idx") int m_idx);

	public List<DomainVO> getDomainlist();

	public MemberVO getEmailNameSearch(@Param("emailName") String emailName,@Param("dom_idx") int dom_idx_);

	public String getDomainDom_idx(@Param("dom_idx") int dom_idx_);

	public void setMemberNickNameUpdate(@Param("vo") MemberVO vo);

	public void setMemberNameUpdate(@Param("vo") MemberVO vo);

	public void setMemberAgeUpdate(@Param("vo") MemberVO vo);

	public void setMemberGenderUpdate(@Param("vo") MemberVO vo);

	public void setMemberEmailUpdate(@Param("vo") MemberVO vo);

	public void setMemberTelUpdate(@Param("vo") MemberVO vo);

	public void setMemberBirthdayUpdate(@Param("vo") MemberVO vo);

	public void setMemberInstUpdate(@Param("vo") MemberVO vo);

	public void setMemberAddressUpdate(@Param("vo") MemberVO vo);

	public void setMemberPhotoUpdate(@Param("m_idx") int m_idx,@Param("sfName") String sfName);

	public void setMemberPwdUpdate(@Param("vo") MemberVO vo);

	public int getPointByM_idx(@Param("m_idx") int m_idx);

	public String getNickNameBym_idx(@Param("m_idx") int m_idx);

	public List<BoardVO> getMyPageBoardList(@Param("m_idx") int m_idx);

	public List<ReplyVO> getMyPageReplyList(@Param("m_idx") int m_idx);

	public List<MemberVO> getFriendList(@Param("m_idx") int m_idx,@Param("vo") PageVO pageVO);

	public List<MemberVO> getMemberSearchForFriendAdd(@Param("searchOption")String searchOption,@Param("searchStr") String searchStr,@Param("m_idx") int m_idx);

	public List<MemberVO> getBanList(@Param("m_idx") int m_idx,@Param("vo") PageVO pageVO);

	public int getFrienStatus(@Param("m_idx") int m_idx,@Param("t_idx") int t_idx);

	public void setFriendBanDelete(@Param("m_idx") int m_idx,@Param("t_idx") int t_idx);

	public List<MessageVO> getMyMessageList(@Param("m_idx") int m_idx);

	public List<MemberVO> getMyPageFriendList(@Param("m_idx") int m_idx);

	public List<MemberVO> getMyPageBanList(@Param("m_idx") int m_idx);

	public String getEmailCheck(@Param("emailName")String emailName,@Param("dom_idx") int dom_idx);

	public String getMidFind(@Param("emailName") String emailName,@Param("dom_idx") int dom_idx);

	public int getM_idxByMid(@Param("mid")String mid);

	public List<MemberVO> getMostBoardMember();

	public List<MemberVO> getMostReplyMember();

	public String getBadUserCdateByM_idx(@Param("m_idx")int m_idx);

	public void setMemberLevelUpdate(@Param("m_idx") int m_idx,@Param("level") int level);

	public void setRideInfoUpdate(@Param("vo") MemberVO mvo,@Param("m_idx") int m_idx);




	

	

	

	
	
}
