<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
	<div class="container">
		<div class="row text-center mainfont-b-20" style="margin-top:3%">
			<div class="col-12 mainTitle-dot text-left">오늘의 출석</div>
			<div class="col-3"><hr/></div><div class="col-9"></div>
			<div class="col-2"></div>
			<div class="col-2">
				<c:if test="${sLogin != 'ok'}" >
					<span class="mainfont-b-20-inactive">로그인하세요!</span>
				</c:if>
				<c:if test="${sLogin == 'ok'}">
					<span class="mainfont-b-18">${sNickName}</span>
				</c:if>
			</div>
			<div class="col-4"><input type="text" name="attendanceContent" id="attendanceContent" placeholder="한마디 적어주세요"  class="form-control"/></div>
			<div class="col-2">
				<c:if test="${sLogin != 'ok'}" >
					<button type="button" class="form-control"><span>로그인하러가기</span></button>
				</c:if>
				<c:if test="${sLogin == 'ok'}">
					<button type="button" class="form-control"><span>출석!</span></button>
				</c:if>	
			</div>
			<div class="col-2"></div>
			<div class="col-2"></div>
			<div class="col-8"><hr/></div>
			<div class="col-2"></div>
			<div class="col-2"></div>
			<div class="col-2">작성자</div>
			<div class="col-4">내용</div>
			<div class="col-2">작성일자</div>
			<div class="col-2"></div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>