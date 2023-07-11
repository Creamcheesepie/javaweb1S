package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class RuleSetterVO {
	private int rule_idx;
	private String ruleName;
	private int	actionLimit;
	private String limitTime;
	private String penaltyTime;
	private String cdate;
	private String c_reason;
}
