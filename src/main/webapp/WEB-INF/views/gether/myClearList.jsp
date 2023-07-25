<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 기록 모음</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">My ClearList</div>
<div class="subTitle">내 기록 모음</div>
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
							<a href="${ctp}/gether/getherDetail/${getherVO.get_idx}">${getherVO.title}</a>
						</div>
						<div class="mainfont-b-18">${getherVO.location}</div>
						<div class="mainfont-b-16 inactive">${getherVO.detailCourse}</div>
					</div>
					<div class="col-3 text-right align-self-end">
						<div class="mainfont-b-16">모임날짜 ${fn:substring(getherVO.getherTime,0,10)}</div>
						<div class="mainfont-b-18">
							<c:if test="${getherVO.clear==1}">완주못함<br>(모임장미확인)</c:if>
							<c:if test="${getherVO.clear==2}">완주성공<br>(모임장미확인)</c:if>
							<c:if test="${getherVO.clear==3}">완주못함<br>(모임장확인)</c:if>
							<c:if test="${getherVO.clear==4}">완주성공<br>(모임장확인)</c:if>
							<c:if test="${getherVO.clear==5}">완주못함<br>(후기작성완)</c:if>
							<c:if test="${getherVO.clear==6}">완주성공<br>(후기작성완)</c:if>
						</div>
					</div>
					<div class="col-8">
						<div class="mainfont-m-16 ">속도${getherVO.speed}/거리${getherVO.distance}/획득고도${getherVO.getHeight}</div>
					</div>
					<div class="col-4 text-right">
							<c:if test="${getherVO.clear==3 || getherVO.clear==4}">
							<form method="post" action="${ctp}/gether/reviewWrite">
							<button type="submit" class="btn border">후기작성</button>
							<input type="hidden" name="rv_get_idx" id="rv_get_idx" value="${getherVO.get_idx}">
							</form>
							</c:if>
					</div>
				</div>
					<hr>
			</c:forEach>
			<c:if test="${empty getherVOS}">
				<div class="mainfont-b-22 inactive">
					아직 모임에 참여한 적이 없거나 기록을 남기지 않았습니다.
				</div>
			</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	


</body>
</html>