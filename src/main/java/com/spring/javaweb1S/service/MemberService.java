package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.DomainVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;

public interface MemberService {

	public MemberVO getNickSearch(String nickName);

	public MemberVO getMidSearch(String mid);

	public void setMemberSignIn(MemberVO vo);

	public MemberVO getLogin(String mid, String pwd);

	public String fileUpload(MultipartFile fName, String realPath);

	public MemberVO getM_idxInfo(int m_idx);

	public boolean getOnlyPwdCheck(int m_idx, String pwd);

	public List<DomainVO> getDomainlist();

	public MemberVO getEmailNameSearch(String emailName, int dom_idx_);

	public String getDomainDom_idx(int dom_idx_);

	public int setMemberNickNameUpdate(MemberVO vo);

	public void setMemberNameUpdate(MemberVO vo);

	public void setMemberAgeUpdate(MemberVO vo);

	public void setMembergenderUpdate(MemberVO vo);

	public void setMemberEmailUpdate(MemberVO vo);

	public void setMemberTelUpdate(MemberVO vo);

	public void setMemberBirthdayUpdate(MemberVO vo);

	public void setMemberInstUpdate(MemberVO vo);

	public void setMemberAddressUpdate(MemberVO vo);

	public void setMemberPhotoUpdate(int m_idx, String sfName);

	public MemberVO getEmailNameByM_idx(int m_idx);

	public void setMemberPwdUpdate(MemberVO vo);

	public List<BoardVO> getMyPageBoardList(int m_idx);

	public List<ReplyVO> getMyPageReplyList(int m_idx);

	public List<MemberVO> getFriendList(int m_idx, PageVO pageVO);

	public List<MemberVO> getMemberSearchForFriendAdd(String searchOption, String searchStr,int m_idx);

	public List<MemberVO> getBanList(int m_idx, PageVO pageVO);

	public void setFriendDelete(int m_idx, int t_idx);

	public void setBanDelete(int m_idx, int t_idx);

	public List<MessageVO> getMyMessageList(int m_idx);

	public List<MemberVO> getMyPageFriendList(int m_idx);

	public List<MemberVO> getMyPageBanList(int m_idx);

	public boolean getEmailCheck(String emailName, int dom_idx);

	public String getMidFind(String emailName, int dom_idx);

	public boolean getPwdFindCheck(String emailName, int dom_idx, String mid);

	public int getM_idxByMid(String mid);

	
	
	
	
}
