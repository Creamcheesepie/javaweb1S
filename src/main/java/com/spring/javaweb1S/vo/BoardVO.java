package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int boa_idx;
	private int m_idx;
	private String nickName;
	private String name;
	private String mid;
	private String title;
	private String content;
	private int viewCnt;
	private int recommendCnt;
	private String wdate;
	private String cdate;
	private String ddate;
	private String category;
	private String categoryName;
}
