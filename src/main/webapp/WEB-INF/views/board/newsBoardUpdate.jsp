<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
		"use strict";
		document.title = '${category_Name} 글 쓰기';
		
		function newsUpdate(){
			let title = newsUpateForm.title.value;
			let content = newsUpateForm.content.value;
			
			if(title.trim==""){
				alert("${category_Name} 제목을 입력해주세요");
				$("#title").focus();
				return false;
			}
			
			if(content.trim==""){
				alert("${category_Name} 내용을 입력해주세요");
				$("#content").focus();
				return false;
			}
			
			newsUpateForm.submit();
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
	<div class="mainTitle" style="margin-top: 3%">News</div>
	<div class="row">
		<div class="col-12">
			<div class="mainTitle">${category_Name}</div>
		</div>
	</div>
	<div class="row">
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
		<div class="col-sm-8"><!-- 게시글 작성 영역 -->
			<form name="newsUpateForm" method="post" action="${ctp}/board/newsUpateSet/${updateForm_vo.boa_idx}/${category}">
			<div class="row">
				<div class="col-2 text-center align-self-center">
				 <span class="mainfont-b-20">글 제목</span>
				</div>
				<div class="col-10">
					<input type="text" name="title" id="title" placeholder="${category_Name} 제목을 입력해 주세요" value="${updateForm_vo.title}" class="mainfont-m-16 form-control">
				</div>
				<div class="col-12 mt-3">
					<textarea rows="6" name="content" id="CKEDITOR" class="form control">"${updateForm_vo.content}"</textarea>
					<script>
						CKEDITOR.replace("content",{
							height:330,
							filebrowserUploadUrl:"${ctp}/tempImage",
							uploadUrl:"${ctp}/tempImage"
						})			
					</script>
				</div>
			</div>
			<div class="col-12 text-center mt-3">
				<button type="button" onclick="newsUpdate()" class="btn border">수정하기</button>
				<button type="button" onclick="" class="btn border">돌아가기</button>
			</div>
			</form>
		</div><!-- 게시글 작성 영역 영역 -->
		<div class="col-sm-2"></div><!-- 오른쪽 사이드바 영역 -->
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>