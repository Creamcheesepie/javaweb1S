<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임후기 작성</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
		"use strict";
		document.title = 'reviewTitle';
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">Gether Review</div>
<div class="subTitle">모임 후기 작성</div>
	<form name="reviewForm" id="reviewForm" method="post" action="${ctp}/gether/getherReviewInput" enctype="multipart/form-data">
	<div class="row">
		<div class="col-1 text-right align-self-center">제목</div>
		<div class="col-9">
			<span class="mainfont-b-22"><input type="text" name="title" id="title" class="form-control"></span>
		</div>
		<div class="col-2 text-right">
			<a href="javascript:history.back()">
				<span class="material-symbols-outlined">menu</span>
			</a>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-8">모임제목 : ${getherVO.title}</div>
		<div class="col-3">모임시간 : 	${fn:substring(getherVO.getherTime,0,16)}</div>
		<div class="col-1">
			<c:if test="${gmVO.clear==3}">완주못함</c:if>
			<c:if test="${gmVO.clear==4}">완주성공</c:if>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-12 text-center">주행정보 : 거리 : ${gmVO.distance}km / 획득고도 :${gmVO.getHeight}m / 속도 : ${gmVO.speed} </div>
		<div class="col-12"><hr></div>
		<div class="col-12 text-left">
		대표이미지 
			<input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.gif,.png">
			<hr>
		</div>
		<div class="col-12">
			<textarea rows="12" name="content" id="CKEDITOR">
			</textarea>
			<script>
				CKEDITOR.replace("content",{
					height:330,
					filebrowserUploadUrl:"${ctp}/tempGetherImage",
					uploadUrl:"${ctp}/tempGetherImage"
				})
			</script>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-12 text-center">
		<input type="hidden" name="get_idx" id="get_idx" value="${getherVO.get_idx}">
		<input type="hidden" name="speed" id="speed" value="${gmVO.speed}">
		<input type="hidden" name="getHeight" id="getHeight" value="${gmVO.getHeight}">
		<input type="hidden" name="distance" id="distance" value="${gmVO.distance}">
		<input type="hidden" name="clear" id="clear" value="${gmVO.clear}">
		<input type="hidden" name="get_title" id="get_title" value="${getherVO.title}">
		<button type="submit" class="btn border">리뷰작성</button>
		</div>
	</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>