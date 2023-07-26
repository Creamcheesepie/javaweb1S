<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
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
	
	function pwdCheckModalOn(m_idx){
		$("#pwdCheckModal").modal();		
	}
	
	function pwdCheck(m_idx){
		let pwd = $("#pwd").val();
		$.ajax({
			type:"post",
			url:"${ctp}/member/pwdCheck",
			data:{pwd:pwd,m_idx:m_idx},
			success:function(res){
				if(res=='1'){
					alert("비밀번호가 동일합니다. 정보 수정창으로 이동합니다");
					location.href="${ctp}/member/infoCorrectForm";
				}
				else{
					alert("입력하신 비밀번호가 다릅니다. 다시 한 번 확인해 주세요.")
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자 또는 운영자에게 문의해주세요.");
			}
		})
		
	}
	
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
				if(vo.msg_category=='120') $("#friendOk").show();
				if(vo.msg_category=='120') $("#sendButton").hide();
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
	<span class="mainTitle">마이페이지</span>
	<hr>
	<div class="row">
		<div class="col-sm-2 mainfont-b-16" style="height: 160px">프로필 사진
			<hr>
			<c:if test="${mvo.photo!=null}">
				<img src="${ctp}/resources/data/memberprofile/${mvo.photo}" style="height: 100px ;width:127px">
			</c:if>
			<c:if test="${mvo.photo==null}">
				<img src="${ctp}/resources/data/memberprofile/noimage.jpg" style="height: 100px ;width:127px">
			</c:if>
		</div>
		<div class="col-sm-3 mainfont-b-20">
			내 정보 <button type="button" onclick="pwdCheckModalOn(${mvo.m_idx})"  class="btn"><span class="fontdot-12">change</span></button><br/>
			닉네임 : ${mvo.nickName}<br/>
			아이디 : ${mvo.mid}<br/>
			이름 : ${mvo.name}<br/>
			나이 : ${mvo.age}<br/>
		</div>
		<div class="col-sm-6 mainfont-b-20">
			&nbsp;<br/>
			등급 : ${sStrLevel}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;포인트 : ${mvo.point}<br/>
			성별 : ${mvo.gender}<br/>
			이메일 : ${mvo.emailName}${domain}<br/>
			전화번호 : ${mvo.tel}<br/>
		</div>
		<div class="col-sm-12">
		<hr>
		</div>
		<div class="col-sm-6 mainfont-b-20">
			자기소개 <br/>
			생일 : ${fn:substring(mvo.birthday,0,10)}
			<textarea class="inst mainfont-m-16" rows="4" readonly>${mvo.inst}</textarea>
		</div>
		<div class="col-sm-6 mainfont-b-20">
			라이딩 정보<br/>
			<hr>
			평균속도 : ${mvo.speed}km/h<br/>
			주행시간 : ${mvo.duration}h<br/>
			획득고도 : ${mvo.getHeight}m<br/>
			모임참가 : 회(완주 회)<br/>
		</div>
		<div class="col-sm-12"><hr/></div>
		<div class="col-sm-6 list">
			<span class="mainfont-b-20">최근 내 작성글</span>
			<hr/>
			<div class="row">
				<c:forEach var="boardVO" items="${boardVOS}">
					<div class="col-12 mb-1">
						<a href="${ctp}/board/read/${boardVO.boa_idx}/${boardVO.category}">${boardVO.title}</a>
					</div>
				</c:forEach>
			</div>
		</div>
		<div class="col-sm-6 list">
			<span class="mainfont-b-20">최근 내 댓글</span>
			<hr/>
			<div class="row">
				<c:forEach var="replyVO" items="${replyVOS}">
				<div class="col-12 mb-1">
				${replyVO.content}
				</div>
				</c:forEach>
			</div>
		</div>
		<div class="col-sm-4 list mt-2">
			<div class="row">
				<div class="col-7">
					<span class="mainfont-b-20">최근쪽지</span>
				</div>
				<div class="col-5 text-right align-self-end">
					<span class="material-symbols-outlined">mail</span>
					<a href="${ctp}/message/home">쪽지함</a>
				</div>
			</div>
			<hr/>
			<div class="row">
			<c:forEach var="msg_vo" items="${messageVOS}" varStatus="st">
			<c:if test="${msg_vo.m_idx == sM_idx}">
				<div class="col-1 text-center mainfont-b-18">out</div>
				<div class="col-6 fontdot-12">
					<c:if test="${msg_vo.readSw!='1'}">
						<span class="material-symbols-outlined">outgoing_mail</span>
					</c:if>
					<c:if test="${msg_vo.readSw=='1'}">
						<span class="material-symbols-outlined">mark_email_read</span>
					</c:if>
				<a href="javascript:readSendMessage('${msg_vo.msg_idx}')">
				<c:if test="${fn:length(msg_vo.title) > 8}">
					${fn:substring(msg_vo.title,0,8)}...
				</c:if>
				<c:if test="${fn:length(msg_vo.title) < 9}">
					${msg_vo.title}
				</c:if>
				</a>
				</div>
				<div class="col-4 text-center fontdot-12">${msg_vo.nickName}</div>
				<div class="col-12 mb-1"></div>
			</c:if>
			<c:if test="${msg_vo.receive_m_idx == sM_idx}">
				<div class="col-1 text-center mainfont-b-18">in</div>	
				<div class="col-6 fontdot-12">
					<c:if test="${msg_vo.readSw!='1'}">
						<span class="material-symbols-outlined">mark_email_unread</span>
					</c:if>
					<c:if test="${msg_vo.readSw=='1'}">
						<span class="material-symbols-outlined">mark_email_read</span>
					</c:if>
					<a href="javascript:readReceiveMessage('${msg_vo.msg_idx}')">
					<c:if test="${fn:length(msg_vo.title) > 8}">
						${fn:substring(msg_vo.title,0,8)}...
					</c:if>
					<c:if test="${fn:length(msg_vo.title) < 9}">
						${msg_vo.title}
					</c:if>
					</a>
				</div>
				<div class="col-4 text-center fontdot-12">${msg_vo.nickName}</div>
				<div class="col-12 mb-1"></div>
			</c:if>
			</c:forEach>
			<c:if test="${empty messageVOS}">
				<div class="col-12">
					<span class="inactive">받거나 보낸 쪽지가 없습니다.</span>
				</div>
			</c:if>
		</div>
		</div>
		<div class="col-sm-4 list mt-2">
			<span class="mainfont-b-20"><a href="${ctp}/member/friendList">친구목록</a></span>
			<hr/>
			<div class="row">
			<c:forEach var="fb_vo" items="${friendVOS}" varStatus="st">
				<div class="col-12 align-self-center">${fb_vo.nickName}</div>
				<div class="col-12"><hr></div>	
			</c:forEach>
			</div>
		</div>
		<div class="col-sm-4 list mt-2">
			<span class="mainfont-b-20"><a href="${ctp}/member/banList">차단목록</a></span>
			<hr/>
			<div class="row">
			<c:forEach var="fb_vo" items="${banVOS}" varStatus="st">
				<div class="col-12 align-self-center">${fb_vo.nickName}</div>
				<div class="col-12"><hr></div>	
			</c:forEach>
			</div>
		</div>
	</div>
</div>
<!-- The Modal -->
 <div class="modal fade" id="pwdCheckModal">
   <div class="modal-dialog">
     <div class="modal-content">
     
       <!-- Modal Header -->
       <div class="modal-header">
         <h4 class="modal-title mainfont-b-22">개인정보 수정하기</h4>
         <button type="button" class="close" data-dismiss="modal">×</button>
       </div>
       
       <!-- Modal body -->
       <div class="modal-body">
        <span class="mainfont-b-20">
        	개인정보를 수정하기 전에 비밀번호를 확인합니다
        </span>
        <div class="input-group">
				<input type="password" name="pwd" id="pwd" class="form-control">
				<div class="input-group-append">
				<button type="button" class="btn border mainfont-m-14" onclick="pwdCheck(${mvo.m_idx})">비밀번호 확인</button>
				</div>
				</div>
       </div>
       <!-- Modal footer -->
       <div class="modal-footer">
         <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
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