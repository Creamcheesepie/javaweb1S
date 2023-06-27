package com.spring.javaweb1S.service;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.vo.MemberVO;

public interface MemberService {

	public MemberVO getNickSearch(String nickName);

	public MemberVO getMidSearch(String mid);

	public void setMemberSignIn(MemberVO vo);

	public MemberVO getLogin(String mid, String pwd);

	public String fileUpload(MultipartFile fName, String realPath);


	
}
