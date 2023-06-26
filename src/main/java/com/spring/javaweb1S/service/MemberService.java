package com.spring.javaweb1S.service;

import com.spring.javaweb1S.vo.MemberVO;

public interface MemberService {

	public MemberVO getNickSearch(String nickName);

	public MemberVO getMidSearch(String mid);
	
}
