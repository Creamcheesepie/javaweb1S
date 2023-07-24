<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<div class="subTitle-dot">
<%-- 	<c:if test="${sLogin =='ok' }">
	<hr>
	<div class="text-left">
		<a href="${ctp}/gether/myGether">내 모임</a>
	</div>
	<div class="text-right">
		<a href="${ctp}/gether/myReview">내 후기</a>
	</div>
	<hr>
	</c:if> --%>
	<div class="text-center">
	<c:if test="${sLevel<3}">
	<a href="${ctp}/gether/makeGether">모임등록</a>
	<hr>
	</c:if>
	<a href="${ctp}/gether/afterList">모임예정</a>
	<hr>
	<a href="${ctp}/gether/reviewList">모임후기</a>
	<hr>
	<a href="${ctp}/gether/pastList">지난모임</a>
	</div>
</div>
