package com.spring.javaweb1S.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.RuleSetterVO;

public interface RuleSetterDAO {

	RuleSetterVO getRuleByRule_idx(@Param("rule_idx")int i);

}
