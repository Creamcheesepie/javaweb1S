package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class ReportCategoryVO {
	private int rep_category;
	private String name;
	private String tableName;
	private String idxName;
	private String selectSector;
	private String wdate;
	private String cdate;
}
