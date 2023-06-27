package com.spring.javaweb1S.service;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.dao.MemberDAO;
import com.spring.javaweb1S.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Override
	public MemberVO getNickSearch(String nickName) {
		return memberDAO.getNickSearch(nickName);
	}

	@Override
	public MemberVO getMidSearch(String mid) {
		return memberDAO.getMidSearch(mid);
	}

	@Override
	public void setMemberSignIn(MemberVO vo) {

		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		memberDAO.setMemberSignIn(vo);
		
	}

	@Override
	public MemberVO getLogin(String mid, String pwd) {
		MemberVO pwdVO = getMidSearch(mid);
		if(passwordEncoder.matches(pwd, pwdVO.getPwd())) {
			memberDAO.setloginSetting(pwdVO.getM_idx());
			return pwdVO;
		}
		else {
			return null;
		}
	}

	@Override
	public String fileUpload(MultipartFile fName, String realPath) {
		String ofName = fName.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String sfName = uid.toString().substring(0,5)+"_"+ofName;
		
		try {
			writeFile(fName,sfName,realPath);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return sfName;
	}

	private void writeFile(MultipartFile fName, String sfName,String realPath) throws IOException {
		byte[] data = fName.getBytes();
		FileOutputStream fos = new FileOutputStream(realPath+sfName);
		fos.write(data);
		fos.close();
	}


	
}
