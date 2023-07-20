<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차단하기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<style>
		body{
			background-color: #F2F2F2;
		}
		.myPage-container{
			background-color:white;
			height:100% ;
			margin-top: 8%;
			margin-bottom: 5%;
			border-radius: 22px;
			border-style: solid;
			border-color: lightgray;
			padding : 2%;
			width: 1000px;
		}
		.inst{
			width: 100%;
		}
		.list{
			min-height: 150px;
		}
	</style>
	<script>
	'use strict';
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container myPage-container">
<div class="mainfont-b-28"><span class="material-symbols-outlined">person_off</span>차단하기</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<div class="mainfont-b-16">
	<jsp:include page="/WEB-INF/views/include/friendBanSideBar.jsp"/>
		<hr/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">사용자 검색</span><span class="mainfont-b-16 inactive"></span>
		<hr>
		<form name="searchForm" method="post" action="${ctp}/member/banAdd">
		<div class="row text-center">
			<div class="col-2 align-self-center">
				<select name="searchOption" id="searchOption" class="form-control">
					<option value="nickName">닉네임</option>
					<option value="mid">아이디</option>
					<option value="name">이름</option>
				</select>
			</div>
			<div class="col-7">
				<input type="text" name="searchStr" id="searchStr" class="form-control">
			</div>
			<div class="col-2">
				<button type="submit" class="btn form-control border">검색</button>
			</div>
			<div class="col-12"><hr></div>	
		</div>
		</form>
		<div class="row mainfont-b-16 text-center">
			<c:forEach var="sr_vo" items="${searchResultVOS}" varStatus="st">
			<div class="col-1 align-self-center">${sr_vo.level}</div>
			<div class="col-3 align-self-center">${sr_vo.nickName}(${sr_vo.mid})</div>
			<div class="col-2 align-self-center">${sr_vo.name}</div>
			<div class="col-3 m-0 p-0 align-self-center">${sr_vo.duration}h/${sr_vo.speed}km/${sr_vo.getHeight}m</div>
			<div class="col-2 ml-0 pl-0 align-self-center">
			<c:if test="${sr_vo.status==2}">
				<span class="inactive">친구</span>
			</c:if>
			<c:if test="${sr_vo.status==1}">
				친구 신청중
			</c:if>
			<c:if test="${sr_vo.status==0}">
				<button type="button" class="btn border" onclick="window.open('${ctp}/message/setBanUser/${sr_vo.m_idx}?title=${sr_vo.nickName}', '차단하기', 'width=515, height=460')">차단하기</button>
			</c:if>
			<c:if test="${sr_vo.status>2}">
				차단유저
			</c:if>
			</div>
			<div class="col-12"><hr></div>	
			</c:forEach>
			<c:if test="${empty searchResultVOS}">
				<div class="col-12">
					<span class="inactive">검색 결과가 없습니다.</span>
				</div>
			</c:if>
		</div>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>