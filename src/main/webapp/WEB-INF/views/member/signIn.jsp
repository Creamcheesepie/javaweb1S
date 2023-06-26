<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<style>
	.signInTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:600;
		font-size: 35px;
	}
	.signInSubtitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:600;
		font-size: 18px;
	}
	.button-text{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:600;
		font-size: 18px;
	}
	.titleIcon{
		font-size:38px;
		margin : 0;
		vertical-align:middle;
	}
	</style>
	<script>
	'use strict'
	let nickOk ="false";
	let midOk ="false";
	let emailOk="false";
	let timeOut = "no";
	
	function nickNameCheck(){
		let nickName = $("#nickName").val();
		
		if(nickName.trim()==""){
			alert("닉네임을 입력해 주세요");
			$("#nickName").focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"${ctp}/member/nickNameCheck",
			data:{nickName:nickName},
			success:function(res){
				if(res=='1'){
					alert("중복된 닉네임이 존재합니다. 다른 닉네임을 사용해 주세요.");
					$("#nickName").focus();
					return false;
				}
				else{
					alert("사용 가능한 닉네임입니다. 계속 진행해주세요.");
					nickOk="true";
					$("#mid").focus();
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 동일한 오류가 지속되면 운영자 혹은 관리자에게 문의해주세요.")
			}
		})
	}
	
	
	function midCheck(){
		let mid = $("#mid").val();
		
		if(mid.trim()==""){
			alert("아이디를 입력해 주세요");
			$("#mid").focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"${ctp}/member/midCheck",
			data:{mid:mid},
			success:function(res){
				if(res=='1'){
					alert("중복된 아이디가 존재합니다. 다른 아이디를 사용해 주세요.");
					$("#mid").focus();
					return false;
				}
				else{
					alert("사용 가능한 아이디입니다. 계속 진행해주세요.");
					nickOk="true";
					$("#pwd").focus();
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 동일한 오류가 지속되면 운영자 혹은 관리자에게 문의해주세요.")
			}
		})
	}
	
	function sendVerificationEmail(){
		let frontEmail = $("#email").val();
		let domain = $("#domain").val();
		
		if(frontEmail.trim()==""){
			alert("이메일을 입력해 주세요.");
			$("#email").focus();
			return false;
		}
		
		let email = frontEmail+"@"+domain;
		
		$.ajax({
			type:"post",
			url:"${ctp}/member/sendVerificationEmail",
			data:{email:email},
			success:function(res){
				if(res=='1'){
					alert("잘못된 이메일 주소입니다 다시 확인해 주세요.")
					$("#email").focus();
					return false;
				}
				else{
					$("#sendCode").hide();
					$("#inputCode").slideDown();
					$("#").show();
					$("#").show();
					
					let time =300;
					let min = '';
					let sec = '';
					
					let x = setInterval(() => {
						min = parseInt(time/60);
						sec = time%60;
						$("#timer").HTML(min+"분"+sec+"초");
						if(time<0){
							clearInterval(x);
							document.getElementById("timer").innerHTML="인증시간 만료";
							timeOut='ok';
						}
					}, 1000);
					
				}
			}
		})
	}
	

	function codeCheck(){
		
		if(timeOut='ok'){
			alert("인증 시간이 만료되었습니다. 인증번호를 다시 전송받아 입력해 주세요.")
			$("#resend").focus();
			return false;
		}
		
		let verCode = $("#verCode").val();
		
		$.ajax({
			type:"post",
			url:"${ctp}/member/verCodeCheck",
			data:{verCode:verCode},
			success:function(res){
				if(res=='1'){
					alert("인증코드가 다릅니다 다시 확인해 주세요.")
				}
				else{
					alert("이메일이 인증되었습니다.")
					emailOk="true";
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복된다면 관리자 또는 운영자에게 연락해 주세요.")
			}
		})
	}
	
	
	
	</script>
</head>
<body>
	<div class="container-sm" >
		<div class="signInTitle text-center" style="margin-top:10%"><span class="material-symbols-outlined titleIcon">person_add</span>&nbsp;회원가입</div>
		<div style="border-radius: 22px; border:1px; border-style:solid; border-color:lightgray ;width: 400px; height: 100%; padding:15px;margin: 2% auto">
			<div class="signInSubtitle">닉네임</div>
			<div class="input-group">
				<input type="text" name="nickName" id="nickName" class="form-control">
				<div class="input-group-append">
				<button type="button" class="btn border" onclick="nickNameCheck()">중복확인</button>
				</div>
			</div>
			<div class="signInSubtitle mt-2">아이디</div>
			<div class="input-group">
				<input type="text" name="mid" id="mid" class="form-control">
				<div class="input-group-append">
				<button type="button" class="btn border" onclick="midCheck()">중복확인</button>
				</div>
			</div>
			<div class="signInSubtitle mt-2">비밀번호</div>
			<div><input type="password" name="pwd" id="pwd" class="form-control"></div>
			<div class="signInSubtitle mt-2">비밀번호 확인</div>
			<div><input type="password" name="repwd" id="repwd" class="form-control"></div>
			<div class="signInSubtitle mt-2">이름</div>
			<div><input type="password" name="name" id="name" class="form-control"></div>
			<div class="signInSubtitle mt-2">이메일</div>
			<div class="input-group">
				<input type="text" name="email" id="email" class="form-control">
				<div class="input-group-append">
				<span class="input-group-text">@</span>
				<select name="domain" id="domain" class="form-control">
					<option value="naver.com">naver.com</option>
					<option value="google.com">google.com</option>
					<option value="daum.net">daum.net</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="nate.com">nate.com</option>	
				</select>
				</div>
			</div>
			<div name="timer" id="timer"></div>
			<div name="inputCode" id="inputCode" style="display:none"><input type="text" name="verCode" id="verCode" class="form-control" ></div>
			<div>
				<input type="button" onclick="sendVerificationEmail()" value="인증코드 전송" class="btn border mt-1 form-control" name="sendCode" id="sendCode">
				<input type="button" onclick="sendVerificationEmail()" value="재전송" class="btn border mt-1 form-control" name="resend" id="resend" style="width: 49%">
				<input type="button" onclick="codeCheck()" value="본인인증" class="btn border mt-1 form-control" name="codeCheck" id="codeCheck" style="width: 49%">
			</div>
			
			<div class="mt-2 mb-2"><button type="button" onclick="signInNext()" class="btn border form-control button-text">계속 진행하기</button></div>
		</div>
	</div>

</body>
</html>