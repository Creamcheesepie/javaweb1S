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

</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>