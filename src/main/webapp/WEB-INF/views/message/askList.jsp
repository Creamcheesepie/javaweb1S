<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 쪽지함</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<style>
		body{
			background-color: #F2F2F2;
		}
		.myPage-container{
			background-color:white;
			height:100% ;
			margin-top: 8%;
			margin-bottom: 5%;
			border-radius: 22px;
			border-style: solid;
			border-color: lightgray;
			padding : 2%;
			width: 1000px;
		}
		.inst{
			width: 100%;
		}
		.list{
			min-height: 150px;
		}
	</style>
	<script>
	'use strict';
	
	function readMyAsk(ask_idx){
		$.ajax({
			type:"post",
			data:{ask_idx:ask_idx},
			url:"${ctp}/message/getMyAsk",
			success:function(vo){
				$("#askCategoryOutput").html(vo.category_name);
				$("#askTitleOutput").html(vo.title);
				$("#askContentOutput").html(vo.content);
				$("#wdateOutput").html(vo.wdate);
				
				if(vo.takeContent != null ) $("#takeResult").html(vo.takeContent);
				else $("#takeResult").html("아직 답변이 없습니다.");
				if(vo.takeContent != null) $("#takeResultTime").html(vo.tdate);
				else $("#takeResultTime").html("빠른시일 내에 답변하겠습니다.");
				$("#sendMessageModal").modal();
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자 또는 운영자에게 문의해주세요.")
			}
		})
	}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container myPage-container">
<div class="mainfont-b-28"><span class="material-symbols-outlined">live_help</span>문의함</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<button type="button" class="btn mainfont-b-22" onclick="window.open('${ctp}/message/openAskForm', '쪽지쓰기', 'width=515, height=460')">문의하기</button>	
	<hr>
	<div class="mainfont-b-16">
		<jsp:include page="/WEB-INF/views/include/messageSideBar.jsp"/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">문의항목</span><span class="mainfont-b-16 inactive">운영자에게 질문하고 싶은 것을 보내주세요.</span>
		<hr>
		<div class="row">
				<div class="col-3 text-center">분류</div>
				<div class="col-5">제목</div>
				<div class="col-2 text-center">처리여부</div>
				<div class="col-2 text-center">문의날짜</div>
				<div class="col-12"><hr></div>
			<c:forEach var="ask_vo" items="${ask_vos}" varStatus="st">
				<div class="col-3 text-center">${ask_vo.category_name}</div>
				<div class="col-5"><a href="javascript:readMyAsk('${ask_vo.ask_idx}')">${ask_vo.title}</a></div>
				<div class="col-2 text-center">
				<c:if test="${ask_vo.takeSw == 0}">문의중</c:if>
				<c:if test="${ask_vo.takeSw == 1}">처리중</c:if>
				<c:if test="${ask_vo.takeSw == 2}">처리완료</c:if>
				</div>
				<div class="col-2 text-center">${fn:substring(ask_vo.wdate,0,10)}</div>
				<div class="col-12"><hr></div>
			</c:forEach>
			<c:if test="${empty ask_vos}">
				<div class="col-12">
					<span class="inactive">아직 문의하신 사항이 없습니다.</span>
				</div>
			</c:if>
		</div>
	</div>
</div>
</div>
<!-- 쪽지 보냄 Modal -->
<div class="modal" id="sendMessageModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- Modal Header -->
      <div class="modal-header">
				<span name="modalTitle" id="modalTitle" class="mainTitle">내 문의</span>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
			<div class="row">

				<div class="col-8 mb-2">
					제목 <span name="askTitleOutput" id="askTitleOutput" class="mainfont-b-20"></span>
				</div>
				<div class="col-4 mb-2 text-right">
					분류 : <span name="askCategoryOutput" id="askCategoryOutput"></span>
				</div>
				<div class="col-12">
					<span class="mainfont-b-16">내용</span>
					<textarea rows="5" readonly class="form-control" name="askContentOutput" id="askContentOutput">
					</textarea>
				</div>
				<div class="col-12 text-right align-self-end">
					<span class="fontdot-12">신고시간 : </span><span name="wdateOutput" id="wdateOutput" class="fontdot-12"></span>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<span class="mainfont-b-16">답변</span><hr>
				</div>
				<div class="col-12">
				<textarea name="takeResult" id="takeResult" rows="4" class="form-control" readonly></textarea>
				</div>
				<div class="col-12 text-right align-self-end">
					<span class="fontdot-12">처리시간 : </span><span name="takeResultTime" id="takeResultTime" class="fontdot-12"></span>
				</div>
			</div>	
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn border" data-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>	
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>