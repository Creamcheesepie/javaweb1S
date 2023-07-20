<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차단하기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
	'use strict';
	
	function setBanUserSend(){
		let content = $("#content").val();
		let t_idx = $("#t_idx").val();
		
		if(content.trim()==""){
			alert("차단 사유를 입력하여주세요!");
			return false;
		}
		
		$.ajax({
			type:"post",
			data:{content:content,t_idx:t_idx},
			url:"${ctp}/message/setBanUserSend",
			success:function(res){
				if(res=="1"){
					alert("이미 차단된 회원입니다.")
					return false;
				}
				alert("상대방을 차단하였습니다.");
				setTimeout(() => {
					window.close();
				}, 100);
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자 또는 운영자에게 연락하여 주십시오.");
			}
		})
		
	}
	</script>
</head>
<body>
<div style="margin: 2%">
	<div class="mainfont-b-18">차단하기</div>
	<div>대상 : ${title}</div>
	<input type="hidden" name="t_idx" id="t_idx" value="${t_idx}">
	<div>내용</div>
	<textarea rows="6" class="form-control" name="content" id="content" placeholder="상대방을 차단하는 사유를 적어 주세요"></textarea>
	<div class="text-center mt-2">
		<button type="button" class="btn border" onclick="setBanUserSend()">차단하기</button>
		<button type="button" class="btn border" onclick="self.close()">닫기</button>
	</div>
</div>
</body>
</html>