<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 결과 저장</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		document.title = 'category_Name';
	</script>
</head>
<body>
<div style="margin: 15px 15px 15px 15px">
	<div class="mainTitle">${getherVO.title}모임 결과</div>
	<div class="mainfont-b-20">${sNickName}님</div>
	<div class="mainfont-b-18">속도</div>
	<div style="width:150px"><input type="number" class="form-control"></div>
	<div class="mainfont-b-18">거리</div>
	<div style="width:150px"><input type="number" class="form-control"></div>
	<div class="mainfont-b-18">획득고도</div>
	<div style="width:150px"><input type="number" class="form-control"></div>
	<button type="button" class="btn border" style="width: 100px">입력</button>
</div>
</body>
</html>