<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getherHome</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
</head>
<style>
img {
  object-fit: cover;
}
</style>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">Gether</div>
<div class="subTitle">최근 모임 후기</div>
<div class="row text-center">
	<div class="col-9">
		<div><!-- 모임 한 단위 -->
			<div class="row" style="height: 100px">
					<c:forEach var="grVO" items="${grVOS}" varStatus="st">
						<div class="col-3"><!-- 메인 사진 영역 -->
							<img src="${ctp}/getherReview/${grVO.mainImage}" width="100%" height="100%">
						</div>
						<div class="col-9 text-left">
							<div class="fontdot-12">${grVO.nickName}</div>
							<div class="mainfont-b-22">
								<a href="${ctp}/gether/reviewDetail/${grVO.ger_idx}">${grVO.title}</a>
							</div>
							<div class="mainfont-m-16 inactive">${grVO.get_title}</div>
						</div>
						<div class="col-12"><hr></div>
					</c:forEach>
			</div>
		</div>
	</div>
	<div class="col-3">
		<div class="mainTitle test-left">참여가능 모임</div>
		<div class="mainfont-b-22 text-center">${availableGether}개</div>
		<div class="mainfont-b-22 text-right">
			<a href="${ctp}/gether/afterList">참여하기</a>
		</div>
		<c:if test="${sLevel<3}">
			<hr>
			<div class="mainTitle">
			<a href="${ctp}/gether/makeGether">모임 만들기</a>
			</div>
			<hr>
		</c:if>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>