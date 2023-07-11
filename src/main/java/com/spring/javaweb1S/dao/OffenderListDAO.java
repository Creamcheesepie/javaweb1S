package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.OffendListVO;
import com.spring.javaweb1S.vo.RuleSetterVO;

public interface OffenderListDAO {

	public void setOffenderUser(@Param("m_idx") int m_idx,@Param("vo") RuleSetterVO boardAbuseRuleVO,@Param("cdate") String cdate);

	public int[] getOffenderArray(@Param("cdate") String cdate);

	public OffendListVO getOffendInfoByM_idx(@Param("cdate") String cdate,@Param("m_idx") int m_idx,@Param("rule_idx") int rule_idx);

}
