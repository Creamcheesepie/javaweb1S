 <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 쓰기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
	'use strict';
	$(document).ready(function(){
		let sendedSw = '${sendedSw}';
		if(sendedSw=="ok"){
			alert("답장을 보냈습니다.");
			window.close();
		}
	})
	
	
	function messageSend(){
		let title = $("#title").val();
		let content = $("#content").val();
		
		if(title.trim() == ""){
			alert("제목을 입력하여 주십시오.");
			$("#title").focus();
			return false;
		}
		
		if(content.trim()==""){
			alert("내용을 입력하여 주십시오.");
			$("#content").focus();
			return false;
		}
		
		messageSendForm.submit();
	}
	</script>
</head>
<body>
<form name="messageSendForm" method="post" action="${ctp}/message/send">
<div class="row" style="padding: 10px 30px 0px 30px">
	<div class="col-12 mainTitle">답장 쓰기</div>
	<div class="col-12">
		<span class="mainfont-b-18">To ${messageVO.nickName}</span>
		<input type="hidden" name="receive_m_idx" id="receive_m_idx" value="${messageVO.m_idx}">
		<input type="hidden" name="m_idx" id="m_idx" value="${sM_idx}">
		<input type="hidden" name="msg_category" id="msg_category" value="100">
		<input type="hidden" name="answerCheck" id="answerCheck" value="1">
	</div>
	<div class="col-12">
	제목
	</div>
	<div class="col-12">
	<input type="text" value="re:${messageVO.title}" readonly class="form-control" name="title" id="title">
	</div>
	<div class="col-12">
	내용 
	</div>
	<div class="col-12">
		<textarea rows="8" class="form-control" name="content" id="content"></textarea>
	</div>
	<div class="col-12 text-center mt-2">
		<button type="button" class="btn border" onclick="window.location.reload()">다시 쓰기</button>
		<button type="button" class="btn border" onclick="messageSend()">쪽지 보내기</button>
	</div>
</div>
</form>
</body>
</html>