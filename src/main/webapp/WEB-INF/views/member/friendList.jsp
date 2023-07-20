<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구목록</title>
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
<div class="mainfont-b-28"><span class="material-symbols-outlined">group</span>친구목록</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<div class="mainfont-b-16">
	<jsp:include page="/WEB-INF/views/include/friendBanSideBar.jsp"/>
		<hr/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">친구목록</span><span class="mainfont-b-16 inactive"></span>
		<hr>
		<div class="row text-center">
			<div class="col-2 align-self-center">닉네임</div>
			<div class="col-2 align-self-center">이름</div>
			<div class="col-1 align-self-center">나이</div>
			<div class="col-1 align-self-center">성별</div>
			<div class="col-1 align-self-center">등급</div>
			<div class="col-2 m-0 p-0 align-self-center">시간/속도/고도</div>
			<div class="col-1 m-0 p-0 align-self-center">생일</div>
			<div class="col-2 ml-0 pl-0 align-self-center">비고</div>
			<div class="col-12"><hr></div>	
		</div>
		<div class="row mainfont-m-14 text-center">
			<c:forEach var="fb_vo" items="${friendVOS}" varStatus="st">
			<div class="col-2 align-self-center">${fb_vo.nickName}</div>
			<div class="col-2 align-self-center">${fb_vo.name}</div>
			<div class="col-1 align-self-center">${fb_vo.age}</div>
			<div class="col-1 align-self-center">${fb_vo.gender}</div>
			<div class="col-1 align-self-center">${fb_vo.level}</div>
			<div class="col-2 m-0 p-0 align-self-center">${fb_vo.duration}h/${fb_vo.speed}km/${fb_vo.getHeight}m</div>
			<div class="col-1 m-0 p-0 align-self-center">${fn:substring(fb_vo.birthday,5,10)}</div>
			<div class="col-2 ml-0 pl-0 align-self-center"><button type="button" class="btn border">취소</button></div>
			<div class="col-12"><hr></div>	
			</c:forEach>
			<c:if test="${empty friendVOS}">
				<div class="col-12">
					<span class="inactive">아직 친구로 추가한 유저가 없습니다.</span>
				</div>
			</c:if>
		</div>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>