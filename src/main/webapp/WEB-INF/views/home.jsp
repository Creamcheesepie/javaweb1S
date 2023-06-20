<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>project(가제)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<!-- 헤더 -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark M-0 P-0">
	<a class="navbar-brand" href="${ctp}/">메인으로</a>
</nav>
<!-- 첫 이미지 표시부 -->
<div class="fullImageSlide m-0 p-0" style="width:100%;height:60%;background-color: skyblue" >
<hr/>
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
	<h2>
	놀고 먹고싶다! 인생을 꿀빨게 해달라!!
	</h2>
	<h2>
	그럴거면 로그인을 해라!!
	</h2>
	<hr/>
	</div>
	<div class="col-sm-6">
	<hr/>
	<h3>여기는 신규 글 영역입니다.</h3>
	<hr/>
	</div>
	<div class="col-sm-6">
	<hr/>
	<h3>여기는 인기 글 영역입니다(조회수 기준)</h3>
	<hr/>
	</div>
	<div class="col-sm-6">
	<hr/>
	<h3>여기는 mvp회원 영역입니다(추천수 기준)</h3>
	<hr/>
	</div>
	<div class="col-sm-6">
	<hr/>
	<h3>여기는 우수활동회원 영역입니다.(조회수 기준)</h3>
	<hr/>
	</div>
	<div class="col-sm-12">
	<hr/>
	<h1>~~~~~~~~~~~~~~~이곳은 메인 갤러리 영역입니다~~~~~~~~~~~~~~~~~~~~~~~~~~~</h1>
	<hr/>
	</div>
	<div>
	</div>
</div>

</div>
<!-- 푸터 -->
<div class="text-center" style="width:100%;height:130px; background-color: yellow">
이곳은 푸터인데요?
</div>
 </body>
</html>
