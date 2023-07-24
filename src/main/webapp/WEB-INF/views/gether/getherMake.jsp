<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 상세</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
		"use strict";
		
		function makeGetherFormCheck(){
			let title = $("#title").val();
			let location = $("#location").val();
			let totalMember = $("#totalMember").val();
			let detailCourse = $("#detailCourse").val();
			let getherTime = $("#getherTime").val();
			let distance = $("#distance").val();
			let useTime = $("#useTime").val();
			let getHeight = $("#getHeight").val();
			let content = CKEDITOR.instances.CKEDITOR.getData();
			
			if(title.trim() == ""){
				alert("모임 제목을 입력해주세요!");
				return false;
			}
			
			if(location.trim() == ""){
				alert("모임 지역을 입력해주세요!").val();
				return false;
			}
			
			if(totalMember.trim() == ""){
				alert("모임 총원을 입력해주세요.");
				return false;
			}
			
			if(detailCourse.trim() == ""){
				alert("상세 경로를 입력해주세요.");
				return false;
			}
			
			if(getherTime.trim() == ""){
				alert("모임시간을 입력해 주세요");
				return false;
			}
			
			if(distance.trim() == ""){
				alert("모임 거리를 입력해 주세요.");
				return false;
			}
			
			if(useTime.trim() == ""){
				alert("예상 시간을 입력해 주세요");
				return false;
			}
			
			if(getHeight.trim() == ""){
				alert("획득 고도를 입력해주세요.");
				return false;
			}
			
			if(content.trim() == ""){
				alert("모임 내용을 입력해주세요.");
				return false;
			}
			
			makeGetherForm.submit();
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
	<div class="mainTitle">Make Gether</div>
	<div class="subTitle">신규 모임 등록</div>
	<form name="makeGetherForm" id="makeGetherForm" method="post" action="${ctp}/gether/getherInsert" enctype="multipart/form-data">
	<div class="row text-center align-self-center">
		<div class="col-1 align-self-center">제목</div>
		<div class="col-5">
			<span class="mainfont-b-22">
				<input type="text" name="title" id="title" class="form-control">
			</span>
		</div>
		<div class="col-1 align-self-center">지역</div>
		<div class="col-3 "><input type="text" name="location" id="location" class="form-control"></div>
		<div class="col-1 align-self-center">인원수</div>
		<div class="col-1"><input type="number" name="totalMember" id="totalMember" class="form-control mr-0"></div>
		<div class="col-12"><hr></div>
		<div class="col-1 align-self-center">경로상세</div>
		<div class="col-8"><input type="text" name="detailCourse" id="detailCourse" class="form-control mr-0"></div>
		<div class="col-1 align-self-center">모임종류</div>
		<div class="col-2">
			<select class="form-control">
				<option>선택해주세요!</option>
			</select>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-1 align-self-center">모임시간</div>
		<div class="col-2"><input type="datetime-local" name="getherTime" id="getherTime" class="form-control"></div>
		<div class="col-2 align-self-center">예상 주행 정보</div>
		<div class="col-1 align-self-center">거리</div>
		<div class="col-1"><input type="number" name="distance" id="distance" class="form-control m-0 p-0"></div>
		<div class="col-1 align-self-center">시간</div>
		<div class="col-1"><input type="number" name="useTime" id="useTime" class="form-control m-0 p-0"></div>
		<div class="col-1 align-self-center">고도</div>
		<div class="col-1"><input type="number" name="getHeight" id="getHeight" class="form-control m-0 p-0"></div>
		<div class="col-12"><hr></div>
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
		<div class="col-12 text-left">
		GPX파일
			<input type="file" name="fName" id="fName" class="form-control-file border" accept=".gpx">
			<hr>
		</div>
		<div class="col-12">
			<button type="button" class="btn border" onclick="makeGetherFormCheck()">등록하기</button>
			<button type="button" class="btn border">돌아가기</button>
		</div>
	</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>