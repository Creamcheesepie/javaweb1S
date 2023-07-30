<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/resources/js/postCodeFind.js"></script>
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
			margin-bottom: 5%;
			border-color: lightgray;
			padding : 2%;
			width: 600px;
		}
		.inst{
			width: 100%;
		}
		.list{
			min-height: 150px;
		}
		.change-form{
			width: 100%;
		}
		.change-form-one-third{
			width: 32%;
			float: left;
		}
		.change-form-half{
			width: 49%;
			float: left;
		}
		.miniAlert{
			font-family: 'Galmuri11','IBM Plex Sans KR', sans-serif;
			font-weight : 400;
			font-size: 12px;
			margin-left:4px;
		}
		button{
			font-family: 'IBM Plex Sans KR', sans-serif;
		}
		.addressButton{
			width: 150px; 
			margin: 0 auto;
		}
	</style>
	<script>
	'use strict';
	let defaultNick = '${vo.nickName}';
	let m_idx = '${vo.m_idx}';
	let checkedNick='';
	let nickCheckSw = '';
	let timeOut ='';
	let intervalTimer ='';
	
	const nickNameRegEx = /^[a-zA-Z0-9가-힣]{2,19}[a-zA-Z0-9가-힣]*$/g; //닉네임 정규식
	const nameRegEx = /^[a-zA-Z가-힣]{1,19}[a-zA-Z가-힣]*$/g; //이름 정규식
	
	function nickNameCheck(){
				
		let nickName=$("#nickName").val();
		
		if(nickName == defaultNick){
			alert("원래 닉네임과 동일한 닉네임입니다. 다른 닉네임을 입력해 주세요.");
			return false;
		}
		else if(!nickNameRegEx.test(nickName)){
			alert("닉네임 양식을 확인해주세요. 닉네임은 특수문자를 제회한 영문,숫자,한글로 2-19자까지 가능합니다.");
			$("#nickName").focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			data:{nickName:nickName},
			url:"${ctp}/member/nickNameCheck",
			success:function(res){
				if(res=='1'){
					alert("중복된 닉네임이 존재합니다. 다른 닉네임을 사용해 주세요.");
					$("#nickName").focus();
					return false;
				}
				else{
					alert("사용 가능한 닉네임입니다. 변경을 원하시면 변경하기 버튼을 눌러 주십시오.");
					$("#nickChange").focus();
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
	
	function nickCheckReset(){
		let inputAgainNick = $("#nickName").val();
		if(checkedNick == inputAgainNick && checkedNick.trim()!="" ){
			$("#nickChecked").html('<font color="red">확인완료!</font>');
			nickCheckSw = "1";
			return false;
		}
		if(defaultNick == inputAgainNick){
			$("#nickChecked").html('<font color="red">현재 닉네임입니다.</font>');
			nickCheckSw = "0";
			return false;
		}
		if(checkedNick != inputAgainNick || checkedNick.trim()!="" || defaultNick != inputAgainNick){
			$("#nickChecked").html('중복확인');
			nickCheckSw = "0";
		}
	}
	
	function nickChange(){
		
		let nickName=$("#nickName").val();
		
		if(nickName == defaultNick){
			alert("기존에 쓰시던 닉네임과 입력하신 닉네임이 동일합니다. 다른 닉네임을 입력해주세요.")
			return false;
		}
		
		if(nickCheckSw=='0'){
			alert("닉네임 중복검사를 해주세요!")
			return false;
		}
		
		$.ajax({
			type:"post",
			url:"${ctp}/member/nickNameChange",
			data:{m_idx:m_idx,nickName:nickName},
			success:function(res){
				if(res=='1'){
					alert("이미 등록된 닉네임입니다. 다른 닉네임을 사용해주세요.");
					return false;
				}
				else{
					alert("닉네임 변경 완료하였습니다.")
					defaultNick = nickName;
					$("#nickName").val(nickName);
					checkedNick="";
					nickCheckSw = "0";
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.")
			}
		})
	}
	
	function nameChange(){
		let name = $("#name").val();
		if(!nameRegEx.test(name)){
			alert("이름 양식을 확인해주세요. 닉네임은 특수문자를 제회한 영문,한글로 2-19자까지 가능합니다.");
			$("#name").focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			data:{m_idx:m_idx,name:name},
			url:"${ctp}/member/nameChange",
			success:function(){
				alert("이름을 바꾸었습니다.");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.");
			}
		})
	}
	
	function ageChange(){
		let age = $("#age").val();
		
		$.ajax({
			type:"post",
			data:{m_idx:m_idx,age:age},
			url:"${ctp}/member/ageChange",
			success:function(){
				alert("나이를 바꾸었습니다.");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.");
			}
		})
	}
	
	function genderChange(){
		let gender = $("#gender").val();

		$.ajax({
			type:"post",
			data:{m_idx:m_idx,gender:gender},
			url:"${ctp}/member/genderChange",
			success:function(){
				alert("성별을 바꾸었습니다.");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.");
			}
		})
	}
	
	//주소 변경 폼(모달)
	function addressChangeForm(){
			
			$("#addressChangeModal").modal();
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
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 반복된다면 관리자나 운영자에게 문의해 주세요.");
			}
		})
	}
	
	function reSendVerificationEmail(){
		clearInterval(intervalTimer);
		sendVerificationEmail()
	}
	
	//인증번호 확인 후 이메일 변경
	function emailChange(){
		let emailName = $("#emailName").val();
		let dom_idx = $("#dom_idx").val();
		if(timeOut=='ok'){
			alert("인증 시간이 만료되었습니다. 인증번호를 다시 전송받아 입력해 주세요.")
			$("#resend").focus();
			return false;
		}
		
		let verCode = $("#verCode").val();
		
		$.ajax({
			type:"post",
			url:"${ctp}/member/emailChange",
			data:{verCode:verCode,m_idx:m_idx,emailName:emailName,dom_idx:dom_idx},
			success:function(res){
				if(res=='1'){
					alert("인증코드가 다릅니다 다시 확인해 주세요.");
				}
				else{
					alert("이메일이 변경되었습니다.");
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
	
	function telChange(){
		let tel = $("#tel").val();
		
		$.ajax({
			type:"post",
			data:{m_idx:m_idx,tel:tel},
			url:"${ctp}/member/telChange",
			success:function(){
				alert("전화번호를 바꾸었습니다.");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.");
			}
		})
	}
	
	function birthdayChange(){
		let birthday = $("#birthday").val();
		
		$.ajax({
			type:"post",
			data:{m_idx:m_idx,birthday:birthday},
			url:"${ctp}/member/birthdayChange",
			success:function(){
				alert("생일을 바꾸었습니다.");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.");
			}
		})
	}
	
	function instChange(){
		let inst = $("#inst").val();
		
		$.ajax({
			type:"post",
			data:{m_idx:m_idx,inst:inst},
			url:"${ctp}/member/instChange",
			success:function(){
				alert("자기소개를 바꾸었습니다.");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.");
			}
		})
	}
	
	function addressChange(){
		let postcode = address-form.postcode.value + " ";
		let roadAddress = address-form.roadAddress.value + " ";
		let detailAddress = address-form.detailAddress.value + " ";
		let extraAddress = address-form.extraAddress.value + " "; //공백을 넣어주는 이유? : 나중에 정보 수정시 값 불러오기 용이하게 하기 위함.
		let address = postcode +"/"+ roadAddress +"/"+ detailAddress+"/"+ extraAddress +"/";
		
		$.ajax({
			type:"post",
			data:{m_idx:m_idx,address:address},
			url:"${ctp}/member/addressChange",
			success:function(){
				alert("주소를 바꾸었습니다.");
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 문제가 계속된다면 관리자 또는 운영자에게 문의해 주세요.");
			}
		})
	}
	
	function photoChangeSubmit(){
		photoChangeForm.submit();
	}
	
	function goPwdChangeForm(){
		pwdChangeForm.submit();
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container myPage-container">
	<span class="mainTitle">내 정보수정</span>
	<hr>
	<div class="row">
		<div class="col-12 mainfont-b-16" style="height: 160px">프로필 사진
			<hr>
			<c:if test="${vo.photo!=null}">
				<img src="${ctp}/resources/data/memberprofile/${vo.photo}" style="height: 100px ;width:127px">
			</c:if>
			<c:if test="${vo.photo==null}">
				<img src="${ctp}/resources/data/memberprofile/noimage.jpg" style="height: 100px ;width:127px">
			</c:if>
		</div>
		<div class="col-9">
		<form name="photoChangeForm" method="post" action="${ctp}/member/photoChange" enctype="multipart/form-data">
		<div class="input-group change-form" >
				<div><input type="file" name="fName" id="fName" class="form-control-file border" accept=".jpg,.png,.gif"></div>
				<div class="input-group-append">
				<button type="button" class="btn btn-sm border" name="photoChange" id="photoChange" onclick="photoChangeSubmit()">변경하기</button>
				</div>
			</div>
		</form>
		</div>	
		<div class="col-sm-8 mainfont-b-20 mr-0 pr-0 mt-2">
			<div>닉네임<span class="miniAlert" name="nickChecked" id="nickChecked"></span></div>
			<div class="input-group change-form">
				<input type="text" name="nickName" id="nickName" class="form-control" oninput="nickCheckReset()" value="${vo.nickName}">
				<div class="input-group-append">
				<button type="button" class="btn border" onclick="nickNameCheck()">중복확인</button>
				<button type="button" class="btn border" name="nickChange" id="nickChange" onclick="nickChange()">변경하기</button>
				</div>
			</div>
		</div>
		<div class="col-sm-12 mainfont-b-20 mt-2">
			아이디<span class="miniAlert" style="color: red">아이디는 변경하실 수 없습니다.</span><br/>
			<div class="change-form">
				<input type="text" class="form-control" value="${vo.mid}" readonly>
			</div>
		</div>
		<div class="col-sm-12 mainfont-b-20 mt-2">
			<div class="change-form-one-third"  style="margin-right:2%">
			이름<br/>
			<div class="input-group">
					<input type="text" name="name" id="name" class="form-control" value="${vo.name}">
				<div class="input-group-append">
					<button type="button" class="btn border" onclick="nameChange()">변경하기</button>
				</div>
			</div>
			</div>
			<div class="change-form-one-third"  style="margin-right:2%">
			나이<br/>
			<div class="input-group">
					<input type="number" name="age" id="age" class="form-control" value="${vo.age}">
				<div class="input-group-append">
					<button type="button" class="btn border" onclick="ageChange()">변경하기</button>
				</div>
			</div>
			</div>
			<div class="change-form-one-third">
			성별<br/>
			<div class="input-group">
					<input type="text" name="gender" id="gender" class="form-control" value="${vo.gender}">
				<div class="input-group-append">
					<button type="button" class="btn border" onclick="genderChange()">변경하기</button>
				</div>
			</div>
			</div>
		</div>
		<div class="col-sm-12 mainfont-b-20 mt-2">
			이메일
			<div class="input-group">
				<input type="text" name="emailName" id="emailName" class="form-control" value="${vo.emailName}">
				<div class="input-group-append">
				<span class="input-group-text">@</span>
				<select name="dom_idx" id="dom_idx" class="form-control">
					<c:forEach var="dom_vo" items="${domain_vos}" varStatus="st">
						<option value="${dom_vo.dom_idx}" <c:if test="${dom_vo.dom_idx==vo.dom_idx}">selected</c:if>>${fn:substring(dom_vo.domain,1,fn:length(dom_vo.domain))}</option>
					</c:forEach>
				</select>
				</div> 
			</div>
			<div name="timer" id="timer" class="miniAlert"></div>
			<div name="cerCodeOk" id="cerCodeOk" class="miniAlert" style="font-size: 16px;display:none;">변경완료</div>
			<div name="inputCode" id="inputCode" style="display:none"><input type="text" name="verCode" id="verCode" class="form-control" ></div>
			<div>
				<input type="button" onclick="sendVerificationEmail()" value="인증코드 전송" class="btn border mt-1 form-control" name="sendCode" id="sendCode">
				<input type="button" onclick="reSendVerificationEmail()" value="재전송" class="btn border mt-1 form-control" name="resend" id="resend" style="width: 49%; display:none">
				<input type="button" onclick="emailChange()" value="변경하기" class="btn border mt-1 form-control" name="codeCheck" id="codeCheck" style="width: 49%;display:none">
			</div>
		</div>
		<div class="col-sm-12">
		<!-- 이메일 인증사용 구간 -->
		</div>
		<div class="col-sm-12 mainfont-b-20 mt-2">
		<div class="change-form-half" style="margin-right: 2%">
			전화번호<br/>
			<div class="input-group">
					<input type="text" name="tel" id="tel" class="form-control" value="${vo.tel}">
				<div class="input-group-append">
					<button type="button" class="btn border" onclick="telChange()">변경하기</button>
				</div>
			</div>
		</div>
		<div class="change-form-half text-right">
		<div class="text-left">생일</div>
		<div class="input-group">
			<div><input type="date" name="birthday" name="birthday" class="form-control" value="${fn:substring(vo.birthday,0,10)}"></div>  
			<div class="input-group-append">
				<button type="button" class="btn border" onclick="birthdayChange()">변경하기</button>
			</div>
		</div>
		</div>
		</div>
		<div class="col-sm-12 mainfont-b-20 mt-2">
			주소
			<div class="input-group">
				<input type="text" class="form-control" value="${address}" readonly>
				<div class="input-group-append">
					<button type="button" class="btn border" onclick="addressChangeForm()">변경하기</button>
				</div>
			</div>
		</div>
		<div class="col-sm-12 mainfont-b-20 mt-2">
		자기소개
		<div style="margin-top: 1%">
			<div class="input-group">
				<textarea class="inst mainfont-m-16 form-control" rows="4">${vo.inst}</textarea>
				<div class="input-group-append">
					<button type="button" class="btn border" onclick="instChange()">변경하기</button>
				</div>
			</div>
		<form name="pwdChangeForm" method="post" action="${ctp}/member/pwdChange"></form>
		</div>		
		</div>
		<div class="col-12 text-center mt-2">
			<button type="button" class="btn border" onclick="location.href='${ctp}/member/myPage'">내정보로</button>
			<button type="button" class="btn border" onclick="goPwdChangeForm()">비밀번호 변경</button>
			<button type="button" class="btn border">탈퇴신청</button>
		</div>
	</div>
</div>
<!-- The Modal -->
 <div class="modal fade" id="addressChangeModal">
   <div class="modal-dialog">
     <div class="modal-content">
       <!-- Modal Header -->
       <div class="modal-header">
         <h4 class="modal-title mainfont-b-22">주소 변경하기</h4>
         <button type="button" class="close" data-dismiss="modal">×</button>
       </div>
       <!-- Modal body -->
       <div class="modal-body">
       <span class="mainfont-b-20">내 주소 찾기</span>
      <form name="address-form">
			<div class="form-group" style="margin-top: 3%"> <!-- 주소 div 시작 -->
				<div class="row">
					<div class="col">
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
		  </form>	
		    <div class="text-center">
		    	<div class="addressButton text-center"><button type="button" onclick="addressChange()" class="btn form-control border">변경하기</button></div>
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