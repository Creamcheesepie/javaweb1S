<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 관리</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		'use strict';
		
		
		function openTakeModal(rep_idx){
			
			$.ajax({
				type:"post",
				data:{rep_idx:rep_idx},
				url:"${ctp}/admin/getReportDetail",
				success:function(vo){
					$("#deleteOutput").show();
					$("#detailNickName").html(vo.nickName);
					$("#detailTitle").html(vo.title);
					$("#detailContent").html(vo.content);
					$("#detailWdate").html(vo.wdate);
					
					if(vo.reportedTitle != null){
						$("#reportedTitleOutput").show();
						$("#detailPart").html("게시글 신고");
					}
					else{
						$("#reportedTitleOutput").hide();
						$("#deleteOutput").hide();
						$("#detailPart").html("회원 신고")
					}
					if(vo.reportedContent !=null) {
						$("#reportedContentOutput").show();
						if(vo.reportedTitle == null) $("#detailPart").html("댓글 신고");
					}
					else{
						$("#reportedContentOutput").hide();
					}
					
					$("#reportedNickName").html(vo.reportednickName);
					$("#reportedTitle").html(vo.reportedTitle);
					$("#reportedContent").html(vo.reportedContent);
					
					$("#tableNameInput").val(vo.tableName);
					$("#idxNameInput").val(vo.idxName);
					$("#reported_m_idxInput").val(vo.reported_m_idx);
					$("#reported_idxInput").val(vo.reported_idx);
					$("#rep_idxInput").val(vo.rep_idx);
					$("#reportDetailModal").modal();
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자에게 문의하여 주십시오.");
				}
			})
		}
		
		function reportTakeSave(){
			let reported_idx = $("#reported_idxInput").val();
			let rep_idx = $("#rep_idxInput").val();
			let reported_m_idx = $("#reported_m_idxInput").val();
			let tableName = $("#tableNameInput").val();
			let idxName = $("#idxNameInput").val();
			let banType = $("#banType").val();
			let penaltyTime = $("#penaltyTime").val();
			let takeSw = $("#takeSwValue").val();
			let takeContent = $("#takeContentInput").val();
			let deleteValue = $("#deleteValue").val();
			
			if(takeContent.trim()==""){
				alert("신고 처리 내용을 입력해 주세요.");
				return false;
			}
			
			$.ajax({
				type:"post",
				data:{reported_idx:reported_idx,reported_m_idx:reported_m_idx,banType:banType,takeSw:takeSw,takeContent:takeContent,tableName:tableName,idxName:idxName,deleteValue:deleteValue,penaltyTime:penaltyTime,rep_idx:rep_idx},
				url:"${ctp}/admin/reportTakeInput",
				success:function(){
					alert("성공적으로 처리하였습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류가 발생하였습니다.같은 현상이 반복되면 관리자에게 문의하여 주십시오.");
				}
			})
			
			
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>
	<form action="${ctp}/admin/adminReportForm" method="post">
	<div class="row">
		<div class="col-12">
			<div class="mainTitle">신고 관리</div>
			<HR>
		</div>
		<div class="col-1 align-self-center">
		세부조회
		</div>	
		<div class="col-1 align-self-center">
		</div>
		<div class="col-1 align-self-center">
		조회일자
		</div>
		<div class="col-4 align-self-center">
			<input type="date" name="afterDate" id="afterDate">
			~
			<input type="date" name="beforeDate" id="beforeDate">
		</div>
		<div class="col-1 align-self-center">
			신고사유
		</div>
		<div class="col-3 align-self-center">
			<select  name="rep_category" id="rep_category">
				<option value="">전체조회</option>
				<c:forEach var="repcVO" items="${repcVOS}" varStatus="st">
					<option value="${repcVO.rep_category}">${repcVO.name}(${repcVO.tableName})</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-1  align-self-center">
			<button type="submit" class="btn border">조회</button>
		</div>
	</div>
	</form>
	<div class="row">
		<div class="col-12 text-center">
			<hr>	
		</div>
		<div class="col-2 text-center">
		분류
		</div>
		<div class="col-4 text-center">
		제목
		</div>
		<div class="col-2 text-center">
		신고일자
		</div>
		<div class="col-1 text-center">
		신고자
		</div>
		<div class="col-1 text-center">
		처리여부
		</div>
		<div class="col-2 text-center">
		처리날짜
		</div>
		<div class="col-12">
			<hr>
		</div>
		<c:forEach var="repVO" items="${repVOS}" varStatus="st">
			<div class="col-2 text-center">
			${repVO.category_name}
			</div>
			<div class="col-4 text-center">
			${repVO.title}
			</div>
			<div class="col-2 text-center">
			${fn:substring(repVO.wdate,0,10)}
			</div>
			<div class="col-1 text-center">
			${repVO.nickName}
			</div>
			<div class="col-1 text-center">
			<c:if test="${empty repVO.takeSw}">
				<button type="button" class="btn border" onclick="openTakeModal(${repVO.rep_idx})">처리</button>
			</c:if>
			<c:if test="${repVO.takeSw == 1}">
				처리중
			</c:if>
			<c:if test="${repVO.takeSw == 2}">
				처리완료
			</c:if>
			</div>
			<div class="col-2 text-center">
			<c:if test="${empty repVO.tdate}">
				처리 전입니다.
			</c:if>
			<c:if test="${!empty repVO.tdate}">
				${repVO.tdate}
			</c:if>
			</div>
			<div class="col-12">
				<hr>
			</div>
		</c:forEach>
	</div>
</div>
<!-- The Modal -->
<div class="modal" id="reportDetailModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">신고 상세</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<div>신고 정보</div>
        <div> 
        	신고자 : <span name="detailNickName" id="detailNickName"></span>
        </div>
        <div>
        	제목 : <span name="datailTitle" id="detailTitle"></span>
        </div>
        <div>
        	신고내용<br>
        	<textarea rows="6" class="form-control" name="detailContent" id="detailContent"></textarea>
        </div>
        <div>
        	신고시간 : <span name="detailWdate" id="detailWdate"></span>
        </div>
        <div><hr></div>
        <div>
        	신고 대상 정보(<span name="detailPart" id="detailPart"></span>)
        </div>
        <div>
        	닉네임 : <span name="reportedNickName" id="reportedNickName"></span>
        </div>
        <div name="reportedTitleOutput" id="reportedTitleOutput" style="display: none;">
        	제목 : <span name="reportedTitle" id="reportedTitle"></span>
        </div>
        <div name="reportedContentOutput" id="reportedContentOutput" style="display: none;">
        	내용<br>
        	<textarea rows="6" class="form-control" name="reportedContent" id="reportedContent"></textarea>
        </div>
        <div><hr></div>
        <div>
       		신고 처리
       		<input type="hidden" name="rep_idxInput" id="rep_idxInput">
       		<input type="hidden" name="reported_m_idxInput" id="reported_m_idxInput">
       		<input type="hidden" name="reported_idxInput" id="reported_idxInput">
       		<input type="hidden" name="tableNameInput" id="tableNameInput">
       		<input type="hidden" name="idxNameInput" id="idxNameInput">
       	</div>
       	<div id="deleteOutput" name="deleteOutput">
       		신고 대상 처리
       		<select id="deleteValue" name="deleteValue">
       			<option value='0'>선택</option>
       			<option value='1'>삭제</option>
       		</select>
       	</div>
       	<div>
       		제재 종류
       		<select name="banType" id="banType">
       			<option value="1_replyBan">댓글 금지</option>
       			<option value="2_boardBan">글 작성 금지</option>
       			<option value="3_tempBan">임시 정지</option>
       			<option value="4_Ban">영구 정지</option>
       		</select>
       		해제일 <input type="date" name="penaltyTime" id="penaltyTime">
       	</div>
       	<div>
       		처리경과
	       	<select name="takeSwValue" id="takeSwValue">
	       		<option value="0">처리전</option>
	       		<option value="1">처리중</option>
	       		<option value="2">처리완료</option>
	       	</select>
       	</div>
       	<div>
       		처리 내용
       		<textarea rows="3" class="form-control" name="takeConetntInput" id="takeContentInput"></textarea>
       	</div>
        <div class="text-center mt-3">
        	<button type="button" class="btn border" onclick="reportTakeSave()">저장</button>
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