<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지입니다.</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		'use Strict';
		
		function ruleUpdateFormPost(){
			ruleUpdateForm.submit();
		};
		
		function adminReportFormPost(){
			adminReportForm.submit();
		};
		
		function adminAskFormPost(){
			adminAskForm.submit();
		};
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>

		<div class="row">
			<div class="col-6">
				회원 변동
				7일내 신규유저 수
				등급업 유저 수
				등급별 유저 수
				신규유저 추이
				
			</div>
			<div class="col-6">
				
			</div>
		</div>
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>