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
	private int category;
	
	private String categoryName;
	
	private String photo;
	private int speed;
	private int duration;
	private int getheight;
	private int level;
	private String strLevel;
	private String inst;
	
	private int deleteCnt;
}
