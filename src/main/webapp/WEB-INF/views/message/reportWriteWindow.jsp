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
<script>
	'use strict';
	
	function reportIdxSearch(){
		let searchStr = $("#searchStr").val();
		let searchOption = $("#searchOption").val();
		
		$.ajax({
			type:"post",
			data:{searchStr:searchStr,searchOption:searchOption},
			url:"${ctp}/message/reportSearch/message",
			success:function(vos){
				
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복된다면 관리자 또는 운영자에게 연락해 주세요.");
			}
		})
		
		
	}
	
	
</script>
<body>
<span class="mainTitle">신고하기</span>
<div class="row" style="padding: 5px 15px 0px 15px">
	<div class="col-12">신고할 대상을 검색해 주세요.</div>
	<div class="col-3">
	<select class="form-control" name="searchOption" id="searchOption">
		<option value="nickName">닉네임</option>
		<option value="title">게시글</option>
		<option value="content">댓글</option>
	</select>
	</div>
	<div class="col-6">
	<input type="text" name="searchStr" id="searchStr" class="form-control">
	</div>
	<div class="col-3">
	<button type="button" class="btn border form-control" onclick="reportIdxSearch()">검색하기</button>
	</div>
	<div class="col-12" name="searchResult" id="searchResult" style="display: none;">
		<span>신고하실 대상을 선택해 주세요</span><br>
		<span name="resultOutput" id="resultOutput"></span>
	</div>
	<div class="col-2 text-center"><span class="mainfont-b-18">대상</span></div>
	<div class="col-10">
		<span></span>
	</div>
	<div class="col-2 text-center align-self-center"><span class="mainfont-b-18">제목</span></div>
	<div class="col-10">
		<input type="text" name="title" id="title" class="form-control">
	</div>
	<div class="col-12"><hr/></div>
	<div class="col-12 mb-2">
	<span class="mainfont-b-16">내용</span>
	</div>
	<div class="col-12">
		<textarea rows="6" class="form-control" name="content" id="content"></textarea>
	</div>
	<div class="col-12"><hr/></div>
	<div class="col-12 text-center">
		<input type="hidden" name="m_idx" id="m_idx" value="${sM_idx}">
		<button class="btn border">다시쓰기</button>
		<button type="button" class="btn border" >신고하기</button>
	</div>
</div>


</body>
</html>