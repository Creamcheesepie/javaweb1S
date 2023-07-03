package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.AttendanceVO;

public interface AttendanceDAO {

	public List<AttendanceVO> getAttendanceList(@Param("sin") int sin,@Param("pageSize") int pageSize);

	public AttendanceVO getLatestAttendanceByM_idx(@Param("m_idx") int m_idx);

	public void setAttendanceWrite(@Param("vo") AttendanceVO vo);

	public void setAttendancePointUp(@Param("m_idx") int m_idx,@Param("point") int point);

	public int setAttendanceUpdate(@Param("vo") AttendanceVO attUp_VO);

	public int setAttendanceDelete(@Param("att_idx") int att_idx);

	public int setAttendanceRestore(@Param("att_idx") int att_idx);
	
	
}
