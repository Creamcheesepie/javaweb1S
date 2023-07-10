package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.PointVO;

public interface AdminDAO {

	public List<PointVO> getPointList();

	public int setPointSetterUpdate(@Param("vo") PointVO vo);
	
}
