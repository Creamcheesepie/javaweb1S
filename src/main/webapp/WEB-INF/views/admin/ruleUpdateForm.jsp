<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	
	function pointChange(part,count){
		let point = $("#point"+count).val();
		let c_reason = $("#point_c_reason"+count).val();
		
		$.ajax({
			type:'post',
			data:{part:part,point:point,c_reason:c_reason},
			url:"${ctp}/admin/pointChangeOk",
			success:function(res){
				if(res==1){
					alert("성공적으로 포인트가 수정되었습니다.");
				}
				else{
					alert("오류가 발생하여 포인트가 수정되지 않았습니다. 같은 현상이 반복되면 관리자에게 연락해주세요.")
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자에게 연락해주세요.");
			}
		})
		
	}
	
	function categoryInputCheck(){
		let ans = confirm("정말로 추가하시겠습니까? 많은 게시판의 난립은 사용자에게 혼란을 줄 수 있으니 신중하게 추가하여 주십시오.");
		if(!ans)return false;
		
		let categoryName = $("#categoryNameInput").val();
		
		$.ajax({
			type:"post",
			url:"${ctp}/admin/categoryInput",
			data:{categoryName:categoryName},
			success:function(res){
				if(res==1){
					alert("카테고리 추가에 성공하였습니다.");
					location.reload
				}
				else{
					alert("오류가 발생하여 카테고리 추가에 실패하였습니다.");
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복된다면 관리자에게 연락해주십시오.")
			}
		})
		
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<div class="mainTitle">사이트 관리<hr></div>
<div class="subTitle">포인트 관리</div>
<div class="mainfont-b-16">사이트 활동시 부여되는 포인트를 관리합니다.<hr></div>
<div class="row">
	<c:forEach var="point_vo" items="${point_vos}" varStatus="st">
		<div class="col-2">
		<span class="mainfont-b-16">${point_vo.name}</span><br>
		<span class="mainfont-m-14"  >변경사유</span>
		<textarea rows="3" class="form-control" name="point_c_reason${st.count}" id="point_c_reason${st.count}" placeholder="변경하는 이유를 적어주세요.">${point_vo.c_reason}</textarea>
		<c:if test="${!empty point_vo.cdate}">
		<span class="mainfont-m-14">최종 변경일자<br>${fn:substring(point_vo.cdate,0,10)}</span>
		</c:if>
		<div class="input-group">
			<input name="point${st.count}" id="point${st.count}" type="number" value="${point_vo.point}" class="form-control">
			<div class="input-group-append">
				<button type="button" onclick="pointChange('${point_vo.part}','${st.count}')" class="btn border">변경하기</button>
			</div>
		</div>
	</div>
	</c:forEach>
</div>
<hr>
<div class="subTitle">게시판 카테고리 관리</div>
<div class="mainfont-b-16">현재 커뮤니티에 존재하는 게시판 카테고리를 관리합니다. 카테고리는 최대 100개까지 추가가 가능합니다. 사용자를 고려해 신중히 게시판 카테고리를 수정/추가해 주십시오.<hr></div>
<div class="row">
	<div class="col-12 mainfont-b-16">카테고리 추가</div>
	<div class="col-4 mb-2">
		<div class="input-group">
			<input type="text" name="categoryNameInput" id="categoryNameInput" class="form-control">
			<div class="input-group-append">
				<button type="button" class="btn border" onclick="categoryInputCheck()">추가하기</button> 
			</div>
		</div>
	</div>
	<div class="col-12 p0 m0"></div>
	<c:forEach var="category_vo" items="${category_vos}" varStatus="st">
	<div class="col-2">
		<div class="input-group">
			<input type="text" name="categoryNameUpdate${st.count}" id="categoryNameUpdate${st.count}" value="${category_vo.name}" class="form-control">
			<div class="input-group-append">
				<button type="button" class="btn border">변경하기</button> 
			</div>
		</div>
	</div>
	</c:forEach>
</div>

</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>