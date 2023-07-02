package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.AttendanceDAO;
import com.spring.javaweb1S.vo.AttendanceVO;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	@Autowired
	AttendanceDAO attendanceDAO;


	@Override
	public List<AttendanceVO> getAttendanceList(int sin, int pageSize) {
		return attendanceDAO.getAttendanceList(sin, pageSize);
	}

	
	
	
	
	
}
