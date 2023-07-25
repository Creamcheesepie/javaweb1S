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
	<script>
	'use strict';
	
	function clearCheck(get_idx,m_idx){
		
		$.ajax({
			type:"post",
			data:{get_idx:get_idx,m_idx:m_idx},
			url:"${ctp}/gether/getherClearCheck",
			success:function(){
				alert("대상 회원의 모임 기록을 확인하였습니다")
				location.reload;
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자 또는 운영자에게 연락해주세요.");
			}
		})
		
	}
	</script>
</head>
<body>
<div class="mainTitle">모임결과 확인창입니다.</div>
<div class="subTitle">
회원들이 입력한 모임결과를 확인해주세요. 모임장의 확인이 있어야 후기 작성이 가능합니다.<br>
전체확인은 이 페이지 최하단에 있습니다.
</div>
<div>
<div class="row">
	<div class="col-12"><hr></div>
	<c:forEach var="clearVO" items="${getherMemberVOS}" varStatus="st">
		<div class="col-12">${clearVO.nickName}</div>
		<div class="col-8">속도 : ${clearVO.speed}km/h | 거리 : ${clearVO.distance}km | 획득고도 : ${clearVO.getHeight}</div>
		<div class="col-4">
		<c:if test="${clearVO.clear>0 && clearVO.clear<3}">
			<button type="button" class="btn border" onclick="clearCheck('${clearVO.get_idx}','${clearVO.m_idx}')">확인</button>
		</c:if>
		<c:if test="${clearVO.clear==0}">
			결과 미저장
		</c:if>
		</div>
		<div class="col-12"><hr></div>
	</c:forEach>
	<div class="col-12 text-center">
		<button type="button" onclick="totalCheck()">전체확인</button>
	</div>
</div>
</div>
</body>
</html>