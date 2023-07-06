package com.spring.javaweb1S.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class JavaProvide {
	public String splitArrMakeOneString(String originalString, String spliter) {
		String str ="";
		String[] arrstr = originalString.split(spliter);
		for(String tempStr : arrstr) { str += tempStr+" "; }
		return str;
	}
	
	public void imageCheckCopy(String content, String realPath,String servletPath) {
		if(content.indexOf("src=\"/") == -1) return;
		System.out.println("업데이트된 content" + content);
		String nextImg = content.substring(content.indexOf(servletPath)+servletPath.length());
		System.out.println("인덱스of길이"+content.indexOf(servletPath));
		System.out.println("nextImg : " + nextImg);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String ofPath = realPath+"boardTemp/"+imgFile;
			String cfPath = realPath+"board/"+imgFile;
			
			try {
				FileInputStream fis = new FileInputStream(new File(ofPath));
				FileOutputStream fos = new FileOutputStream(new File(cfPath));
				
				byte[] bytes = new byte[2048];
				int cnt = 0;
				while((cnt = fis.read(bytes))!=-1) {
					fos.write(bytes,0,cnt);
				}
				
				fos.flush();
				fos.close();
				fis.close();
			} catch (FileNotFoundException e) {
				System.out.println("파일찾기오류 : " + e.getMessage());
			} catch (IOException e) {
				System.out.println("IO오류 : " + e.getMessage());
			}
			if(nextImg.indexOf("src=\"/")==-1) sw = false;
			else {
				nextImg = nextImg.substring(content.indexOf("servletPath")+servletPath.length());
			}
		}
	}
	
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
	
	public String searchOptionToKorean(String searchOption) {
		if(searchOption.equals("title")) searchOption = "제목";
		else if (searchOption.equals("content")) searchOption = "내용";
		else if (searchOption.equals("nickName")) searchOption = "닉네임";
		else if (searchOption.equals("mid")) searchOption = "아이디";
		return searchOption;
	}
	
}
