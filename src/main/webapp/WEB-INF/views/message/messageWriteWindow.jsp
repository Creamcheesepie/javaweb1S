 <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 쓰기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
	'use strict';
	$(document).ready(function(){
		let sendedSw = '${sendedSw}';
		if(sendedSw=="ok"){
			let ans = confirm("쪽지가 보내졌습니다, 더 보내시겠습니까?");
			if(!ans) window.close();
			else return false;
		}
		
	})
	
	function receiverSearch(){
		let searchOption = $("#searchOption").val();
		let searchStr = $("#searchStr").val();
		
		$.ajax({
			type:"post",
			data:{searchOption:searchOption,searchStr:searchStr},
			url:"${ctp}/message/receiverSearch",
			success:function(vos){
				let str = "";
				for(let i=0; i<vos.length;i++){	
					if(searchOption=="mid"){
						str+= '<a href="javascript:selectReceiver(\' '+vos[i].m_idx+' \',\' '+vos[i].mid + ' \')">'+ vos[i].mid +'<a/><br/>';
					}
					if(searchOption=="nickName"){
						str+= '<a href="javascript:selectReceiver(\' '+vos[i].m_idx+' \',\' '+vos[i].nickName + ' \')">'+ vos[i].nickName +'<a/><br/>';
					}
				}
				$("#searchOutput").html(str);
				$("#searchResult").slideDown(); 
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자 또는 운영자에게 연락해 주세요.");
			}
		})
	}
	
	function selectReceiver(m_idx,output){
		$("#selectedReceiver").html(output);
		$("#receive_m_idx").val(m_idx);
		$("#searchSector").slideUp();
	}
	
	function messageSend(){
		
		let receive_m_idx = $("#receive_m_idx").val();
		let title = $("#title").val();
		let content = $("#content").val();
		
		if(receive_m_idx.trim()==""){
			alert("쪽지를 보낼 대상을 선택하여 주십시오.");
			$("#searchStr").focus();
			return false;
		}
		
		if(title.trim() == ""){
			alert("제목을 입력하여 주십시오.");
			$("#title").focus();
			return false;
		}
		
		if(content.trim()==""){
			alert("내용을 입력하여 주십시오.");
			$("#content").focus();
			return false;
		}
		
		messageSendForm.submit();
	}
	
	
	</script>
</head>
<body>
<form name="messageSendForm" method="post" action="${ctp}/message/send">
<div class="row" style="padding: 10px 30px 0px 30px">
	<div class="col-12 mainTitle">쪽지 쓰기</div>
	<div class="col-12">
		<span class="mainfont-b-18">To <span name="selectedReceiver" id="selectedReceiver"></span></span>
		<input type="hidden" name="receive_m_idx" id="receive_m_idx">
		<input type="hidden" name="m_idx" id="m_idx" value="${sM_idx}">
	</div>
	<div name="searchSector" id="searchSector" class="row"  style="padding: 0px 15px 0px 15px">
	<div class="col-3">
		<select class="form-control" style="width:100px" name="searchOption" id="searchOption">
			<option value="nickName">닉네임</option>
			<option value="mid">아이디</option>
		</select>
	</div>
	<div class="col-6 m0 p0">
		<input type="text" class="form-control" name="searchStr" id="searchStr">
	</div>
	<div class="col-3">
		<button type="button" class="btn border" onclick="receiverSearch()">검색하기</button>
	</div>
	<div class="col-12" name="searchResult" id="searchResult" style="display: none;">
		<span>쪽지를 보낼 대상을 선택해 주십시오.</span><br/>
		<span name="searchOutput" id="searchOutput"></span>
	</div>
	</div>
	<div class="col-8">
	제목
	</div>
	<div class="col-4">
	분류
	</div>
	<div class="col-8">
	<input type="text" placeholder="쪽지 제목을 입력해 주세요." class="form-control" name="title" id="title">
	</div>
	<div class="col-4">
		<select class="form-control" name="msg_category" id="msg_category">
			<c:forEach var="msg_categoryVO" items="${msg_categoryVOS}" varStatus="st">
				<option value="${msg_categoryVO.msg_category}">${msg_categoryVO.category_name}</option>
			</c:forEach>
		</select>
	</div>
	<div class="col-12">
	내용
	</div>
	<div class="col-12">
		<textarea rows="8" class="form-control" name="content" id="content"></textarea>
	</div>
	<div class="col-12 text-center mt-2">
		<button type="button" class="btn border" onclick="window.location.reload()">다시 쓰기</button>
		<button type="button" class="btn border" onclick="messageSend()">쪽지 보내기</button>
	</div>
</div>
</form>
</body>
</html>