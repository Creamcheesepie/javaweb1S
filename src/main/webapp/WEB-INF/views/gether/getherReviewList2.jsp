<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		document.title = 'category_Name';
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">Gether Review</div>
<div class="subTitle">모임 후기</div>
	<div class="row">
		<div class="col-2"><!-- 사이드바 영역 -->
			<jsp:include page="/WEB-INF/views/include/getherSideBar.jsp"></jsp:include>
		</div>
		<div class="col-10"><!-- 메인 리스트 영역 -->
			<div class="row">
				<c:forEach var="grVO" items="${grVOS}" varStatus="st">
					<div class="col-3"><!-- 메인 사진 영역 -->
						<img src="${ctp}/getherReview/${grVO.mainImage}" width="100%" height="100%">
					</div>
					<div class="col-9 text-left">
						<div class="fontdot-12">${grVO.nickName}</div>
						<div class="mainfont-b-22">${grVO.title}</div>
						<div class="mainfont-b-18 inactive">${grVO.get_title}</div>
						<div class="mainfont-m-16 inactive">${fn:substring(grVO.content,0,25)}</div>
					</div>
				<div class="col-12"><hr></div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>