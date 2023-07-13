<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 쪽지함</title>
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
	
	function readSendMessage(msg_idx){
		$.ajax({
			type:"post",
			data:{msg_idx:msg_idx},
			url:"${ctp}/message/getSendMessage",
			success:function(vo){
				$("#sdateOutput").html(vo.sdate);
				$("#sendTitleOutput").html(vo.title);
				$("#receiveNameOutput").html(vo.nickName);
				$("#categoryNameOutput").html(vo.category_name);
				$("#sendContentOutput").html(vo.content);
				$("#sendMessageModal").modal();
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자 또는 운영자에게 문의해주세요.")
			}
		})
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container myPage-container">
<div class="mainfont-b-28"><span class="material-symbols-outlined">report</span>신고 쪽지함</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<button type="button" class="btn mainfont-b-22" onclick="window.open('${ctp}/message/openReportWrite', '신고하기', 'width=515, height=460')">신고하기</button>
	<hr>
	<div class="mainfont-b-16">
		<a href="${ctp}/message/sendList">보낸 쪽지함</a>
		<hr/>
		<a href="${ctp}/message/receiveList">받은 쪽지함</a>
		<hr/>
		<a href="${ctp}/message/reportList">신고 쪽지함</a>
		<hr/>
		<a href="${ctp}/message/askList">문의 쪽지함</a>
		<hr/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">신고항목</span><span class="mainfont-b-16 inactive"></span>
		<hr>
		<div class="row">
				<div class="col-2 text-center">분류</div>
				<div class="col-5">제목</div>
				<div class="col-2">처리여부</div>
				<div class="col-2 text-center">신고날짜</div>
				<div class="col-12"><hr></div>
			<c:forEach var="rep_vo" items="${report_vos}" varStatus="st">
				<div class="col-1 text-center">${rep_vo.category_name}</div>
				<div class="col-5"><a href="javascript:readSendMessage('${rep_vo.msg_idx}')">${msg_vo.title}</a></div>
				<div class="col-2 text-center">
				<c:if test="${empty rep_vo}">신고됨</c:if>
				<c:if test="${rep_vo == 1}">처리중</c:if>
				<c:if test="${rep_vo == 2}">처리완료</c:if>
				</div>
				<div class="col-2 text-center">${fn:substring(rep_vo.wdate,0,10)}</div>
				<div class="col-12"><hr></div>
			</c:forEach>
			<c:if test="${empty message_vos}">
				<div class="col-12">
					<span class="inactive">아직 신고하신 사항이 없습니다.</span>
				</div>
			</c:if>
		</div>
	</div>
</div>
</div>
<!-- 쪽지 보냄 Modal -->
<div class="modal" id="sendMessageModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
				<span name="modalTitle" id="modalTitle" class="mainTitle">내 신고</span>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
			<div class="row">
				<div class="col-12 mb-2">
					제목 <span name="sendTitleOutput" id="sendTitleOutput" class="mainfont-b-20"></span>
				</div>
				<div class="col-8">
					받은이 : <span name="revceiveNameOutput" id="receiveNameOutput"></span>
				</div>
				<div class="col-4 mb-2 text-right">
					분류 : <span name="categoryNameOutput" id="categoryNameOutput"></span>
				</div>
				<div class="col-12">
					<span class="mainfont-b-16">내용</span>
					<textarea rows="5" readonly class="form-control" name="sendContentOutput" id="sendContentOutput">
					</textarea>
				</div>
				<div class="col-12 text-right aling-self-end">
					<span class="fontdot-12">보낸시간 : </span><span name="sdateOutput" id="sdateOutput" class="fontdot-12"></span>
				</div>
			</div>      	
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn border" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>	
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>