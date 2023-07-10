<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>project(가제)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
	if(${logoutFlag} == 'ok'){
		alert("로그아웃되었습니다.");
	}
	</script>
</head>
<body>
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
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
				<input type="button" value="회원가입" onclick="location.href='${ctp}/member/signIn'" class="btn form-control button-font border mt-1" style="height: 43px">
				
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
		<span class="subTitle">${sNickName}님 환영합니다.</span>
		<div class="statusContent">회원등급 : ${sStrLevel}</div>
		<div class="subTitle">라이딩 정보</div>
		<div class="statusContent">평균속도: ${sSpeed}km/h</div>
		<div class="statusContent">주행시간: ${sDuration}시간</div>
		<div class="statusContent">획득고도: ${sGetheight}m</div>
		<!-- 받은 쪽지 알림, 속도,시간,획득고도 정보 표시>예약활동에 맞추어서 갱신하기 -->
		<span></span>
		<hr/>
		<div class="row">
			<div class="col-12">
				<span class="subTitle">News</span>
			</div>
		</div>
		</c:if>
	</div>
	<div class="col-sm-6">
		<hr/>
		<h3 class="listTitle">
		<span class="material-symbols-outlined listTitle-icon">autorenew</span>
		&nbsp;신규 글</h3>
		<hr/>
		<div class="row">
			<div class="col-12 p0 m0">
				<div class="row">
				<c:forEach var="boardNew_vo" items="${boardList_vo}" varStatus="st">
					<div class="col-2 mainfont-m-16 text-center">${boardNew_vo.categoryName}</div>
					<div class="col-10 mainfont-m-16">${boardNew_vo.title}</div>
				</c:forEach>
				</div>
			</div>
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
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
 </body>
</html>
