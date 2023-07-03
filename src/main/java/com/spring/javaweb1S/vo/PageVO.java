package com.spring.javaweb1S.vo;

import lombok.Data;

@Data
public class PageVO {
	private int nowPage;
	private int pageSize;
	private int TRC; //total record count,총 항목 개수
	private int totalPage; //총 페이지 개수
	private int sin; //start index no. 시작 인덱스 번호
	private int cssn; // current screen start number, 현재 화면에 표시되는 시작 번호
	private int blockSize; //블록 페이징 처리를 위한 블록 사이즈
	private int curBlock; //현재 블록 번호
	private int lastBlock; //마지막 블록
}
