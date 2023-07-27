<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		function memberLevelChange(m_idx,cnt){
			let level = $("#level"+cnt).val();
			
			$.ajax({
				type:"post",
				data:{m_idx:m_idx,level:level},
				url:"${ctp}/admin/memberLevelChange",
				success:function(){
					alert("대상 회원의 등급을 변경하였습니다.");
					location.reload();
				},
				erroe:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자에게 연락해주세요.");
				}
			})
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>
<div class="mainTitle">회원목록<hr></div>
<div class="row text-center">
	<div class="col-12  text-left">
		
	</div>
	<div class="col-3">닉네임</div>
	<div class="col-2">이름</div>
	<div class="col-1">포인트</div>
	<div class="col-1">접속횟수</div>
	<div class="col-1">게시글수</div>
	<div class="col-1">댓글수</div>
	<div class="col-1">도배수</div>
	<div class="col-1">등급</div>
	<div class="col-1">비고</div>
	<div class="col-12"><hr></div>
	<c:forEach var="mVO" items="${mVOS}" varStatus="st">
		<div class="col-3">${mVO.nickName}</div>
		<div class="col-2">${mVO.name}</div>
		<div class="col-1">${mVO.point}</div>
		<div class="col-1">${mVO.totalCnt}</div>
		<div class="col-1">${mVO.boaCnt}</div>
		<div class="col-1">${mVO.repCnt}</div>
		<div class="col-1">${mVO.offCnt}</div>
		<div class="col-1">
		<c:if test="${mVO.level != 0}">
		<select name="level${st.count}" id="level${st.count}">
			<option value="1" <c:if test="${mVO.level == 1}">selected</c:if>>운영자</option>
			<option value="2" <c:if test="${mVO.level == 2}">selected</c:if>>모임장</option>
			<option value="3" <c:if test="${mVO.level == 3}">selected</c:if>>정회원</option>
			<option value="4" <c:if test="${mVO.level == 4}">selected</c:if>>준회원</option>
			<option value="5" <c:if test="${mVO.level == 5}">selected</c:if>>임시정지</option>
			<option value="6" <c:if test="${mVO.level == 6}">selected</c:if>>영구정지</option>
		</select>
		</c:if>
		<c:if test="${mVO.level == 0}">관리자</c:if>
		</div>
		<div class="col-1"><a href="javascript:memberLevelChange('${mVO.m_idx}','${st.count}')">변경</a></div>
		<div class="col-12"><hr></div>
	</c:forEach>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>