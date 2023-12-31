<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
		function logIn(){
			let mid = loginform.mid.value;
			let pwd = loginform.pwd.value;
			
			if(mid.trim()==""){
				alert("아이디를 입력해주세요.");
				$("#mid").focus();
				return false;
			}
			
			if(pwd.trim()==""){
				alert("비밀번호를 입력해 주세요.");
				$("#pwd").focus();
				return false;
			}
			loginform.submit();
		}
	</script>
</head>
	<div class="bigTitle text-center" style="margin-top:11%;"><a href="${ctp}/">함께타요</a></div>
	<div class="container" style="border-radius:22px; border:1px; border-style:solid; border-color:lightgray;margin-top:2%; width:400px;padding:11px;" >
		<form name="loginform" method="post">
		<div class="row">
			<div class="col-12">
				<span class="loginTitle">아이디</span>
				<c:if test="${!empty loginFail}"><br><span class="fontdot-12 red" style="color: red;">${loginFail}</span></c:if>
				<hr style="margin: 7px 0px 7px 0px"/>
			</div>
			<div class="col-7"><span class="loginSubTitle">아이디</span></div><div class="col-5"><span></span></div>
			<div class="col-12">
				<input type="text" name="mid" class="form-control">
			</div>
			<div class="col-12 mt-2">
				<span class="loginSubTitle">비밀번호</span>
				<input type="password" name="pwd" class="form-control">
			</div>
		</div>
		<input type="hidden" name="from" value="${from}">
		</form>
		<div class="row mt-3">
			<div class="col-12 text-center ">
				<button type="button" onclick="logIn()" class="btn"><span class="btn-text">로그인</span></button>
				<button type="button" onclick="location.href='${ctp}/member/signIn'" class="btn	"><span class="btn-text">회원가입</span></button>
			</div>
			<div class="col-12 text-center mt-2">
				<span class="mini-Link">
				<a href="${ctp}/member/findForm/mid">아이디</a>/<a href="${ctp}/member/findForm/pwd">비밀번호 찾기</a>
				</span>
			</div>
		</div>
	</div>
<body>
</body>
</html>