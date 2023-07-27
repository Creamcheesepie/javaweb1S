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
		
		function openTakeModal(ask_idx){
			
			$.ajax({
				type:"post",
				data:{ask_idx:ask_idx},
				url:"${ctp}/admin/getAskDetail",
				success:function(vo){
					$("#detailNickName").html(vo.nickName);
					$("#detailTitle").html(vo.title);
					$("#detailContent").html(vo.content);
					$("#detailWdate").html(vo.wdate);
					$("#ask_idxInput").val(vo.ask_idx);
					$("#takeConetntInput").val(vo.takeContent);
					
					$("#askDetailModal").modal();
				},
				error:function(){
					alert("오류가 발생하였습니다. 같은 현상이 반복되면 관리자에게 연락해 주세요.");
				}
			})
		}
		
		function askTakeSave(){
			let ask_idx = $("#ask_idxInput").val();
			let takeContent = $("#takeConetntInput").val();
						
			$.ajax({
				type:"post",
				data:{ask_idx:ask_idx,takeContent:takeContent},
				url:"${ctp}/admin/askTakeSet",
				success:function(){
					alert("답변을 성공적으로 입력하였습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류가 발생하였습니다 같은 현상이 반복되면 관리자에게 연락해주십시오.")					
				}
			})
		}
	</script>
	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>
	<div class="">
		<span class="mainTitle">문의 관리</span>
	</div>
	<hr>
	<form action="${ctp}/admin/adminAskForm" method="post">
	<div class="row">
		<div class="col-1 align-self-center">
		세부조회
		</div>	
		<div class="col-1 align-self-center">
		</div>
		<div class="col-1 align-self-center">
		조회일자
		</div>
		<div class="col-4 align-self-center">
			<input type="date" name="afterDate" id="afterDate">
			~
			<input type="date" name="beforeDate" id="beforeDate">
		</div>
		<div class="col-1 align-self-center">
			문의분류
		</div>
		<div class="col-3 align-self-center">
			<select  name="ask_category" id="ask_category">
				<option value="">전체조회</option>
				<c:forEach var="askcVO" items="${askcVOS}" varStatus="st">
					<option value="${askcVO.ask_category}">${askcVO.category_name}</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-1  align-self-center">
			<button type="submit" class="btn border">조회</button>
		</div>
	</div>
	</form>
	<div class="row text-center">
		<div class="col-12"><hr></div>
		<div class="col-2">분류</div>
		<div class="col-5">제목</div>
		<div class="col-2">문의자</div>
		<div class="col-2">문의날짜</div>
		<div class="col-1">처리여부</div>
		<div class="col-12"><hr></div>
		<c:forEach var="askVO" items="${askVOS}" varStatus="st">
			<div class="col-2">${askVO.category_name}</div>
			<div class="col-5">${askVO.title}</div>
			<div class="col-2">${askVO.nickName}</div>
			<div class="col-2">${fn:substring(askVO.wdate,0,10)}</div>
			<div class="col-1">
				<c:if test="${askVO.takeSw == 0}">
					<button type="button" class="btn border" onclick="openTakeModal(${askVO.ask_idx})">답변</button>
				</c:if>
				<c:if test="${askVO.takeSw == 2}">
					<button type="button" class="btn border" onclick="openTakeModal(${askVO.ask_idx})">완료</button>
				</c:if>
			</div>
			<div class="col-12"><hr></div>
		</c:forEach>
	</div>
</div>
<!-- The Modal -->
<div class="modal" id="askDetailModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">문의 상세</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
      	<div>문의 정보</div>
        <div> 
        	문의자 : <span name="detailNickName" id="detailNickName"></span>
        </div>
        <div>
        	제목 : <span name="datailTitle" id="detailTitle"></span>
        </div>
        <div>
        	문의내용<br>
        	<textarea rows="6" class="form-control" name="detailContent" id="detailContent"></textarea>
        </div>
        <div>
        	문의시간 : <span name="detailWdate" id="detailWdate"></span>
        </div>
        <div><hr></div>
        <div>
       		답변 내용
       		<textarea rows="3" class="form-control" name="takeConetntInput" id="takeConetntInput"></textarea>
       		<input type="hidden" name="ask_idxInput" id="ask_idxInput">
       	</div>
        <div class="text-center mt-3">
        	<button type="button" class="btn border" onclick="askTakeSave()">저장</button>
        </div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>