<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<div class="subTitle-dot">
	<c:if test="${sLevel<3}">
	<a href="${ctp}/gether/makeGether">모임등록</a>
	<hr>
	</c:if>
	<a href="${ctp}/gether/afterList">모임예정</a>
	<hr>
	<a href="${ctp}/gether/reviewList">모임후기</a>
	<hr>
	<a>지난모임</a>
</div>
