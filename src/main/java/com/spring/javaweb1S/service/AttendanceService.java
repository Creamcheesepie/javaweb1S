package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.AttendanceVO;

public interface AttendanceService {

	List<AttendanceVO> getAttendanceList(int sin, int pageSize);

	
	
}
