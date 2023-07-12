package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class MessageVO {
	private int msg_idx;
	private int	m_idx;
	private int receive_m_idx;
	private String title;
	private String content;
	private int readSw;
	private int msg_category;
	private String sdate;
	private String rdate;
	private	String ddate;
	
	private String category_name;
	
	private String nickName;
}


 