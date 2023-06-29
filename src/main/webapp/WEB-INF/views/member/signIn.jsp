<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/resources/js/postCodeFind.js"></script>
	<style>
	@font-face{
		font-family: "Galmuri14";
		src:url("$(ctp)/resources/font/Galmuri13.ttf") format("turetype");
	}
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
	.miniAlert{
		font-family: 'Galmuri14','IBM Plex Sans KR', sans-serif;
		font-weight : 400;
		font-size: 12px;
		margin-left:4px;
	}
	textarea{
		resize : none;
		width:100%;
	}
	</style>
	<script>
	'use strict'
	let emailOk="false";
	let timeOut = "no";
	let checkedMid="";
	let checkedNick="";
	let idCheckSw = 0;
	let nickCheckSw = 0;
	let pwdOk = "false";
	let rePwdOk = "false";
	//정규식
	const midRegEx = /^[a-zA-Z0-9]{4,20}[^\W]/; //아이디 정규식
	const pwdRegEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/g; //비밀번호 정규식
	const nickNameRegEx = /^[a-zA-Z0-9가-힣]{2,19}[a-zA-Z0-9가-힣]*$/g; //닉네임 정규식
	const nameRegEx = /^[a-zA-Z가-힣]{1,19}[a-zA-Z가-힣]*$/g; //이름 정규식
	
	//닉네임 체크
	function nickNameCheck(){
		let nickName = $("#nickName").val();
		
		if(nickName.trim()==""){
			alert("닉네임을 입력해 주세요");
			$("#nickName").focus();
			return false;
		}
		else if(!nickNameRegEx.test(nickName)){
			alert("닉네임 양식을 확인해주세요. 닉네임은 특수문자를 제회한 영문,숫자,한글로 2-19자까지 가능합니다.");
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
					$("#mid").focus();
					checkedNick = nickName;
					nickCheckSw = 1;
					$("#nickChecked").html('<font color="red">확인완료!</font>');
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 동일한 오류가 지속되면 운영자 혹은 관리자에게 문의해주세요.")
			}
		})
	}
	
	//아이디체크
	function midCheck(){
		let mid = $("#mid").val();
		
		if(mid.trim()==""){
			alert("아이디를 입력해 주세요");
			$("#mid").focus();
			return false;
		}
		else if(!midRegEx.test(mid)){
			alert("아이디 양식을 확인해 주세요. 아이디는 영문과 숫자만 사용가능합니다.");
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
					$("#pwd").focus();
					checkedMid = mid;
					idCheckSw = 1;
					$("#idChecked").html('<font color="red">확인완료!</font>');
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 동일한 오류가 지속되면 운영자 혹은 관리자에게 문의해주세요.")
			}
		})
	}
	
	//중복검사 후 내용 수정시 다시 검사하게 하기
	function midCheckReset(){
		let inputAgainMid = $("#mid").val();
		if(checkedMid == inputAgainMid && checkedMid.trim()!=""){
			$("#idChecked").html('<font color="red">확인완료!</font>');
			idCheckSw = "1";
			return false;
		}
		else{
			$("#idChecked").html('중복확인');
			idCheckSw = "0";
			return false;
		}
	}
	
	function nickCheckReset(){
		let inputAgainNick = $("#nickName").val();
		if(checkedNick == inputAgainNick && checkedNick.trim()!="" ){
			$("#nickChecked").html('<font color="red">확인완료!</font>');
			nickCheckSw = "1";
			return false;
		}
		else{
			$("#nickChecked").html('중복확인');
			nickCheckSw = "0";
			return false
		}
	}
	
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
			url:"${ctp}/member/sendVerificationEmail",
			data:{emailName:emailName,dom_idx:dom_idx},
			success:function(res){
				if(res=='1'){
					alert("이미 가입된 메일입니다. 다른 이메일을 사용해 주세요.")
					$("#email").focus();
					return false;
				}
				else{
					$("#sendCode").hide();
					$("#inputCode").slideDown();
					$("#resend").show();
					$("#codeCheck").show();
					timeOut = 'no';
					timer("no");
					alert("이메일이 발송되었습니다. 인증코드를 확인해주세요. ");
				}
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
					timer("stop");
					emailOk="true";
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복된다면 관리자 또는 운영자에게 연락해 주세요.");
			}
		})
	}
	
	//타이머
	function timer(stopper){
		var time = 300;
		var min = 0;
		var sec = 0;
		
		var x = setInterval(() => {
			min = parseInt(time/60);
			sec = time%60;
			document.getElementById("timer").innerHTML= min+"분"+sec+"초";
			time --;
			if(time<0 || stopper=="stop"){
				clearInterval(x);	
				document.getElementById("timer").innerHTML="인증시간 만료";
				timeOut='ok';
			}
		}, 1000);
	}
	
	//비밀번호 정규식 검사
	function pwdCheck(){
		let pwd = $("#pwd").val();
		
		if(!pwdRegEx.test(pwd)){
			$("#pwdChecked").html("비밀번호 양식은 영문 대소문자에 숫자, 특수문자 1개 이상 있어야합니다.");
		 	pwdOk = "false";
		}
		else {
			$("#pwdChecked").html("양식에 맞는 비밀번호입니다.");
		 	pwdOk = "true";
		}
		
		$("#pwdChecked").slideDown();
	}
	
	function rePwdCheck(){
		let cPwd = $("#pwd").val();
		let repwd = $("#repwd").val();
		if(repwd != cPwd){
			$("#rePwdChecked").html("입력하신 비밀번호와 비밀번호 확인이 다릅니다. 다시 확인해 주세요.");
			rePwdOk = "false";
		}
		else if(repwd == cPwd){
			$("#rePwdChecked").html("입력하신 비밀번호와 비밀번호 확인이 동일합니다.");
			rePwdOk = "true";
		}	
		$("#rePwdChecked").slideDown();
	}
	
	
	function signInNext(){
		$("#signIn-form-1").slideUp();
		$("#signIn-form-2").slideDown();
	}
	
	function signInBefore(){
		$("#signIn-form-1").slideDown();
		$("#signIn-form-2").slideUp();
	}
	
	function signInCheck(){
		let fPwd = $("#pwd").val();
		console.log(fPwd);
		console.log(pwdOk)
		if(idCheckSw==0){
			alert("아이디 중복체크를 해주십시오.");
			signInBefore();
			$("#mid").focus();
			return false;
		}
		else if(nickCheckSw==0){
			alert("닉네임 중복체크를 해주십시오.");
			signInBefore();
			$("#nickName").focus();
			return false;
		}
		else if(pwdOk=="false"){
			alert("비밀번호 양식을 확인해 주세요. 비밀번호 양식은 영문 숫자 조합에 특수문자를 1개 이상 포함하여 8~20자로 쓰셔야 합니다.");
			signInBefore();
			$("#pwd").focus();
			return false;
		}
		else if(rePwdOk=="false"){
			alert("비밀번호 확인을 입력해 주세요. 입력하신 비밀번호와 비밀번호 확인 창이 다릅니다.");
			signInBefore();
			$("#repwd").focus();
			return false;
		}
		else if(emailOk=="false"){
			alert("이메일 인증이 이루어지지 않았습니다. 이메일 인증을 진행해 주세요.");
			signInBefore();
			$("#sendCode").focus();
			return false;
		}
		else{
			let postcode = signInForm.postcode.value + " ";
			let roadAddress = signInForm.roadAddress.value + " ";
			let detailAddress = signInForm.detailAddress.value + " ";
			let extraAddress = signInForm.extraAddress.value + " "; //공백을 넣어주는 이유? : 나중에 정보 수정시 값 불러오기 용이하게 하기 위함.
			signInForm.address.value  = postcode +"/"+ roadAddress +"/"+ detailAddress+"/"+ extraAddress +"/";
			
			
			
			signInForm.submit();
		}
		
		
	}

	</script>
</head>
<body>
	<div class="container" >
		<div class="signInTitle text-center" style="margin-top:10%"><span class="material-symbols-outlined titleIcon">person_add</span>&nbsp;회원가입</div>
		<form name="signInForm"  method="post" enctype="multipart/form-data">
		<div name="signIn-form-1" id="signIn-form-1" style="border-radius: 22px; border:1px; border-style:solid; border-color:lightgray ;width: 400px; height: 100%; padding:15px;margin: 2% auto">
			<div class="signInSubtitle">닉네임<span class="miniAlert" name="nickChecked" id="nickChecked"></span></div>
			<div class="input-group">
				<input type="text" name="nickName" id="nickName" class="form-control" oninput="nickCheckReset()">
				<div class="input-group-append">
				<button type="button" class="btn border" onclick="nickNameCheck()">중복확인</button>
				</div>
			</div>
			<div class="signInSubtitle mt-2">아이디<span class="miniAlert" name="idChecked" id="idChecked"></span></div>
			<div class="input-group">
				<input type="text" name="mid" id="mid" class="form-control" oninput="midCheckReset()">
				<div class="input-group-append">
				<button type="button" class="btn border" onclick="midCheck()">중복확인</button>
				</div>
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
			<div class="signInSubtitle mt-2">이름</div>
			<div><input type="text" name="name" id="name" class="form-control"></div>
			<div class="signInSubtitle mt-2">이메일</div>
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
			
			<div class="mt-2 mb-2"><button type="button" onclick="signInNext()" class="btn border form-control button-text">계속 진행하기</button></div>
		</div>
		
		<div name="signIn-form-2" id="signIn-form-2" style="border-radius: 22px; border:1px; border-style:solid; border-color:lightgray ;width: 400px; height: 100%; padding:15px;margin: 2% auto;display: none">
		<div class="signInSubtitle">전화번호</div>
		<div><input type="text" name="tel" id="tel" class="form-control"></div>
		<div class="row">
			<div class="col-3">
			<span class="signInSubtitle">나이</span>
			<div><input type="number" name="age" id="age" class="form-control"></div>
			</div>
			<div class="col-3">
			<div class="signInSubtitle">성별</div>
			<div><input type="text" name="gender" name="gender" class="form-control"></div>  
			</div>
			<div class="col-6">
			<div class="signInSubtitle">생일</div>
			<div><input type="date" name="birthday" name="birthday" class="form-control"></div>  
			</div>
		</div>

			<div class="signInSubtitle">주소</div>
			<div class="form-group"> <!-- 주소 div 시작 -->
				<div class="row">
					<div class="col">
			      <input type="hidden" name="address" id="address">
			      <div class="input-group mb-1">
			        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
			        <div class="input-group-append">
			          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
			        </div>
			      </div>
			     </div>
	      </div>
	      <div class="row">
					<div class="col">
		      	<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
		      </div>
		     </div>
	      <div class="row">
					<div class="col">
		      <div class="input-group ">
		        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
		        <div class="input-group-append">
		          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
		        </div>
		       </div>
		    </div>
	      </div>
		    </div><!-- 주소 div 끝 -->

		   		<div class="signInSubtitle">라이딩정보</div>
		   	<div class="row ">
			   	<div class="col-4">
				   	<span class="signInSubtitle">속도</span>
						<div><input type="number" name="speed" id="speed" class="form-control"></div>
			   	</div>
			   	<div class="col-4">
				   	<span class="signInSubtitle">시간</span>
						<div><input type="number" name="duration" id="duration" class="form-control"></div>
			   	</div>
			   	<div class="col-4 ">
				   	<span class="signInSubtitle">획득고도</span>
						<div><input type="number" name="getHeight" id="getHeight" class="form-control"></div>
			   	</div>
		   	</div>
		   	<div class="signInSubtitle">사진</div>
		    <div><input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.png,.gif"></div>
		   	<div class="signInSubtitle">자기소개</div>
		   	<div><textarea name="inst" id="inst" rows="6" class="form-control"></textarea></div>
		   	<div style="margin-top: 2%">
			   	<button type="button" onclick="signInBefore()" class="btn border form-control button-text" style="width: 49%;">돌아가기</button>
			   	<button type="button" onclick="signInCheck()" class="btn border form-control button-text" style="width: 49%;">회원가입</button>
		   	</div>
			</div>
			<input type="hidden" name="fullmail" id="fullmail">
		</form>
	</div>

</body>
</html>