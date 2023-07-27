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
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.DomainVO;
import com.spring.javaweb1S.vo.MemberVO;
import com.spring.javaweb1S.vo.MessageVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;

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

	@Override
	public void setMemberEmailUpdate(MemberVO vo) {
		memberDAO.setMemberEmailUpdate(vo);
	}

	@Override
	public void setMemberTelUpdate(MemberVO vo) {
		memberDAO.setMemberTelUpdate(vo);
	}

	@Override
	public void setMemberBirthdayUpdate(MemberVO vo) {
		memberDAO.setMemberBirthdayUpdate(vo);
	}

	@Override
	public void setMemberInstUpdate(MemberVO vo) {
		memberDAO.setMemberInstUpdate(vo);
	}

	@Override
	public void setMemberAddressUpdate(MemberVO vo) {
		memberDAO.setMemberAddressUpdate(vo);
	}

	@Override
	public void setMemberPhotoUpdate(int m_idx, String sfName) {
		memberDAO.setMemberPhotoUpdate(m_idx,sfName);
	}

	@Override
	public MemberVO getEmailNameByM_idx(int m_idx) {
		MemberVO allinfovo = memberDAO.getM_idxInfo(m_idx);
		MemberVO emailInfoVo = new MemberVO();
		emailInfoVo.setEmailName(allinfovo.getEmailName());
		emailInfoVo.setDom_idx(allinfovo.getDom_idx());
		emailInfoVo.setDomain(memberDAO.getDomainDom_idx(emailInfoVo.getDom_idx()));
		return emailInfoVo;
	}

	@Override
	public void setMemberPwdUpdate(MemberVO vo) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		memberDAO.setMemberPwdUpdate(vo);
	}

	@Override
	public List<BoardVO> getMyPageBoardList(int m_idx) {
		return memberDAO.getMyPageBoardList(m_idx);
	}

	@Override
	public List<ReplyVO> getMyPageReplyList(int m_idx) {
		return memberDAO.getMyPageReplyList(m_idx);
	}

	@Override
	public List<MemberVO> getFriendList(int m_idx, PageVO pageVO) {
		return memberDAO.getFriendList( m_idx, pageVO);
	}

	@Override
	public List<MemberVO> getMemberSearchForFriendAdd(String searchOption, String searchStr,int m_idx) {
		
		return memberDAO.getMemberSearchForFriendAdd(searchOption, searchStr,m_idx);
	}

	@Override
	public List<MemberVO> getBanList(int m_idx, PageVO pageVO) {
		return memberDAO.getBanList(m_idx,pageVO);
	}

	@Override
	public void setFriendDelete(int m_idx, int t_idx) {
		int status = memberDAO.getFrienStatus(m_idx,t_idx);
		if(status==1) memberDAO.setFriendBanDelete(m_idx,t_idx);
		else {
			memberDAO.setFriendBanDelete(m_idx,t_idx);
			memberDAO.setFriendBanDelete(t_idx,m_idx);
		}
	}

	@Override
	public void setBanDelete(int m_idx, int t_idx) {
		memberDAO.setFriendBanDelete(m_idx,t_idx);
	}

	@Override
	public List<MessageVO> getMyMessageList(int m_idx) {
		return memberDAO.getMyMessageList(m_idx);
	}

	@Override
	public List<MemberVO> getMyPageFriendList(int m_idx) {
		return memberDAO.getMyPageFriendList(m_idx);
	}

	@Override
	public List<MemberVO> getMyPageBanList(int m_idx) {
		return memberDAO.getMyPageBanList(m_idx);
	}

	@Override
	public boolean getEmailCheck(String emailName, int dom_idx) {
		boolean res = false;
		String check = memberDAO.getEmailCheck(emailName,dom_idx);
		if(check==null) res = false;
		else if (check != null) res = true;
		
		return res;
	}

	@Override
	public String getMidFind(String emailName, int dom_idx) {
		String mid = memberDAO.getMidFind(emailName,dom_idx);
		String outMid = "";
		char[] cArrMid = mid.toCharArray();
		
		for(int i = 0; i<cArrMid.length;i++) {
			if(i%3==0 || i%4==0) {
				cArrMid[i] = '*';
			}
			outMid += cArrMid[i];
		}
		
		return outMid;
	}

	@Override
	public boolean getPwdFindCheck(String emailName, int dom_idx, String mid) {
		boolean res = false;
		String fmid = memberDAO.getMidFind(emailName,dom_idx);
		if(fmid==null) {
			return false;
		}
		else if(fmid.equals(mid)) {
			res=true;
		}
		return res;
	}

	@Override
	public int getM_idxByMid(String mid) {
		return memberDAO.getM_idxByMid(mid);
	}

	@Override
	public List<MemberVO> getMostBoardMember() {
		return memberDAO.getMostBoardMember();
	}

	@Override
	public List<MemberVO> getMostReplyMember() {
		return memberDAO.getMostReplyMember();
	}

	@Override
	public boolean banClearCheck(int m_idx) {
		boolean res = false;
		String cdate  = memberDAO.getBadUserCdateByM_idx(m_idx);
		if(cdate == null) res = true;
		
		return res;
	}

	@Override
	public void setMemberLevelUpdate(int m_idx, int level) {
		memberDAO.setMemberLevelUpdate(m_idx,level);
	}






	
}
