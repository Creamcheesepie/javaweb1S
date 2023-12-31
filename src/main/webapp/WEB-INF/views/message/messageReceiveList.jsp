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
	function readReceiveMessage(msg_idx){
		$.ajax({
			type:"post",
			data:{msg_idx:msg_idx},
			url:"${ctp}/message/getReceiveMessage",
			success:function(vo){
				$("#sendButton").show();
				$("#friendOk").hide();
				$("#rsdateOutput").html(vo.sdate);
				$("#receiveTitleOutput").html(vo.title);
				$("#sendNameOutput").html(vo.nickName);
				$("#receiveCategoryNameOutput").html(vo.category_name);
				$("#receiveContentOutput").html(vo.content);
				$("#t_idx").val(vo.m_idx);
				$("#msg_idx").val(vo.msg_idx);
				if(vo.msg_category=='120' && vo.rdate == null) $("#friendOk").show();
				if(vo.msg_category=='120' || vo.rdate != null) $("#sendButton").hide();
				$("#answerOpener").attr('onclick',"window.open('${ctp}/message/openAnswer/"+msg_idx+"', '쪽지쓰기', 'width=515, height=460')" );
				$("#receiveMessageModal").modal();
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자 또는 운영자에게 문의해주세요.")
			}
		})
	}
	function FriendInviteAnswer(ans){
		let t_idx = $("#t_idx").val();
		let msg_idx = $("#msg_idx").val();
		
		$.ajax({
			type:"post",
			data:{ans:ans,t_idx:t_idx,msg_idx:msg_idx},
			url:"${ctp}/message/friendInviteAnswer",
			success:function(res){
				if(res=="1"){
					alert("친구 신청을 승낙하였습니다.");
					return false;
				}
				else if(res=='2'){
					alert("친구 신청을 거절하였습니다.");
				}
			},
			error:function(){
				alert("전송 오류가 발생하였습니다. 같은 현상이 반복되면 관리자 또는 운영자에게 연락해 주십시오.");
			}
		})
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container myPage-container">
<div class="mainfont-b-28"><span class="material-symbols-outlined">markunread_mailbox</span>받은 쪽지함</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<button type="button" class="btn mainfont-b-22" onclick="window.open('${ctp}/message/openWrite', '쪽지쓰기', 'width=515, height=460')">쪽지쓰기</button>
	<hr>
	<div class="mainfont-b-16">
		<jsp:include page="/WEB-INF/views/include/messageSideBar.jsp"/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">받은쪽지</span><span class="mainfont-b-16 inactive"></span>
		<hr>
		<div class="row">
			<div class="col-1 text-center">분류</div>
			<div class="col-5">제목</div>
			<div class="col-4 text-center">송신인</div>
			<div class="col-2 text-center">전송날짜</div>
			<div class="col-12"><hr></div>
			<c:forEach var="msg_vo" items="${message_vos}" varStatus="st">
				<div class="col-1 text-center">${msg_vo.category_name}</div>	
				<div class="col-5">
					<c:if test="${msg_vo.readSw!='1'}">
						<span class="material-symbols-outlined">mark_email_unread</span>
					</c:if>
					<c:if test="${msg_vo.readSw=='1'}">
						<span class="material-symbols-outlined">mark_email_read</span>
					</c:if>
				<a href="javascript:readReceiveMessage('${msg_vo.msg_idx}')">${msg_vo.title}</a>
				</div>
				<div class="col-4 text-center">${msg_vo.nickName}</div>
				<div class="col-2 text-center">${fn:substring(msg_vo.sdate,0,10)}</div>
				<div class="col-12"><hr></div>	
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
				<div class="col-12 text-center" name="friendOk" id="friendOk" style="display: none;">
					<button type="button" class="btn border" onclick="FriendInviteAnswer('1')">수락</button>
					<button type="button" class="btn border" onclick="FriendInviteAnswer('0')">거절</button>
					<input type="hidden" name="t_idx" id="t_idx">
					<input type="hidden" name="msg_idx" id="msg_idx">
				</div>
				<div class="col-12 text-right aling-self-end">
					<span class="fontdot-12">보낸시간 : </span><span name="rsdateOutput" id="rsdateOutput" class="fontdot-12"></span>
				</div>
			</div>      	
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <span name="sendButton" id="sendButton">
        	<button type="button" id="answerOpener" name="answerOpener" class="btn border" >답장하기</button>
        </span>
        <button type="button" class="btn border" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>	
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>