package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

public interface PageDAO {

	public int getTRC(@Param("tableName") String tableName);

	public int getTRCwithCategory(@Param("tableName") String tableName,@Param("category") int category);

	public int getTRCbyBoardSearch(@Param("searchOption") String searchOption,@Param("searchStr") String searchStr,@Param("category") int category);

}
