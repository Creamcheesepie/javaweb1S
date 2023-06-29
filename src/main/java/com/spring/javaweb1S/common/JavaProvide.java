package com.spring.javaweb1S.common;

public class JavaProvide {
	public String splitArrMakeOneString(String originalString, String spliter) {
		String str ="";
		String[] arrstr = originalString.split(spliter);
		for(String tempStr : arrstr) { str += tempStr+" "; }
		return str;
	}
}
