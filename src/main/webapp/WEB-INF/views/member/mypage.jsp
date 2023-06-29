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
			<span class="mainfont-b-20">내 작성글</span>
			<hr/>
			아직 구현되지 않은 기능입니다.
		</div>
		<div class="col-sm-6 list">
			<span class="mainfont-b-20">내 댓글</span>
			<hr/>
			아직 구현되지 않은 기능입니다.
		</div>
		<div class="col-sm-4 list">
			<span class="mainfont-b-20">최근쪽지</span>
			<hr/>
			아직 구현되지 않은 기능입니다.
		</div>
		<div class="col-sm-4 list">
			<span class="mainfont-b-20">친구목록</span>
			<hr/>
			아직 구현되지 않은 기능입니다.
		</div>
		<div class="col-sm-4 list">
			<span class="mainfont-b-20">차단목록</span>
			<hr/>
			아직 구현되지 않은 기능입니다.
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
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>