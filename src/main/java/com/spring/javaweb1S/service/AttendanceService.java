package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.AttendanceVO;

public interface AttendanceService {

	public List<AttendanceVO> getAttendanceList(int sin, int pageSize);

	public int setAttendanceWrite(AttendanceVO vo);

	public int setAttendanceUpdate(AttendanceVO attUp_VO);

	public int setAttendanceDelete(int att_idx);

	public int setAttendanceRestore(int att_idx);

	
	
}
