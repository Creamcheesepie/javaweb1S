<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<a href="${ctp}/member/friendList">친구목록</a>
	<hr/>
	<a href="${ctp}/member/friendAdd">친구추가</a>
	<hr/>
	<a href="${ctp}/member/banList">차단목록</a>
	<hr/>
	<a href="${ctp}/member/banAdd">차단하기</a>