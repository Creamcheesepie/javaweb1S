<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 쪽지함</title>
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
	
	function readMyReport(rep_idx){
		$.ajax({
			type:"post",
			data:{rep_idx:rep_idx},
			url:"${ctp}/message/getMyReport",
			success:function(vo){
				if(vo.reportednickName!=null) $("#reportedOutput").html(vo.reportednickName);
				if(vo.reportedTitle!=null) $("#reportedOutput").html(vo.reportedTitle);
				if(vo.reportedContent!=null) $("#reportedOutput").html(vo.reportedContent);
				
				$("#reportCategoryOutput").html(vo.category_name);
				$("#reportTitleOutput").html(vo.title);
				$("#reportContentOutput").html(vo.content);
				$("#wdateOutput").html(vo.wdate);
				
				if(vo.takeContent!=null) $("#takeResult").html(vo.takeContent);
				else $("#takeResult").html("아직 처리되지 않았습니다.");
				if(vo.takeContent!=null) $("#takeResultTime").html(vo.tdate);
				else $("#takeResultTime").html("빠른시일 내에 처리하겠습니다.");
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
<div class="mainfont-b-28"><span class="material-symbols-outlined">report</span>신고 처리 결과</div>
<hr>
<div class="row">
	<div class="col-2 text-center">
	<button type="button" class="btn mainfont-b-22" onclick="window.open('${ctp}/message/openWrite', '쪽지쓰기', 'width=515, height=460')">쪽지쓰기</button>	
	<hr>
	<div class="mainfont-b-16">
		<jsp:include page="/WEB-INF/views/include/messageSideBar.jsp"/>
	</div>
	</div>
	<div class="col-10">
		<span class="mainfont-b-18">신고항목</span><span class="mainfont-b-16 inactive"> 신고는 커뮤니티 내의 개별 신고 항목에서 하실 수 있습니다.</span>
		<hr>
		<div class="row">
				<div class="col-3 text-center">신고사유</div>
				<div class="col-5">제목</div>
				<div class="col-2 text-center">처리여부</div>
				<div class="col-2 text-center">신고날짜</div>
				<div class="col-12"><hr></div>
			<c:forEach var="rep_vo" items="${report_vos}" varStatus="st">
				<div class="col-3 text-center">${rep_vo.category_name}</div>
				<div class="col-5"><a href="javascript:readMyReport('${rep_vo.rep_idx}')">${rep_vo.title}</a></div>
				<div class="col-2 text-center">
				<c:if test="${empty rep_vo.takeSw}">신고됨</c:if>
				<c:if test="${rep_vo.takeSw == 1}">처리중</c:if>
				<c:if test="${rep_vo.takeSw == 2}">처리완료</c:if>
				</div>
				<div class="col-2 text-center">${fn:substring(rep_vo.wdate,0,10)}</div>
				<div class="col-12"><hr></div>
			</c:forEach>
			<c:if test="${empty report_vos}">
				<div class="col-12">
					<span class="inactive">아직 신고하신 사항이 없습니다.</span>
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
				<span name="modalTitle" id="modalTitle" class="mainTitle">내 신고</span>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
			<div class="row">
				<div class="col-8">
					신고대상 : <span name="reportedOutput" id="reportedOutput"></span>
				</div>
				<div class="col-4 mb-2 text-right">
					분류 : <span name="reportCategoryOutput" id="reportCategoryOutput"></span>
				</div>
				<div class="col-12 mb-2">
					제목 <span name="reportTitleOutput" id="reportTitleOutput" class="mainfont-b-20"></span>
				</div>
				<div class="col-12">
					<span class="mainfont-b-16">내용</span>
					<textarea rows="5" readonly class="form-control" name="reportContentOutput" id="reportContentOutput">
					</textarea>
				</div>
				<div class="col-12 text-right align-self-end">
					<span class="fontdot-12">신고시간 : </span><span name="wdateOutput" id="wdateOutput" class="fontdot-12"></span>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					처리결과<hr>
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