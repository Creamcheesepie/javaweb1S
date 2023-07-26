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
				url:"${ctp}/member/sendMidVerificationEmail",
				data:{emailName:emailName,dom_idx:dom_idx},
				success:function(res){
					if(res==0){
						alert("해당 이메일로 가입된 계정이 없습니다.");
						return false;
					}
					
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
		
		function midFind(){
			let emailName = $("#emailName").val();
			let dom_idx = $("#dom_idx").val();
			
			if(emailOk!='true'){
				alert("이메일 인증을 하셔야 아이디를 찾을 수 있습니다.");
			}
			else{
				$.ajax({
					type:"post",
					data:{emailName:emailName,dom_idx:dom_idx},
					url:"${ctp}/member/midFindOutput",
					success:function(res){
						alert("회원님의 아이디는 "+res+"입니다.\n보안상의 이유로 아이디 일부는*로 대체됩니다.\n이 창을 닫으시면 다시 인증해야 합니다.\n아이디를 안전한 곳에 메모하시거나 정확히 기억해주세요.");
						emailOk="false";
					},
					error:function(){
						alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 운영자 또는 관리자에게 연락해 주세요.");
					}
				})	
			}
		}	
	</script>
</head>
	<div class="bigTitle text-center" style="margin-top:11%;"><a href="${ctp}/">함께타요</a></div>
	<div class="container" style="border-radius:22px; border:1px; border-style:solid; border-color:lightgray;margin-top:2%; width:400px;padding:11px;" >
		<form name="loginform" method="post">
		<div class="row">
			<div class="col-12">
				<span class="loginTitle">아이디 찾기</span>
				<c:if test="${!empty loginFail}"><br><span class="fontdot-12 red" style="color: red;">${loginFail}</span></c:if>
				<hr style="margin: 7px 0px 7px 0px"/>
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
				<div name="timer" id="timer" class="miniAlert"></div>
				<div name="cerCodeOk" id="cerCodeOk" class="miniAlert" style="font-size: 16px;display:none;">인증됨</div>
				<div name="inputCode" id="inputCode" style="display:none"><input type="text" name="verCode" id="verCode" class="form-control" ></div>
				<div>
					<input type="button" onclick="sendVerificationEmail()" value="인증코드 전송" class="btn border mt-1 form-control" name="sendCode" id="sendCode">
					<input type="button" onclick="sendVerificationEmail()" value="재전송" class="btn border mt-1 form-control" name="resend" id="resend" style="width: 49%; display:none">
					<input type="button" onclick="codeChecker()" value="본인인증" class="btn border mt-1 form-control" name="codeCheck" id="codeCheck" style="width: 49%;display:none">
				</div>
			</div>
		</div>
		<input type="hidden" name="from" value="${from}">
		</form>
		<div class="row mt-3">
			<div class="col-12 text-center ">
				<button type="button" onclick="midFind()" class="btn"><span class="btn-text">아이디 찾기</span></button>
			</div>
			<div class="col-12 text-center mt-2">
				<a href="${ctp}/member/findForm/pwd"><span class="mini-Link">비밀번호 찾기</span></a>
			</div>
		</div>
	</div>
<body>
</body>
</html>