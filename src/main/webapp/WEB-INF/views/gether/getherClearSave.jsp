<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 결과 저장</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		document.title = 'category_Name';
	</script>
</head>
<body>
<div style="margin: 15px 15px 15px 15px">
	<div class="mainTitle">${getherVO.title}모임 결과</div>
	<form name="getherClearForm" id="getherClearForm" method="post" action="${ctp}/gether/getherClearSave">
	<div class="row" style="width: 450px;">
		<div class="col-12 text-right">
		<span class="mainfont-b-20">닉네임 : ${sNickName}님</span>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-4">속도</div>
		<div class="col-4">거리</div>
		<div class="col-4">획득고도</div>
		<div class="col-3 mr-0">
			<input type="number" name="speed" id="speed" class="form-control">
		</div>
		<div class="col-1 text-left align-self-end ml-0 fontdot-12">Km/h</div>
		<div class="col-3 mr-0">
			<input type="number" name="distance" id="distance" class="form-control">
		</div>
		<div class="col-1 text-left align-self-end ml-0 fontdot-12">Km</div>
		<div class="col-3">
			<input type="number" name="getHeight" id="getHeight" class="form-control">
		</div>
		<div class="col-1 text-left align-self-end ml-0 fontdot-12">m</div>
		<div class="col-12"><hr></div>
		<div class="col-5"></div>
		<div class="col-3 text-right align-self-center mt-2">
		완주여부
		</div>
		<div class="col-4">
		<select name="clear" id="clear" class="form-control">
			<option value="1">미완주</option>
			<option value="2">완주</option>
		</select>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-12 text-center">
			<input type="hidden" name="get_idx" id="get_idx" value="${getherVO.get_idx}">
			<button type="submit" class="btn border" style="width: 100px">입력</button>
		</div>
	</div>
	</form>
</div>
</body>
</html>