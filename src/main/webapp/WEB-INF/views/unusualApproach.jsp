<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>잘못된 경로입니다!</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<style>
	.unusualApproach{
		width : 600px;
		height : 300px;
		margin : 3% auto;
		border-radius:25px;
		border-style:solid;
		border-coler:lightgray;
		border-width: 1px;
		padding:3%;
		position:relative;
	}
	.unusualApproach-button{
		bottom : 30px;
		right: 30px;
		position: absolute;
	}
	
	</style>
</head>
<body>
	<div class="unusualApproach">
		<div class="warning fontdot-20">잘못된 경로로 접근하였습니다!</div>
		<hr/>
		<div class="mainfont-b-18">올바른 방법으로 접근해 주세요.</div>
		<div class="unusualApproach-button text-right">
			<button type="button" onclick="location.href='${ctp}/'" class="btn border mainfont-b-16">홈으로 돌아가기</button>
		</div>
	</div>
</body>
</html>