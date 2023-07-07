package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

public interface PageDAO {

	public int getTRC(@Param("tableName") String tableName);

	public int getTRCwithCategory(@Param("tableName") String tableName,@Param("category") int category);

	public int getTRCbyBoardSearch(@Param("searchOption") String searchOption,@Param("searchStr") String searchStr,@Param("category") int category);

	public int getTRCbyBoa_idx(@Param("tableName") String tableName,@Param("boa_idx") int boa_idx);

	public int getCurrentRecordCount(@Param("tableName") String tableName,@Param("idx") int idx,@Param("idxName")String idxName);

	public int getCurrentRecordCountWithCategory(@Param("tableName") String tableName,@Param("idx") int idx,@Param("idxName")String idxName,@Param("category") int category);

}
