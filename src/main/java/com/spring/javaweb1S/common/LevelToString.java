package com.spring.javaweb1S.common;

public class LevelToString {
	public String levelToString(int level) {
		String strLevel = "";
		
		switch (level) {
			case 0:
				strLevel="관리자";
				break;
			case 1:
				strLevel="운영자";
				break;
			case 2:
				strLevel="모임장";
				break;
			case 3:
				strLevel="정회원";
				break;
			case 4:
				strLevel="준회원";
				break;
			case 5:
				strLevel="임시정지회원";
				break;
			case 6:
				strLevel="정지회원";
				break;
			default:
				break;
		}
		
		
		return strLevel;
	}
}
