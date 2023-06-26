<%@ pag e language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/views/include/postCodeFind.js"></script>
	<style>
		.signInTitle{
			font-family: 'IBM Plex Sans KR', sans-serif;
			font-weight:600;
			font-size: 35px;
		}
		.signInSubtitle{
			font-family: 'IBM Plex Sans KR', sans-serif;
			font-weight:600;
			font-size: 18px;
		}
		.button-text{
			font-family: 'IBM Plex Sans KR', sans-serif;
			font-weight:600;
			font-size: 18px;
		}
		.titleIcon{
			font-size:38px;
			margin : 0;
			vertical-align:middle;
		}
	</style>
</head>
<body>
<div class="container" >
	<form name="signInNextForm" method="post">
	<div class="signInTitle text-center" style="margin-top:10%"><span class="material-symbols-outlined titleIcon">person_add</span>&nbsp;회원가입</div>
	<div style="border-radius: 22px; border:1px; border-style:solid; border-color:lightgray ;width: 400px; height: 100%; padding:15px;margin: 2% auto">
	 <div class="signInSubtitle">전화번호</div>
	 <div><input type="text" name="tel" id="tel" class="form-control"></div>
	 <div>
	 	<span class="signInSubtitle">나이</span>
		<div style="width: 150px"><input type="number" name="tel" id="tel" class="form-control"></div> 
	</div>
	<div class="signInSubtitle">성별</div>
	<div><input type="text" name="gender" name="gender" class="form-control"></div> 
	<div class="signInSubtitle">주소</div>
		<div class="form-group"> <!-- 주소 div 시작 -->
			<div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
		      <label for="address">&nbsp;주소</label>
		      <input type="hidden" name="address" id="address">
		      <div class="input-group mb-1">
		        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
		        <div class="input-group-append">
		          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
		        </div>
		      </div>
		     </div>
		    <div class="col-sm-3"></div> 
      </div>
      <div class="row">
				<div class="col-sm-3"></div>
				<div class="col-sm-6">
	      	<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
	      </div>
				<div class="col-sm-3"></div>
	     </div>
      <div class="row">
	     <div class="col-sm-3"></div>
				<div class="col-sm-6">
	      <div class="input-group ">
	        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
	        <div class="input-group-append">
	          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
	        </div>
	       </div>
	     <div class="col-sm-3"></div>
	    </div>
      </div>
    </div><!-- 주소 div 끝 -->
    <div class="signInSubtitle">사진</div>
    <div><input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.png,.gif"></div>
   	<div class="signInSubTitle">소개</div>
	</div>
	</form>
</div>	
</body>
</html>