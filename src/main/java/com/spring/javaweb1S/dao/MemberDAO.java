package com.spring.javaweb1S.dao;

import com.spring.javaweb1S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getNickSearch(String nickName);

	public MemberVO getMidSearch(String mid);
	
}
