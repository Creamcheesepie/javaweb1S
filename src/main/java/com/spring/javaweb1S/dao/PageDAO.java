package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

public interface PageDAO {

	public int getTRC(@Param("tableName") String tableName);

	public int getTRCwithCategory(@Param("tableName") String tableName,@Param("category") int category);

	public int getTRCbyBoardSearch(@Param("searchOption") String searchOption,@Param("searchStr") String searchStr,@Param("category") int category);

	public int getTRCbyBoa_idx(@Param("tableName") String tableName,@Param("boa_idx") int boa_idx);

	public int getCurrentRecordCount(@Param("tableName") String tableName,@Param("idx") int idx,@Param("idxName")String idxName);

	public int getCurrentRecordCountWithCategory(@Param("tableName") String tableName,@Param("idx") int idx,@Param("idxName")String idxName,@Param("category") int category);

	public int getTRCByAllMessage(@Param("m_idx")int m_idx);

	public int getTRCByM_idx(@Param("tableName") String tableName, @Param("m_idx") int m_idx);

	public int getTRCByReceiveM_idx(@Param("m_idx") int m_idx);

	public int getTRCforReportAdmin(@Param("rep_category") int rep_category,@Param("afterDate") String afterDate,@Param("beforeDate") String beforeDate);

	public int getTRCforAskAdmin(@Param("ask_category") int ask_category,@Param("afterDate") String afterDate,@Param("beforeDate") String beforeDate);

	public int getTRCInFriendList(@Param("m_idx") int m_idx);

	public int getTRCInBanList(@Param("m_idx") int m_idx);

	public int getTRCwithCategoryWithBan_idx(@Param("tableName") String tableName,@Param("category") int category,@Param("ban_idx") String ban_idx);

	public int getTRCbyBoa_idxWithBan_idx(@Param("tableName") String tableName,@Param("boa_idx") int boa_idx,@Param("ban_idx") String ban_idx);

	public int getAfterGether();

	public int getPastGether();

	public int getTRCWithBan_idx(@Param("tableName") String tableName,@Param("ban_idx")  String ban_idx);

}
