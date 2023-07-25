<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<div class="mainTitle">review Detail</div>
<div class="subTitle">후기 상세</div>
	<div class="row">
		<div class="col-10">
			<span class="mainfont-b-22">${grVO.title}</span>
		</div>
		<div class="col-2 text-right">
			<a href="javascript:history.back()">
				<span class="material-symbols-outlined">menu</span>
			</a>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-11">${grVO.get_title}</div>
		<div class="col-1">
			<c:if test="${grVO.clear==5}">완주못함</c:if>
			<c:if test="${grVO.clear==6}">완주성공</c:if>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-12 text-center">주행정보 : 거리 ${grVO.distance}km / 획득고도 ${grVO.getHeight}m / 평균속도 ${grVO.speed}</div>
		<div class="col-12"><hr></div>
		<div class="col-12">
			<img src="${ctp}/getherReview/${grVO.mainImage}" width="100%" height="100%">
		</div>
		<div class="col-12">
			${grVO.content}
		</div>
		<div class="col-12"><hr></div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>