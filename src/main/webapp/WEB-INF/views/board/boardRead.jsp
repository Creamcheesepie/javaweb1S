<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
</head>
<body> 
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
	<div class="mainTitle" style="margin-top: 3%">News</div>
	<div class="row" >
		<div class="col-6">
			<div class="mainTitle">${categoryName}</div>
		</div>
		<div class="col-6 text-right">
		</div>
	</div>
	<div class="row" style="margin-bottom: 2%">
		<div class="col-sm-2 text-center"><!-- 사이드바 영역 -->
			<a href="${ctp}/board/news/2" class="subTitle-dot">
				<c:if test="${category==2}">새 소식</c:if>
				<c:if test="${category!=2}"><span class="inactive">새 소식</span></c:if>
			</a>
			<hr/>
			<a href="${ctp}/board/news/1" class="subTitle-dot">
				<c:if test="${category==1}">공지사항</c:if>
				<c:if test="${category!=1}"><span class="inactive">공지사항</span></c:if>
			</a>
		</div><!-- 사이드바 영역 끝 -->
		<div class="col-sm-10"><!-- 본문 리스트 영역 -->
			<div class="row mainfont-m-16">
				<div class="col-1 text-center align-self-center">
					<span class="mainfont-b-20">제목</span>
				</div>
				<div class="col-8">
					<span class="mainfont-b-20">${boardRead_vo.title}</span>
				</div>
				<div class="col-2 text-right align-self-center">
					조회수&nbsp;${boardRead_vo.viewCnt}
					추천수&nbsp;${boardRead_vo.recommendCnt}
				</div>
				<div class="col-12"><hr/></div>
				<div class="col-12 mt-3">
					 ${boardRead_vo.content}
				</div>
				<div class="col-12 text-center">
					<button type="button" class="btn border">추천하기</button>
					<button type="button" class="btn border">신고하기</button>
				</div>
				<div class="col-12"><hr/></div>
				<div class="col-2">
				<img alt="" src="${ctp}/resources/data/memberprofile/${boardRead_vo.photo}" class="profile_img"> 
				</div>
				<div class="col-4">
				작성자 ${boardRead_vo.nickName}(${boardRead_vo.mid})<br>
				등급 ${boardRead_vo.strLevel}
				</div>
				<div class="col-12"><hr/></div>
				<div class="col-12">${sNickName}(${sMid})</div>
				<div class="col-10 mr-0 pr-0">
					<textarea rows="3" class="form-control"></textarea>
				</div>
				<div class="col-2 ml-0 pl-0">
					<button type="button" class="btn border form-control" style="height:100%;">댓글달기</button>				
				</div>
				<div class="col-12"><!-- 댓글 목록 영역 -->
					
				</div>
				<div class="col-12">
					<hr>
					이전글<a href="#">이전글 링크</a><br>
					다음글<a href="#">다음글 링크</a>
				</div>
			</div>
		</div><!-- 본문 리스트 영역 -->
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>