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
		<div class="warning fontdot-20">임시 정지 기간이 끝나 제한이 풀렸습니다. </div>
		<hr/>
		<div class="mainfont-b-18">다시 로그인 해 주세요.</div>
		<div class="unusualApproach-button text-right">
			<button type="button" onclick="location.href='${ctp}/member/login'" class="btn border mainfont-b-16">로그인 하러가기</button>
		</div>
	</div>
</body>
</html>