<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 상세</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		
		function joinGether(get_idx){
			let joinSw = 0;
			//인원수 체크
			
			
			$.ajax({
				type:"post",
				data:{get_idx:get_idx,joinSw:joinSw},
				url:"${ctp}/gether/joinGether",
				success:function(res){
					if(res=='1'){
						alert("정상적으로 참여하였습니다.");
						location.reload();
					}
					else if(res=='2'){
						let ans = confirm("차단한 회원이 이 모임에 있습니다. 그래도 참여하시겠습니까?");
						if(!ans) return false;
						else superJoin(get_idx);
					}
					else if(res=='0'){
						alert("인원이 전부 찼거나 다른 사유로 인해 등록하지 못하였습니다. 다시 한번 확인해 주세요.");
						location.reload();
					}
				},
				erorr:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자 또는 운영자에게 문의해주세요.");					
				}
			})
		}
		
		function superJoin(get_idx){
			let joinSw = 1;
			
			$.ajax({
				type:"post",
				data:{get_idx:get_idx,joinSw:joinSw},
				url:"${ctp}/gether/joinGether",
				success:function(res){
					if(res=='1'){
						alert("정상적으로 참여하였습니다.");
						location.reload();
					}
					else if(res=='0'){
						alert("인원이 전부 찼거나 다른 사유로 인해 등록하지 못하였습니다. 다시 한번 확인해 주세요.");
						location.reload();
					}
				},
				erorr:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자 또는 운영자에게 문의해주세요.");					
				}
			})		
		}
		
		function joinCancleGether(get_idx){
			$.ajax({
				type:"post",
				data:{get_idx:get_idx},
				url:"${ctp}/gether/cancleGether",
				success:function(){
					alert("모임참가를 취소하였습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자 또는 운영자에게 연락해주세요.");
				}
			})
			
		}
		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">Gether Detail</div>
<div class="subTitle mb-3">모임상세</div>
	<div class="row">
		<div class="col-10">
			<span class="mainTitle">${getherVO.title}</span>
		</div>
		<div class="col-2 text-right align-self-end">
			<div class="mainfont-b-22">
			${getherVO.nowMember}/${getherVO.totalMember}
			<a href="${ctp}/gether/afterList">
				<span class="material-symbols-outlined">menu</span>
			</a>
			</div>
		</div>
		<div class="col-12"><hr></div>
		<div class="col-2">지역 : ${getherVO.location}</div>
		<div class="col-7">상세경로 : ${getherVO.detailCourse}</div>
		<div class="col-3 text-right"> 모임시간 : ${fn:substring(getherVO.getherTime,0,16)}</div>
		<div class="col-12"><hr></div>
		<div class="col-12 text-center">주행정보 : ${getherVO.distance}Km / ${getherVO.getHeight}m / ${getherVO.useTime}h</div>
		<div class="col-12"><hr></div>
		<div class="col-12">
			${getherVO.content}
		</div>
		<div class="col-12 text-center">
			<c:if test="${joinChecker == 0 && getherVO.m_idx!=sM_idx}">
				<button type="button" class="btn border" onclick="joinGether('${getherVO.get_idx}')">참여하기</button>
			</c:if>
			<c:if test="${joinChecker == 1 && getherVO.m_idx!=sM_idx}">
				<button type="button" class="btn border" onclick="joinCancleGether('${getherVO.get_idx}')">취소하기</button>
			</c:if>
			<c:if test="${getherVO.m_idx == sM_idx}">
				<form name="getQRForm" id="getQRForm" method="post" action="${ctp}/gether/getherSaveQR">
				<input type="hidden" name="link" id="link" value="${ctp}/gether/getherClearSaver/${getherVO.get_idx}">
					<button type="submit" class="btn border">완주등록</button>
				</form>
			</c:if>
		</div>
		<div class="col-12 text-right fontdot-12">작성일자 : ${fn:substring(getherVO.wdate,0,16)}</div>
		<div class="col-12"><hr></div>
		<div class="col-12">참여인원</div>
		<div class="col-12"></div>
			<c:forEach var="joinVO" items="${joinListVOS}">
				<div class="col-2">
				${joinVO.nickName}
				<hr>
				</div>
			</c:forEach>
			<c:if test="${empty joinListVOS}">
				<div class="col-12">
				<span class="mainfont-b-18 inactive">아직 참여한 사람이 없습니다.</span>
				</div>
			</c:if>
		<div class="col-12"></div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>