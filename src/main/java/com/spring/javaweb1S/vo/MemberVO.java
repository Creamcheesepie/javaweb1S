package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int m_idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	
	private String tel;
	private String address;
	private int age;
	private String gender;
	private String birthday;
	private String inst;
	private String photo;
	private int level;
	private int point;
	private int speed;
	private int duration;
	private int getHeight;
	private int totalCnt;
	private int todayCnt;
	private String signInDate;
	private String lastVisit;
	private int memberDel;
	private int infoSw;
	private String QRcode;
	
	private String emailName;
	private int dom_idx;
	private String domain;
	
	private int status;
	private String setDate;
	private String extra;
	
	private int boaCnt;
	private int repCnt;
	private int gerCnt;
	private int offCnt;
}
