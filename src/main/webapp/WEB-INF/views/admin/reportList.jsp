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
					$("#reportDetailModal").modal();
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 현상이 반복되면 관리자에게 문의하여 주십시오.");
				}
			})
			
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
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
			<select>
				<option value="all">전체조회</option>
				<c:forEach var="repcVO" items="${repcVOS}" varStatus="st">
					<option value="${repcVO.rep_category}">${repcVO.name}(${repcVO.tableName})</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-1  align-self-center">
			<button type="button" class="btn border">조회</button>
		</div>
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
       	</div>
       	<div class="deleteOutput">
       		신고 대상 처리
       		<select>
       			<option>선택</option>
       			<option>삭제</option>
       		</select>
       	</div>
       	<div>
       		제재 종류
       		<select>
       			<option value="">댓글 금지</option>
       			<option value="">글 작성 금지</option>
       			<option value="">임시 정지</option>
       			<option value="">영구 정지</option>
       		</select>
       		해제일 <input type="date" name="penaltyTime" id="penaltyTime">
       	</div>
       	<div>
       		처리경과
	       	<select>
	       		<option value="">처리전</option>
	       		<option value="">처리중</option>
	       		<option value="">처리완료</option>
	       	</select>
       	</div>
       	<div>
       		처리 내용
       		<textarea rows="3" class="form-control"></textarea>
       	</div>
        <div class="text-center mt-3">
        	<button type="button" class="btn border">저장</button>
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