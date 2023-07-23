<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임후기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		document.title = 'reviewTitle';
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
	<div class="row">
		<div class="col-10">
			<span class="mainfont-b-22">후기 제목이 나오는 자리입니다.</span>
		</div>
		<div class="col-2">
			<div class="mainTitle">메뉴이동버튼자리입니다.</div>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-8">모임제목이 나옵니다.</div>
		<div class="col-2">모임년도-월월-일일</div>
		<div class="col-2">완주여부</div>
		<div class="col-12"><hr></div>
		<div class="col-12 text-center">주행정보 : 거리 / 획득고도 / 예상시간 / 평균속도</div>
		<div class="col-12"><hr></div>
		<div class="col-12">
			메인내용~~
		</div>
		<div class="col-12"><hr></div>
		<div class="col-12">댓글 자리입니다</div>
		<div class="col-12">이전글 이후글 자리입니다.</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>