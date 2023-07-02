package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class AttendanceVO {
	private int att_idx;
	private int m_idx;
	private String content;
	private String wdate;
	private String cdate;
	private String ddate;
	private String hostIp;
	
	private String nickName;
	
}
