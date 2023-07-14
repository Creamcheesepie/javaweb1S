<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
</head>
<script>
	'use strict';
	$(document).ready(function(){
		let sendedSw = '${sendedSw}';
		if(sendedSw=="ok"){
			alert("신고하였습니다. 관리자 또는 운영자가 확인 후 처리하도록 하겠습니다.");
			window.close();
		}
	})
	
	function reportSend(){
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
		
		reportForm.submit();
	}
	
	
	
</script>
<body>
<span class="mainTitle">신고하기</span>
<form name="reportForm" id="reportForm" method="post" action="${ctp}/message/reportSend">
<div class="row" style="padding: 5px 15px 0px 15px">
	<div class="col-3 mainfont-b-18">신고 대상</div>
	<div class="col-9 mainfont-b-18">${title}</div>
	<div class="col-12"><hr></div>
	<div class="col-2 text-center mainfont-b-18">사유</div>
	<div class="col-2">
	<select class="rep_category" name="rep_category" id="searchOption" class="form-control">
		<c:forEach var="categoryVO" items="${categoryVOS}" varStatus="st">
			<option value="${categoryVO.rep_category}">${categoryVO.category_name}</option>
		</c:forEach>
	</select>
	</div>
	<div class="col-12"><hr/></div>
	<div class="col-2 text-center align-self-center"><span class="mainfont-b-18">제목</span></div>
	<div class="col-10">
		<input type="text" name="title" id="title" class="form-control">
	</div>
	<div class="col-12"><hr/></div>
	<div class="col-12 mb-2">
	<span class="mainfont-b-16">내용</span>
	</div>
	<div class="col-12">
		<textarea rows="6" class="form-control" name="content" id="content"></textarea>
	</div>
	<div class="col-12"><hr/></div>
	<div class="col-12 text-center">
		<input type="hidden" name="m_idx" id="m_idx" value="${sM_idx}">
		<input type="hidden" name="reported_idx" id="reported_idx" value="${reported_idx}">
		<button class="btn border">다시쓰기</button>
		<button type="button" class="btn border" onclick="reportSend()">신고하기</button>
	</div>
</div>
</form>
</body>
</html>