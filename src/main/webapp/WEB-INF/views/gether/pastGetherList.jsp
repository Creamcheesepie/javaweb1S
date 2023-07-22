<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지난 모임</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">Past Gether</div>
<div class="subTitle">지난 모임</div>
	<div class="row">
		<div class="col-2"><!-- 사이드바 영역 -->
			<div class="subTitle-dot">
				<a href="${ctp}/gether/afterList">지난모임</a>
				<hr>
				<a>모임후기</a>
				<hr>
				<a>지난모임</a>
			</div>
		</div>
		<div class="col-10"><!-- 메인 리스트 영역 -->
			<div><!-- 리스트 하나 -->
				<div class="row">
					<div class="col-9">
						<div class="mainfont-b-22">
							모임 제목을 입력하는 자리입니다.
						</div>
						<div class="mainfont-b-18">모임 지역이 나오는 자리입니다.</div>
						<div class="mainfont-b-16 inactive">모임 내용이 나오는 자리입니다.</div>
					</div>
					<div class="col-3 text-right align-self-end">
						<div class="mainfont-b-16">모임일자-월월-일일</div>
						<div class="mainfont-b-18">모임장닉네임(장이름)</div>
						<div class="fontdot-12 ">참여여부</div>
						<div class="mainfont-m-16 ">인원/총인원</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>