package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class ReportVO {
	private int rep_idx;
	private int m_idx;
	private int rep_category;
	private int reported_idx;
	private String title;
	private String content;
	private String wdate;
	private String tdate;
	private String takeSw;
	private String takeContent;
	private String ddate;
	
	private String category_name;
	private String tableName;
	private String idxName;
	private String nickName;
	
	private int reported_m_idx;
	private String reportednickName;
	private String reportedTitle;
	private String reportedContent;
	private String cdate;
	private int ban_idx;
	private String banType;
}
