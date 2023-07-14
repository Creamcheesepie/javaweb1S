<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
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
	
	function readReceiveMessage(msg_idx){
		$.ajax({
			type:"post",
			data:{msg_idx:msg_idx},
			url:"${ctp}/message/getReceiveMessage",
			success:function(vo){
				$("#rsdateOutput").html(vo.sdate);
				$("#receiveTitleOutput").html(vo.title);
				$("#sendNameOutput").html(vo.nickName);
				$("#receiveCategoryNameOutput").html(vo.category_name);
				$("#receiveContentOutput").html(vo.content);
				$("#answerOpener").attr('onclick',"window.open('${ctp}/message/openAnswer/"+msg_idx+"', '쪽지쓰기', 'width=515, height=460')" );
				$("#receiveMessageModal").modal();
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
<div class="mainfont-b-28"><span class="material-symbols-outlined">mail</span>쪽지함</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<button type="button" class="btn mainfont-b-22" onclick="window.open('${ctp}/message/openWrite', '쪽지쓰기', 'width=515, height=460')">쪽지쓰기</button>
	<hr>
	<div class="mainfont-b-16">
	<jsp:include page="/WEB-INF/views/include/messageSideBar.jsp"/>
		<hr/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">최근쪽지</span><span class="mainfont-b-16 inactive"> 최근에 주고받은 쪽지 15개까지만 표시됩니다.</span>
		<hr>
		<div class="row">
			<c:forEach var="msg_vo" items="${message_vos}" varStatus="st">
			<c:if test="${msg_vo.m_idx == sM_idx}">
				<div class="col-1 text-center mainfont-b-18">보냄</div>
				<div class="col-5">
					<c:if test="${msg_vo.readSw!='1'}">
						<span class="material-symbols-outlined">outgoing_mail</span>
					</c:if>
					<c:if test="${msg_vo.readSw=='1'}">
						<span class="material-symbols-outlined">mark_email_read</span>
					</c:if>
				<a href="javascript:readSendMessage('${msg_vo.msg_idx}')">${msg_vo.title}</a>
				</div>
				<div class="col-4 text-center">수신자 : ${msg_vo.nickName}</div>
				<div class="col-2 text-center">${fn:substring(msg_vo.sdate,0,10)}</div>
				<div class="col-12"><hr></div>	
			</c:if>
			<c:if test="${msg_vo.receive_m_idx == sM_idx}">
				<div class="col-1 text-center mainfont-b-18">받음</div>	
				<div class="col-5">
					<c:if test="${msg_vo.readSw!='1'}">
						<span class="material-symbols-outlined">mark_email_unread</span>
					</c:if>
					<c:if test="${msg_vo.readSw=='1'}">
						<span class="material-symbols-outlined">mark_email_read</span>
					</c:if>
					<a href="javascript:readReceiveMessage('${msg_vo.msg_idx}')">${msg_vo.title}</a>
				</div>
				<div class="col-4 text-center">송신자 : ${msg_vo.nickName}</div>
				<div class="col-2 text-center">${fn:substring(msg_vo.sdate,0,10)}</div>
				<div class="col-12"><hr></div>	
			</c:if>
			</c:forEach>
			<c:if test="${empty message_vos}">
				<div class="col-12">
					<span class="inactive">받거나 보낸 쪽지가 없습니다.</span>
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
				<span name="modalTitle" id="modalTitle" class="mainTitle">보낸 쪽지</span>
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
<!-- 쪽지 받음 Modal -->
<div class="modal" id="receiveMessageModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
				<span name="modalTitle" id="modalTitle" class="mainTitle">받은 쪽지</span>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
			<div class="row">
				<div class="col-12 mb-2">
					제목 <span name="receiveTitleOutput" id="receiveTitleOutput" class="mainfont-b-20"></span>
				</div>
				<div class="col-8">
					보낸이 : <span name="sendNameOutput" id="sendNameOutput"></span>
				</div>
				<div class="col-4 mb-2 text-right">
					분류 : <span name="receiveCategoryNameOutput" id="receiveCategoryNameOutput"></span>
				</div>
				<div class="col-12">
					<span class="mainfont-b-16">내용</span>
					<textarea rows="5" readonly class="form-control" name="receiveContentOutput" id="receiveContentOutput">
					</textarea>
				</div>
				<div class="col-12 text-right aling-self-end">
					<span class="fontdot-12">보낸시간 : </span><span name="rsdateOutput" id="rsdateOutput" class="fontdot-12"></span>
				</div>
			</div>      	
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button name="answerOpener" id="answerOpener" type="button" class="btn border" onclick="">답장하기</button>
        <button type="button" class="btn border" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>	
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>