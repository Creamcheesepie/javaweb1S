<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임예정</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">Gether Schedule</div>
<div class="subTitle">예정된 모임</div>
	<div class="row">
		<div class="col-2"><!-- 사이드바 영역 -->
			<jsp:include page="/WEB-INF/views/include/getherSideBar.jsp"/>
		</div>
		<div class="col-10"><!-- 메인 리스트 영역 -->
			<div><!-- 리스트 하나 -->
			<c:forEach var="getherVO" items="${getherVOS}">
				<div class="row">
					<div class="col-9">
						<div class="mainfont-b-22">
							${getherVO.title}
						</div>
						<div class="mainfont-b-18">${getherVO.location}</div>
						<div class="mainfont-b-16 inactive">${getherVO.content}</div>
					</div>
					<div class="col-3 text-right align-self-end">
						<div class="mainfont-b-16">${getherVO.getherTime}</div>
						<div class="mainfont-b-18">${getherVO.nickName}(${getherVO.name})</div>
						<div class="fontdot-12 ">참여여부</div>
						<div class="mainfont-m-16 ">${getherVO.nowMember} / ${getherVO.totalMember}</div>
					</div>
				</div>
			</c:forEach>
			<c:if test="${empty getherVOS}">
				<div class="mainfont-b-22 inactive">
					현재 참여가능한 모임이 없습니다.
				</div>
			</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>