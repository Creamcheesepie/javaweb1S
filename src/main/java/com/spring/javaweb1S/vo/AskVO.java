package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class AskVO {
	private int ask_idx;
	private int m_idx;
	private int ask_category;
	private String title;
	private String content;
	private String wdate;
	private String tdate;
	private int takeSw;
	private String takeContent;
	private String ddate;
	
	private String nickName;
	private String category_name;
}
