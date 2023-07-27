<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
	'use strict'
	
			function openBanModal(ban_idx){
			
			$.ajax({
				type:"post",
				data:{ban_idx:ban_idx},
				url:"${ctp}/admin/getBanDetail",
				success:function(vo){
					$("#detailNickName").html(vo.nickName);
					$("#detailContent").html(vo.content);
					let str = vo.cdate;
					str = str.substr(0,10)
					$("#banCdate").html(str);
					$("#banTypeOut").html(vo.banType);
					$("#detailWdate").html(vo.wdate);
					$("#ban_idxInput").val(vo.ban_idx);
					$("#originalContent").val(vo.content);
					
					$("#banDetailModal").modal();
				},
				error:function(){
					alert("오류가 발생하였습니다. 같은 현상이 반복되면 관리자에게 연락해 주세요.");
				}
			})
		}
	
	function banOff(){
		let ban_idx = $("#ban_idxInput").val();
		
		let ans = confirm("정말로 제재를 해제하시겠습니까?\n같은 내용으로 다시 제재하실 수 없습니다!");
		if(!ans) return false;
		
		$.ajax({
			type:"post",
			data:{ban_idx:ban_idx},
			url:"${ctp}/admin/banOff",
			success:function(){
				alert("현 시간부로 해당 제재를 해제하였습니다.");
				location.reload();
			},
			error:function(){
				alert("전송 오류가 발생하였습니다. 같은 오류가 반복되면 관리자에게 연락해주십시오.");
			}
		})
		
	}
	
	function banUpdateSave(){
		let ban_idx = $("#ban_idxInput").val();
		let banType = $("#banTypeSel").val();
		let cdate = $("#cdateInput").val();
		let reasonInput = $("#reasonInput").val();
		let originalContent = $("#originalContent").val();
		
		let now = new Date().toISOString().split('T')[0];
		
		if(cdate < now) {
			alert("제재일자는 오늘보다 이후의 날짜로 설정해야합니다.");
			return false;
		}
		
		if(reasonInput.trim() == ""){
			alert("제재 내용 수정 사유를 적어주세요.");
			return false;
		}
		
		let ans = confirm("제재사항을 해당 내용으로 변경하시겠습니까?");
		if(!ans)return false;
		
		$.ajax({
			type:"post",
			data:{ban_idx:ban_idx,banType:banType,cdate:cdate,reasonInput:reasonInput,originalContent:originalContent},
			url:"${ctp}/admin/banUpdateSet",
			success:function(){
				alert("제재사항을 변경하였습니다.");
				return false;
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자에게 연락해주십시오.");
			}
		})
	}
		
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>
<div class="mainTitle">제재유저 관리<hr></div>
<div class="row text-center">
	<div class="col-12  text-left">
		<span class="subTitle">현재 제재 중인 유저만 표시됩니다.</span>
	</div>
	<div class="col-12"><hr></div>
	<div class="col-2">닉네임</div>
	<div class="col-2">제재사항</div>
	<div class="col-4">제재사유</div>
	<div class="col-2">해제날짜</div>
	<div class="col-2">제제일자</div>
	<div class="col-12"><hr></div>
	<c:forEach var="BLVO" items="${BLVOS}" varStatus="st">
		<div class="col-2">${BLVO.nickName}</div>
		<div class="col-2">${BLVO.banType}</div>
		<div class="col-4">
		<a href="javascript:openBanModal(${BLVO.ban_idx})">
			${fn:substring(BLVO.content,25,BLVO.content.length())}
		</a>
		</div>
		<div class="col-2">${fn:substring(BLVO.cdate,0,10)}</div>
		<div class="col-2">${fn:substring(BLVO.wdate,0,16)}</div>
	</c:forEach>
	<c:if test="${empty BLVOS}">
		<div class="col-12">
		현재 제재받은 유저가 없습니다.<hr>
		</div>
	</c:if>
</div>
</div>
<!-- The Modal -->
<div class="modal" id="banDetailModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">제재내용 상세</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
      	<div>제재내용</div>
        <div class="mainfont-b-22"> 
        	제재자 <span name="detailNickName" id="detailNickName"></span>
        </div>
        <div class="mainfont-m-16">
        	제재내용 <span name="datailContent" id="detailContent"></span>
        </div>
        <hr>
        <div>
        	<span class="mainfont-b-18">제재결과</span><br>
        	<div class="row">
        		<div class="col-6">
        		제재 종류 : <span name="banTypeOut" id="banTypeOut"></span>
        		</div>
        		<div class="col-6">
						해제일 : <span name="banCdate" id="banCdate"></span>        		
        		</div>
        	</div>
        </div>
        <div><hr></div>
        <div class="subTitle">제재 내용 수정</div>
        <div>
					수정내용(이전 제재 내용에 추가로 저장됩니다.)
       		<textarea rows="3" class="form-control" name="reasonInput" id="reasonInput"></textarea>
       		<input type="hidden" name="ban_idxInput" id="ban_idxInput">
       		<input type="hidden" name="originalContent" id="originalContent">
       	</div>
       	<div>
       		제재 종류
       		<select name="banTypeSel" id="banTypeSel">
       			<option value="1_replyBan">댓글 금지</option>
       			<option value="2_boardBan">글 작성 금지</option>
       			<option value="3_tempBan">임시 정지</option>
       			<option value="4_Ban">영구 정지</option>
       		</select>
       		해제일 <input type="date" name="cdateInput" id="cdateInput">
       		
       	</div>
       	<div> 		
       	</div>
        <div class="text-center mt-3">
        	<button type="button" class="btn border" onclick="banOff()">제재해제</button>
        	<button type="button" class="btn border" onclick="banUpdateSave()">제재내용 변경</button>
        </div>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>