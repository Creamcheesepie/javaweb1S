<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<style>
		.loginTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size: 30px;
	}
	.loginSubTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:600;
		font-size: 22px;	
	}
	.btn-text{
				font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:600;
		font-size: 18px;	
	}
	.mini-Link{
		font-size:12px;
	}
	.bigTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:42px;	
	}
	</style>
	<script>
		'use strict';
		
		function pwdFind(){
			let emailName = $("#emailName").val();
			let dom_idx = $("#dom_idx").val();
			let mid = $("#mid").val();
			
			if(mid.trim()==""){
				alert("아이디를 입력해주세요!");
				return false;
			}
			
			if(emailName.trim()==""){
				alert("이메일을 입력해주세요!");
				return false;
			}
			
			$.ajax({
				type:"post",
				data:{emailName:emailName,dom_idx:dom_idx,mid:mid},
				url:"${ctp}/member/pwdFindOutput",
				success:function(res){
					if(res==0){
						alert("해당 아이디와 이메일로 가입된 계정이 없습니다.\n다시 확인해주세요.");
						return false;
					}
					else if(res == 1 ){
						alert("임시 비밀번호를 발송하였습니다.\n임시 비밀번호를 통해 로그인해 주세요.\n이후 마이페이지에서 비밀번호를 변경해주세요.");
					}
				},
				error:function(res){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 운영자 또는 관리자에게 연락해주세요.");
				}
			})
		}
	</script>
</head>
	<div class="bigTitle text-center" style="margin-top:11%;"><a href="${ctp}/">함께타요</a></div>
	<div class="container" style="border-radius:22px; border:1px; border-style:solid; border-color:lightgray;margin-top:2%; width:400px;padding:11px;" >
		<form name="loginform" method="post">
		<div class="row">
			<div class="col-12">
				<span class="loginTitle">비밀번호 찾기</span>
				<span class="fontdot-12"><br>회원님의 이메일로 임시 비밀번호를 보내드립니다.</span>
				<hr style="margin: 7px 0px 7px 0px"/>
			</div>
			<div class="col-7"><span class="loginSubTitle">아이디</span></div><div class="col-5"><span></span></div>
			<div class="col-12">
				<input type="text" name="mid" id="mid" class="form-control">
			</div>
			<div class="col-7"><span class="loginSubTitle">이메일 입력</span></div><div class="col-5"><span></span></div>
			<div class="col-12">
				<div class="input-group">
				<input type="text" name="emailName" id="emailName" class="form-control">
				<div class="input-group-append">
				<span class="input-group-text">@</span>
				<select name="dom_idx" id="dom_idx" class="form-control">
					<c:forEach var="vo" items="${domain_vos}" varStatus="st">
					<option value="${vo.dom_idx}">${fn:substring(vo.domain,1,fn:length(vo.domain))}</option>
					</c:forEach>
				</select>
				</div>
			</div>
			</div>
		</div>
		<input type="hidden" name="from" value="${from}">
		</form>
		<div class="row mt-3">
			<div class="col-12 text-center ">
				<button type="button" onclick="pwdFind()" class="btn"><span class="btn-text">비밀번호 찾기</span></button>
			</div>
			<div class="col-12 text-center mt-2">
				<a href="${ctp}/member/findForm/mid"><span class="mini-Link">아이디 찾기</span></a>
			</div>
		</div>
	</div>
<body>
</body>
</html>