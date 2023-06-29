package com.spring.javaweb1S.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.dao.MemberDAO;
import com.spring.javaweb1S.dao.PointDAO;
import com.spring.javaweb1S.vo.DomainVO;
import com.spring.javaweb1S.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	PointDAO point;
	
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
		memberDAO.setEmailInput(vo);
	}

	@Override
	public MemberVO getLogin(String mid, String pwd) {
		MemberVO pwdVO = getMidSearch(mid);
		if(passwordEncoder.matches(pwd, pwdVO.getPwd())) {
			Date nowDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String todayStr = sdf.format(nowDate);
			int loginPoint = point.getPoint(1); //로그인 시 포인트 값 부여
			
			if(!pwdVO.getLastVisit().substring(0, 10).equals(todayStr)) {
				pwdVO.setPoint(pwdVO.getPoint()+loginPoint);
				pwdVO.setTotalCnt(pwdVO.getTotalCnt()+1);
				pwdVO.setTodayCnt(1);
				memberDAO.setLoginFirstSetting(pwdVO.getM_idx(),pwdVO.getPoint(),pwdVO.getTotalCnt(),pwdVO.getTodayCnt());
			}
			else {
				pwdVO.setTodayCnt(pwdVO.getTodayCnt()+1);
				memberDAO.setLoginSetting(pwdVO.getM_idx(),pwdVO.getTodayCnt());
			}
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

	@Override
	public MemberVO getM_idxInfo(int m_idx) {
		return memberDAO.getM_idxInfo(m_idx);
	}

	@Override
	public boolean getOnlyPwdCheck(int m_idx, String pwd) {
		MemberVO vo =  memberDAO.getM_idxInfo(m_idx);
		return passwordEncoder.matches(pwd, vo.getPwd());
	}

	@Override
	public List<DomainVO> getDomainlist() {
		return memberDAO.getDomainlist();
	}

	@Override
	public MemberVO getEmailNameSearch(String emailName, int dom_idx_) {
		
		return memberDAO.getEmailNameSearch(emailName,dom_idx_);
	}

	@Override
	public String getDomainDom_idx(int dom_idx_) {
		
		return memberDAO.getDomainDom_idx(dom_idx_);
	}

	@Override
	public int setMemberNickNameUpdate(MemberVO vo) {
		int res = 0;
		MemberVO nickSearchVO = memberDAO.getNickSearch(vo.getNickName());
		
		if(nickSearchVO!=null) {
			res=1;
			return res;
		}
		else {
			memberDAO.setMemberNickNameUpdate(vo);
			res=0;
			return res;
		}
	}

	@Override
	public void setMemberNameUpdate(MemberVO vo) {
		memberDAO.setMemberNameUpdate(vo);
	}

	@Override
	public void setMemberAgeUpdate(MemberVO vo) {
		memberDAO.setMemberAgeUpdate(vo);
	}

	@Override
	public void setMembergenderUpdate(MemberVO vo) {
		memberDAO.setMemberGenderUpdate(vo);
	}




	
}
