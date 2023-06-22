<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>project(가제)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<style>
	.listTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
	}
	.subTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:600;
		font-size: 20px;
	}
	.material-symbols-outlined {
	  font-variation-settings:
	  'FILL' 0,
	  'wght' 500,
	  'GRAD' 0,
	  'opsz' 48
	}
	.galary-icon{
		font-size:37px;
		margin : 0;
		vertical-align:middle;
	}
	.listTitle-icon{
		font-size: 26px;
		vertical-align:middle;
	}
	.subTitle-icon{
		font-size: 24px;
		vertical-align:middle;
	}
	hr{
		margin : 10px 0px 10px 0px;
	}
	.font-bold{
		font-weight: 800;
	}
	.button-font{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:18px;
	}
	.button-font-big{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:24px;
	}
	.footerTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:400;
		font-size:20px;
	}

	</style>
</head>
<body>
<!-- 헤더 -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark M-0 P-0">
	<a class="navbar-brand" href="${ctp}/">메인으로</a>
</nav>
<!-- 첫 이미지 표시부 -->
<div class="fullImageSlide m-0 p-0" style="width:100%;height:60%;background-color: skyblue" >
</div>



<!-- 게시글 정보 표시부 -->
<div class="container">
<hr/>
<div class="row">
	<div class="col-sm-8">
	<h2>아무거나 규탄한다! 이것저것 보장하라!</h2>
	<div id="demo" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ul class="carousel-indicators">
	    <li data-target="#demo" data-slide-to="0" class="active"></li>
	    <li data-target="#demo" data-slide-to="1"></li>
	    <li data-target="#demo" data-slide-to="2"></li>
	  </ul>
	
	  <!-- The slideshow -->
	  <div class="carousel-inner" style="height:350px">
	    <div class="carousel-item active">
	      <img src="la.jpg" alt="Los Angeles">
	    </div>
	    <div class="carousel-item">
	      <img src="chicago.jpg" alt="Chicago">
	    </div>
	    <div class="carousel-item">
	      <img src="ny.jpg" alt="New York">
	    </div>
	  </div>
	
	  <!-- Left and right controls -->
	  <a class="carousel-control-prev" href="#demo" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  <a class="carousel-control-next" href="#demo" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	
		</div>
		<hr/>
	</div>
	<div class="col-sm-4">
		<c:if test="${sLogin !='ok'}">
		<span class="subTitle">로그인</span>
		<div class="row">
			<div class="col-7 p-1">
				<input type="button" value="로그인" onclick="location.href='${ctp}/member/login'" class="btn form-control button-font-big border" style="height:94px;">
			</div>
			<div class="col-5 p-1 text-center">
				
				<input type="button" value="간편로그인" onclick="simpleloginCheck()" class="btn form-control button-font border mb-1" style="height: 43px">
				<input type="button" value="회원가입" onclick="signInCheck()" class="btn form-control button-font border mt-1" style="height: 43px">
				
			</div>
		</div>
		
		<hr/>
		<div class="row">
			<div class="col-12">
				<span class="subTitle">News</span>
				
			</div>
		</div>
		</c:if>
		<c:if test="${sLogin =='ok'}">
		<span class="subTitle">${sNickName}</span>
		</c:if>
	</div>
	<div class="col-sm-6">
		<hr/>
		<h3 class="listTitle">
		<span class="material-symbols-outlined listTitle-icon">autorenew</span>
		&nbsp;신규 글</h3>
		<hr/>
		<div class="row">
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
		</div>
	</div>
	<div class="col-sm-6">
		<hr/>
			<h3 class="listTitle">
			<span class="material-symbols-outlined listTitle-icon">auto_awesome</span>
			&nbsp;인기 글(조회수 기준)</h3>
		<hr/>
		<div class="row">
				<div class="col-2">항목</div>
				<div class="col-10">is simply dummy text of the printing and t</div>
				<div class="col-2">항목</div>
				<div class="col-10">typesetting industry. Lorem</div>
				<div class="col-2">항목</div>
				<div class="col-10">psum has been the industry's standard dummy text ever</div>
				<div class="col-2">항목</div>
				<div class="col-10">since the 1500s, when an unknown printers</div>
				<div class="col-2">항목</div>
				<div class="col-10">took a galley of type and</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
				<div class="col-2">항목</div>
				<div class="col-10">제목</div>
		</div>		
	</div>
	<div class="col-sm-6">
			<hr/>
			<h3 class="listTitle">
			<span class="material-symbols-outlined listTitle-icon">tips_and_updates</span>
			&nbsp;유저정보</h3>
		<hr/>
	
	</div>
	<div class="col-sm-3">
		<hr/>
		<h4 class="listTitle"><span class="material-symbols-outlined subTitle-icon">hotel_class</span>&nbsp;저번달 MVP 라이더</h4>
		<hr/>
	</div>
	<div class="col-sm-3">
		<hr/>
		<h4 class="listTitle align-self-center"><span class="material-symbols-outlined subTitle-icon">bolt</span>&nbsp;최근 우수 활동 회원</h4>
		<hr/>
	</div>
	<div class="col-sm-12">
		<hr/>
		<h1 class="listTitle"><span class="material-symbols-outlined galary-icon">photo_library</span>&nbsp;메인 갤러리</h1>
		<hr/>
	</div>
	<div>
	</div>
</div>

</div>
<!-- 푸터 -->
<div class="text-center align-self-center" style="width:100%;height:130px; background-color: lightgray">
<div style="height:35px"></div>
<span class="footerTitle">Design by chinpang</span>
</div>
 </body>
</html>
