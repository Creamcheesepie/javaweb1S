package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getNickSearch(@Param("nickName") String nickName);

	public MemberVO getMidSearch(@Param("mid") String mid);

	public void setMemberSignIn(@Param("vo") MemberVO vo);
	
}
