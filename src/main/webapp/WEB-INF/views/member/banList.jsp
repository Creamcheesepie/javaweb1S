<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차단목록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<style>
		body{
			background-color: #F2F2F2;
		}
		.myPage-container{
			background-color:white;
			height:100% ;
			margin-top: 8%;
			margin-bottom: 5%;
			border-radius: 22px;
			border-style: solid;
			border-color: lightgray;
			padding : 2%;
			width: 1000px;
		}
		.inst{
			width: 100%;
		}
		.list{
			min-height: 150px;
		}
	</style>
	<script>
	'use strict';
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container myPage-container">
<div class="mainfont-b-28"><span class="material-symbols-outlined">do_not_touch</span>차단목록</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<div class="mainfont-b-16">
	<jsp:include page="/WEB-INF/views/include/friendBanSideBar.jsp"/>
		<hr/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">차단목록</span><span class="mainfont-b-16 inactive"></span>
		<hr>
		<div class="row text-center">
			<div class="col-2 align-self-center">닉네임</div>
			<div class="col-2 align-self-center">아이디</div>
			<div class="col-4 align-self-center">사유</div>
			<div class="col-2 align-self-center">차단일</div>
			<div class="col-2 ml-0 pl-0 align-self-center">비고</div>
			<div class="col-12"><hr></div>	
		</div>
		<div class="row mainfont-m-14 text-center">
			<c:forEach var="ban_vo" items="${banListVOS}" varStatus="st">
			<div class="col-2 align-self-center">${ban_vo.nickName}</div>
			<div class="col-2 align-self-center">${ban_vo.mid}</div>
			<div class="col-4 align-self-center">${ban_vo.extra}</div>
			<div class="col-2 align-self-center">${fn:substring(ban_vo.setDate,0,10)}</div>
			<div class="col-2 ml-0 pl-0 align-self-center"><button type="button" class="btn border">해제</button></div>
			<div class="col-12"><hr></div>	
			</c:forEach>
			<c:if test="${empty banListVOS}">
				<div class="col-12">
					<span class="inactive">아직 차단한 유저가 없습니다.</span>
				</div>
			</c:if>
		</div>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>