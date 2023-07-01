<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<style>
		.pwdChange-container{
			width : 450px;
			margin : 3% auto;
			border-radius:25px;
			border-style:solid;
			border-color: lightgray;
			border-width: 1px;
			padding: 2%;
			position:relative;
			margin-top: 10%;
			margin-bottom: 11%;
		}
	</style>
	<script>
	'use strict'
	let pwdOk = "false";
	let rePwdOk="false";
	let intervalTimer = "";
	let timeOut="no";
	let emailOk = "false";
	const pwdRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/g; //비밀번호 정규식
	
	
	//인증메일 발송
	function sendVerificationEmail(){
		let emailName = $("#emailName").val();
		let dom_idx = $("#dom_idx").val();
		
		if(emailName.trim()==""){
			alert("이메일을 입력해 주세요.");
			$("#email").focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"${ctp}/member/sendPwdVerificationEmail",
			data:{emailName:emailName,dom_idx:dom_idx},
			success:function(res){
				clearInterval(intervalTimer);
				$("#sendCode").hide();
				$("#inputCode").slideDown();
				$("#resend").show();
				$("#codeCheck").show();
				timer();
				alert("이메일이 발송되었습니다. 인증코드를 확인해주세요. ");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 반복된다면 관리자나 운영자에게 문의해 주세요.");
			}
		})
	}
	
	//인증번호 확인
	function codeChecker(){
		
		if(timeOut=='ok'){
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
					alert("인증코드가 다릅니다 다시 확인해 주세요.");
				}
				else{
					alert("이메일이 인증되었습니다.");
					$("#inputCode").slideUp();
					$("#resend").hide();
					$("#codeCheck").hide();
					$("#timer").hide();
					$("#cerCodeOk").show();
					clearInterval(intervalTimer);
					emailOk="true";
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복된다면 관리자 또는 운영자에게 연락해 주세요.");
			}
		})
	}
	
	//타이머
	function timer(){
		var time = 300;
		var min = 0;
		var sec = 0;
		
		intervalTimer = setInterval(() => {
			min = parseInt(time/60);
			sec = time%60;
			document.getElementById("timer").innerHTML= min+"분"+sec+"초";
			time --;
			if(time<0){
				clearInterval(intervalTimer);
				document.getElementById("timer").innerHTML="인증시간 만료";
				timeOut='ok';
			}
		}, 1000);
	}	
	
	
		//비밀번호 정규식 검사
	function pwdCheck(){
		let pwd = $("#pwd").val();
		$("#pwdChecked").slideDown();
		if(!pwdRegEx.test(pwd)){
			$("#pwdChecked").html("비밀번호 양식은 영문 대소문자에 숫자, 특수문자 1개 이상 있어야합니다.");
		 	pwdOk = "false";
		 	return false;
		}
		else {
			$("#pwdChecked").html("양식에 맞는 비밀번호입니다.");
		 	pwdOk = "true";
		 	return false;
		}
	}
	
	function rePwdCheck(){
		let cPwd = $("#pwd").val();
		let repwd = $("#repwd").val();
		$("#rePwdChecked").slideDown();
		if(repwd != cPwd){
			$("#rePwdChecked").html("입력하신 비밀번호와 비밀번호 확인이 다릅니다. 다시 확인해 주세요.");
			rePwdOk = "false";
			return false;
		}
		else if(repwd == cPwd){
			$("#rePwdChecked").html("입력하신 비밀번호와 비밀번호 확인이 동일합니다.");
			rePwdOk = "true";
			return false;
		}	
	}
	
	function pwdChangeCheck(){
		
		if(pwdOk=="true" && rePwdOk=="true" && emailOk=="true"){
			let pwd = $("#pwd").val();
			let m_idx = ${sM_idx};
			let ans = confirm("정말로 변경하시겠습니까?");
			if(!ans){
				return false;
			}
			
			$.ajax({
				type:"post",
				data:{pwd:pwd,m_idx:m_idx},
				url:"${ctp}/member/pwdChangeCheck",
				success:function(res){
					alert("비밀번호 변경에 성공하였습니다.변경된 비밀번호로 다시 로그인해 주세요.");
					location.href="${ctp}/";
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자 또는 운영자에게 문의해주세요.");
				}
			})
		}
		else if(pwdOk=="false"){
			alert("비밀번호 양식을 확인해 주세요.");
		}
		else if(rePwdOk=="false"){
			alert("비밀번호 확인창에 입력된 비밀번호가 동일한지 확인해주세요.");
		}
		else if(emailOk=="false"){
			alert("이메일 인증을 하셨는지 확인해주세요.");
		}
		
		
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="pwdChange-container">
	<div class="mainTitle">비밀번호 변경</div>
	<div>이메일 인증</div>
		<div class="input-group">
			<input type="text" name="emailName" id="emailName" class="form-control" value="${emailInfoVo.emailName}" readonly>
			<div class="input-group-append">
			<span class="input-group-text">@</span>
			<select name="dom_idx" id="dom_idx" class="form-control" disabled>
				<option value="${emailInfoVo.dom_idx}" selected>${fn:substring(emailInfoVo.domain,1,fn:length(emailInfoVo.domain))}</option>
			</select>
			</div>
			</div>
			<div name="timer" id="timer" class="miniAlert"></div>
			<div name="cerCodeOk" id="cerCodeOk" class="miniAlert" style="font-size: 16px;display:none;">인증됨</div>
			<div name="inputCode" id="inputCode" style="display:none"><input type="text" name="verCode" id="verCode" class="form-control" ></div>
			<div>
				<input type="button" onclick="sendVerificationEmail()" value="인증코드 전송" class="btn border mt-1 form-control" name="sendCode" id="sendCode">
				<input type="button" onclick="sendVerificationEmail()" value="재전송" class="btn border mt-1 form-control" name="resend" id="resend" style="width: 49%; display:none">
				<input type="button" onclick="codeChecker()" value="본인인증" class="btn border mt-1 form-control" name="codeCheck" id="codeCheck" style="width: 49%;display:none">
			</div>
	<div class="signInSubtitle mt-2">비밀번호</div>
		<div>
			<input type="password" name="pwd" id="pwd" class="form-control" oninput="pwdCheck()" onBlur="pwdCheck()">
			<span class="miniAlert" name="pwdChecked" id="pwdChecked" style="display: none;"></span>
		</div>
		<div class="signInSubtitle mt-2">비밀번호 확인</div>
		<div>
			<input type="password" name="repwd" id="repwd" class="form-control" oninput="rePwdCheck()" onBlur="rePwdCheck()">
			<span class="miniAlert" name="rePwdChecked" id="rePwdChecked" style="display: none;"></span>
		</div>
	<div class="mt-2 text-center">
		<button type="button" onclick="location.href='${ctp}/member/myPage'" class="btn border">내 정보로</button>
		<button type="button" onclick="pwdChangeCheck()" class="btn border">변경하기</button>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>