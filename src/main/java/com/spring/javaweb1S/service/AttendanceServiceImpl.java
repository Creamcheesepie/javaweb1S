package com.spring.javaweb1S.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.AttendanceDAO;
import com.spring.javaweb1S.dao.MemberDAO;
import com.spring.javaweb1S.dao.PointDAO;
import com.spring.javaweb1S.vo.AttendanceVO;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired
	AttendanceDAO attendanceDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	PointDAO pointDAO;


	@Override
	public List<AttendanceVO> getAttendanceList(int sin, int pageSize) {
		List<AttendanceVO> vos = attendanceDAO.getAttendanceList(sin, pageSize);
		
		for(AttendanceVO tempVO : vos) {	
			if(tempVO.getDdate()!=null) {
				tempVO.setContent("삭제된 항목입니다.");
			}
		}
		
		return vos;
	}


	@Override
	public int setAttendanceWrite(AttendanceVO vo) {
		int res=0;
		
		AttendanceVO latestVO = attendanceDAO.getLatestAttendanceByM_idx(vo.getM_idx());
		if(latestVO!=null) {
			String latestDate = latestVO.getWdate().substring(0, 10);
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDate = sdf.format(date);
			
			if(!latestDate.equals(nowDate)) {
				attendanceDAO.setAttendanceWrite(vo);
				attendancePointUP(vo.getM_idx());
				
				res=1;
				return res;
			}
			else {
				res=2;
				return res;
			}
		}
		else {
			attendanceDAO.setAttendanceWrite(vo);
			attendancePointUP(vo.getM_idx());
			res=1;
			return res;
		}
	}

	public void attendancePointUP(int m_idx) {
		int point = memberDAO.getPointByM_idx(m_idx);
		point = point+pointDAO.getPoint(2);
		attendanceDAO.setAttendancePointUp(m_idx,point);
	}


	@Override
	public int setAttendanceUpdate(AttendanceVO attUp_VO) {
		int res = attendanceDAO.setAttendanceUpdate(attUp_VO);
		return res;
	}


	@Override
	public int setAttendanceDelete(int att_idx) {
		int res = attendanceDAO.setAttendanceDelete(att_idx);
		return res;
	}


	@Override
	public int setAttendanceRestore(int att_idx) {
		int res = attendanceDAO.setAttendanceRestore(att_idx);
		return res;
	}
	
	
	
	
}
