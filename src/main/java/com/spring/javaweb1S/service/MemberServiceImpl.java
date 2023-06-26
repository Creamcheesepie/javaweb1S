package com.spring.javaweb1S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.MemberDAO;
import com.spring.javaweb1S.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;

	@Override
	public MemberVO getNickSearch(String nickName) {
		return memberDAO.getNickSearch(nickName);
	}

	@Override
	public MemberVO getMidSearch(String mid) {
		return memberDAO.getMidSearch(mid);
	}
	
}
