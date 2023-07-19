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
			let ans = confirm("문의가 보내졌습니다, 더 문의하시겠습니까?");
			if(!ans) window.close();
			else return false;
		}
		
	})
	
	function askSend(){
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
		
		askSendForm.submit();
	}
	
	
	</script>
</head>
<body>
<form name="askSendForm" method="post" action="${ctp}/message/askSend">
<input type="hidden" name="m_idx" id="m_idx" value="${sM_idx}">
<div class="row" style="padding: 10px 30px 0px 30px">
	<div class="col-12 mainTitle">문의 하기</div>
	<div class="col-8">
	제목
	</div>
	<div class="col-4">
	분류
	</div>
	<div class="col-8">
	<input type="text" placeholder="문의 제목을 입력해 주세요." class="form-control" name="title" id="title">
	</div>
	<div class="col-4">
		<select class="form-control" name="ask_category" id="ask_category">
			<c:forEach var="ask_categoryVO" items="${ask_categoryVOS}" varStatus="st">
				<option value="${ask_categoryVO.ask_category}">${ask_categoryVO.category_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="col-12">
	내용
	</div>
	<div class="col-12">
		<textarea rows="8" class="form-control" name="content" id="content"></textarea>
	</div>
	<div class="col-12 text-center mt-2">
		<button type="button" class="btn border" onclick="window.location.reload()">다시 쓰기</button>
		<button type="button" class="btn border" onclick="askSend()">쪽지 보내기</button>
	</div>
</div>
</form>
</body>
</html>