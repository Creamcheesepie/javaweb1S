package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int rep_idx;
	private int boa_idx;
	private int m_idx;
	private String content;
	private int rep_group;
	private int rep_level;
	private String wdate;
	private String cdate;
	private String ddate;
	
	private String nickName;
	private String mid;
	private String photo;
}
