<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container myPage-container">
<div class="mainfont-b-28">쪽지함</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<button type="button" class="btn mainfont-b-22">쪽지쓰기</button>
	<hr>
	<div class="mainfont-b-16">
		<a href="${ctp}/message/send">보낸 쪽지함</a>
		<hr/>
		<a href="${ctp}/message/receive">받은 쪽지함</a>
		<hr/>
		<a href="${ctp}/message/report">신고 쪽지함</a>
		<hr/>
		<a href="${ctp}/message/ask">문의 쪽지함</a>
		<hr/>
	</div>
	</div>
	<div class="col-10">
		
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>