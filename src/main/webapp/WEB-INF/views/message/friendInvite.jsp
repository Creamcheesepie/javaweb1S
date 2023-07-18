<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
	'use strict';
	
	function friendInviteSend(){
		let content = $("#content").val();
		let t_idx = $("#t_idx").val();
		
		if(content.trim()==""){
			alert("친구 신청 내용을 입력하여주세요!");
			return false;
		}
		
		$.ajax({
			type:"post",
			data:{content:content,t_idx:t_idx},
			url:"${ctp}/message/friendInviteSend",
			success:function(res){
				if(res=="1"){
					alert("이미 친구신청을 하였거나 친구가 된 회원입니다.")
					return false;
				}
				alert("정상적으로 친구신청이 되었습니다.");
				location.reload();
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자 또는 운영자에게 연락하여 주십시오.");
			}
		})
		
	}
	</script>
</head>
<body>
<div style="margin: 2%">
	<div class="mainfont-b-18">친구신청</div>
	<div>대상 : ${title}</div>
	<input type="hidden" name="t_idx" id="t_idx" value="${t_idx}">
	<div>내용</div>
	<textarea rows="6" class="form-control" name="content" id="content" placeholder="친구 신청할 상대방에게 말해주고 싶은 것을 적어주세요!"></textarea>
	<div class="text-center mt-2">
		<button type="button" class="btn border" onclick="friendInviteSend()">신청하기</button>
		<button type="button" class="btn border" onclick="self.close()">닫기</button>
	</div>
</div>
</body>
</html>