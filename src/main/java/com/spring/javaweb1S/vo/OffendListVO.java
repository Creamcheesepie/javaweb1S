package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class OffendListVO {
	private int off_idx;
	private int m_idx;
	private String odate;
	private String cdate;
	private int	rule_idx;
	
	private String nickName;
	private String ruleName;
}
