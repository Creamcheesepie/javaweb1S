<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<a href="${ctp}/message/sendList">보낸 쪽지함</a>
	<hr/>
	<a href="${ctp}/message/receiveList">받은 쪽지함</a>
	<hr/>
	<a href="${ctp}/message/reportList">신고 처리함</a>
	<hr/>
	<a href="${ctp}/message/askList">문의 쪽지함</a>