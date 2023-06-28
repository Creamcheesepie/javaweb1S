package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getNickSearch(@Param("nickName") String nickName);

	public MemberVO getMidSearch(@Param("mid") String mid);

	public void setMemberSignIn(@Param("vo") MemberVO vo);

	public void setLoginFirstSetting(@Param("m_idx") int m_idx,@Param("point") int point,@Param("totalCnt") int totalCnt,@Param("todayCnt") int todayCnt);

	public void setLoginSetting(@Param("m_idx") int m_idx,@Param("todayCnt") int todayCnt);

	public MemberVO getM_idxInfo(@Param("m_idx") int m_idx);

	
	
}
