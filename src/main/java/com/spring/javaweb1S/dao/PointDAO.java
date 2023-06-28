package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

public interface PointDAO {

	int getPoint(@Param("part") int part);

}
