<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<div class="row">
	<div class="col-10 mr-0 pr-0">
		<textarea rows="3" class="form-control" name="replyContent" id="replyContent"></textarea>
	</div>
	<div class="col-2 ml-0 pl-0">
		<button type="button" class="btn border form-control" style="height:100%;" onclick="answerReplyUpdate('${newsRead_vo.boa_idx}','${reply_vo.rep_group}','${sM_idx}')">답글달기</button>				
	</div>
</div>
<script>
	'use strict'
	
	function answerReplyupdate(boa_idx,rep_group,m_idx){
		let replyContent = $("#replyContent").val();
		
		$.ajax({
			type:"post",
			url:"${ctp}/board/answerReply", 
			data:{boa_idx:boa_idx,rep_group:rep_group,m_idx:m_idx,content:replyContent},
			success:function(){
				alert("답글을 작성하였습니다.");
				location.reload();
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자나 운영자에게 연락해주세요.");
			}			
		})
		
	}
</script>