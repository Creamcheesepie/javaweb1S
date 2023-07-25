<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title>project(가제)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js"></script>
	<script>
	if(${logoutFlag} == 'ok'){
		alert("로그아웃되었습니다.");
	}
	
	Kakao.init('d50d68f65732dab8ab61379182e4fe11');
	function simpleLoginKakao(){
		Kakao.Auth.authorize({
			  redirectUri: '${ctp}/',
			  scope: 'account_email,'
			});
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
	<h2>게시판</h2>
	<div id="demo" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ul class="carousel-indicators">
	    <li data-target="#demo" data-slide-to="0" class="active"></li>
	  	<c:forEach var="nav_vo" items="${nav_vos}" varStatus="st">
	    <li data-target="#demo" data-slide-to="${st.count}"></li>
	    </c:forEach>
	  </ul>
	
	  <!-- The slideshow -->
	  <div class="carousel-inner" style="height:350px">
	    <div class="carousel-item active">
	      <a href=""><img src="la.jpg" alt="Los Angeles"></a>
	    </div>
		  <c:forEach var="nav_vo" items="${nav_vos}" varStatus="st">
	    <div class="carousel-item">
	  	<a href="${ctp}/board/list/${nav_vo.category}"><img src="${ctp}/mainCategoryIMG/${nav_vo.category}.jpg" width="100%"></a>
	    </div>
	  	</c:forEach>
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
				
				<input type="button" value="간편로그인" onclick="simpleLoginKakao()" class="btn form-control button-font border mb-1" style="height: 43px">
				<input type="button" value="회원가입" onclick="location.href='${ctp}/member/signIn'" class="btn form-control button-font border mt-1" style="height: 43px">
				
			</div>
		</div>
		
		<hr/>
		<div class="row">
			<div class="col-12">
				<span class="subTitle">News</span>
			</div>
			<c:forEach var="noticeList_vo" items="${noticeList_vos}" varStatus="st">
				<div class="col-3">
					<a href="${ctp}/board/news/${noticeList_vo.category}">${noticeList_vo.categoryName}</a>
				</div>
				<div class="col-9">
					<a href="${ctp}/board/newsRead/${noticeList_vo.boa_idx}/${noticeList_vo.category}">${noticeList_vo.title}</a>
				</div>
			</c:forEach>
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
					<c:forEach var="noticeList_vo" items="${noticeList_vos}" varStatus="st">
						<div class="col-3">
							<a href="${ctp}/board/news/${noticeList_vo.category}">${noticeList_vo.categoryName}</a>
						</div>
						<div class="col-9">
							<a href="${ctp}/board/newsRead/${noticeList_vo.boa_idx}/${noticeList_vo.category}">${noticeList_vo.title}</a>
						</div>
					</c:forEach>
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
				<c:forEach var="boardNew_vo" items="${boardList_vos}" varStatus="st">
					<div class="col-2 mainfont-m-16 text-center">
					<a href="${ctp}/board/list/${boardNew_vo.category}">${boardNew_vo.categoryName}</a>
					</div>
					<div class="col-10 mainfont-m-16">
					<a href="${ctp}/board/read/${boardNew_vo.boa_idx}/${boardNew_vo.category}">${boardNew_vo.title}</a>
					</div>
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
			<c:forEach var="boardHot_vo" items="${boardHotList_vos}" varStatus="st">
				<div class="col-2 agro-b-16 text-center">
				<a href="${ctp}/board/list/${boardHot_vo.category}">${boardHot_vo.categoryName}</a>
				</div>
				<div class="col-10 agro-b-16">
				<a href="${ctp}/board/read/${boardHot_vo.boa_idx}/${boardHot_vo.category}">${boardHot_vo.title}</a>
				</div>
			</c:forEach>
		</div>		
	</div>
	<div class="col-sm-6">
			<hr/>
			<h3 class="listTitle">
			<span class="material-symbols-outlined listTitle-icon">directions_bike</span>
			&nbsp;최근 모임 후기</h3>
		<hr/>
		<div class="row">
			<c:forEach var="grVO" items="${getherListVOS}" varStatus="st">
				<div class="col-3"><!-- 메인 사진 영역 -->
					<img src="${ctp}/getherReview/${grVO.mainImage}" width="100%" height="100%">
				</div>
				<div class="col-9 text-left">
					<div class="fontdot-12">${grVO.nickName}</div>
					<div class="mainfont-b-22">
					<a href="${ctp}/gether/reviewDetail/${grVO.ger_idx}">${grVO.title}</a>
					</div>
					<div class="mainfont-m-16 inactive">${grVO.get_title}</div>
				</div>
				<div class="col-12"><hr></div>
			</c:forEach>
		</div>
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
