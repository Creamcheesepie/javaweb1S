package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.AttendanceVO;

public interface AttendanceDAO {

	List<AttendanceVO> getAttendanceList(@Param("sin") int sin,@Param("pageSize") int pageSize);
	
	
}
