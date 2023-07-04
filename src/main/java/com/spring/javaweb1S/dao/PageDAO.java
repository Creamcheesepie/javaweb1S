package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

public interface PageDAO {

	public int getTRC(@Param("tableName") String tableName);

	public int getTRCwithCategory(@Param("tableName") String tableName,@Param("category") int category);

}
