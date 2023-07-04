<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석하기</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<style>
	.attendanceListContainer{
		width:760px;
		min-height:520px;
		height: 100%;
		margin: 0 auto;
	}
	</style>
	<script>
	"use strict"
	window.onload = function(){
		let today = new Date();
		let year = today.getFullYear();
		let month = today.getMonth()+1;
		let date = today.getDate();
		
		let fullDate = "오늘은 "+ year+"년 "+month+"월 "+date+"일입니다.";
		
		$("#dateOutput").html(fullDate);
	}
	
	function attendanceWrite(){
		let content = $("#content").val();
		let hostIp = $("#hostIp").val();
		
		
		if(content.trim()==""){
			alert("한마디의 내용을 작성해 주세요.");
			$("#content").focus();
			return false;
		}
		
		$.ajax({
			type:"post",
			data:{content:content,hostIp:hostIp},
			url:"${ctp}/attendance/write",
			success:function(res){
				if(res=='1'){
					alert("오늘 출석 한마디를 작성하였습니다. 보너스 포인트가 적립되었으니 확인해주세요!");
					location.reload();
				}
				else if(res=='2'){
					alert("오늘은 이미 출석 한마디를 작성하셨습니다. 내일 방문하셔서 또 작성해 주세요")
					return false;
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 연락해주세요.");
			}
		})
	}
	
	function changeModalOpen(att_content,att_idx,att_wdate){
		console.log(att_content);
		console.log(att_idx);
		console.log(att_wdate);
		
		let updateDateStr = '<span>'+att_wdate+' 내용</span>';
		
		
		$("#updateDate").html(updateDateStr);
		$("#updateContent").val(att_content);
		$("#updateAtt_idx").val(att_idx);
		$("#attendUpdateModal").modal();
		//모달 열기
	}
	
	function attendanceUpdateCheck(){
		let att_idx = $("#updateAtt_idx").val();
		let content = $("#updateContent").val();
		
		if(content.trim() ==""){
			alert("수정할 내용을 입력해 주세요.");
			$("#updateContent").focus();
			return false;
		}
		
		
		$.ajax({
			type:"post",
			data:{att_idx:att_idx,content:content},
			url:"${ctp}/attendance/update",
			success:function(res){
				if(res==0){
					alert("오류가 발생하였습니다. 잠시 후 다시 시도해 주십시오.");
				}
				else{
					alert("정상적으로 수정되었습니다.");
					location.reload();
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 연락해주세요.");
			}
		})
		
	}
	
	function attendanceDeleteCheck(){
		let att_idx = $("#updateAtt_idx").val();
		
		let ans = confirm("정말로 지우시겠습니까?");
		if(!ans) return false;		
		
		$.ajax({
			type:"post",
			data:{att_idx:att_idx},
			url:"${ctp}/attendance/delete",
			success:function(res){
				if(res==0){
					alert("오류가 발생하였습니다. 잠시 후 다시 시도해 주십시오.");
				}
				else{
					alert("정상적으로 삭제되었습니다.");
					location.reload();
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 연락해주세요.");
			}
		})
		
	}
	
	function attendanceRestoreOpen(att_idx){
		let ans = confirm("선택하신 출석글을 복구하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			type:"post",
			data:{att_idx:att_idx},
			url:"${ctp}/attendance/restore",
			success:function(res){
				if(res==0){
					alert("오류가 발생하였습니다. 잠시 후 다시 시도해 주십시오.");
				}
				else{
					alert("정상적으로 복구되었습니다.");
					location.reload();
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 연락해주세요.");
			}
		})
	}
	
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
	<div class="container">
		<div class="row text-center mainfont-b-20" style="margin-top:3%">
			<div class="col-12 mainTitle-dot text-left">오늘의 출석</div>
			<div class="col-12 subTitle-dot text-left">
				<div style="width:max-content;">
				<span name="dateOutput" id="dateOutput"></span>
				<hr/>
				</div>
			</div>
			
		</div>
		<div class="attendanceListContainer text-center">	
		<form name="attendanceWriteForm" method="post">
		<div class="row text-center mainfont-b-20">
			<div class="col-3">
				<c:if test="${sLogin != 'ok'}" >
					<span class="mainfont-b-20-inactive">로그인하세요!</span>
				</c:if>
				<c:if test="${sLogin == 'ok'}">
					<span class="mainfont-b-18">${sNickName}</span>
				</c:if>
			</div>
			<div class="col-6">
				<input type="text" name="content" id="content" placeholder="한마디 적어주세요"  class="form-control"/>
				<input type="hidden" name="hostIp" id="hostIp" value="${pageContext.request.remoteAddr}">
			</div>
			<div class="col-3">
				<c:if test="${sLogin != 'ok'}" >
					<button type="button" class="form-control"><span class="mainfont-b-16-inactive" onclick="location.href='${ctp}/member/login?from=attendanceList'">로그인하러가기</span></button>
				</c:if>
				<c:if test="${sLogin == 'ok'}">
					<button type="button" class="form-control" onclick="attendanceWrite()"><span class="mainfont-b-16">출석!</span></button>
				</c:if>	
			</div>
		</div>	
		</form>
		<div class="row text-center mainfont-b-20">
			<div class="col-12"><hr/></div>
			<div class="col-3">작성자</div>
			<div class="col-6">내용</div>
			<div class="col-3">작성일자</div>
			<div class="col-12"><hr/></div>
		</div>
		<div class="row text-center mainfont-b-18">
			<c:forEach var="att_vo" items="${att_vos}" varStatus="st">
				<div class="col-3">${att_vo.nickName}</div>
				<div class="col-6">
					<c:if test="${att_vo.nickName == sNickName &&empty att_vo.ddate}">
							<a href="javascript:changeModalOpen('${att_vo.content}','${att_vo.att_idx}','${fn:substring(att_vo.wdate,0,10)}')">${att_vo.content}</a>
					</c:if>
					<c:if test="${att_vo.nickName != sNickName && empty att_vo.ddate}">
						${att_vo.content}
					</c:if>
					<c:if test="${att_vo.nickName == sNickName && not empty att_vo.ddate}">
						<span class="mainfont-b-18-inactive"><a href="javascript:attendanceRestoreOpen('${att_vo.att_idx}')">${att_vo.content}</a></span>
					</c:if>
					<c:if test="${att_vo.nickName != sNickName && not empty att_vo.ddate}">
						<span class="mainfont-b-18-inactive">${att_vo.content}</span>
					</c:if>
				</div>
				<div class="col-3">
					<c:if test="${empty att_vo.ddate}">
						${fn:substring(att_vo.wdate,0,10)}
					</c:if>
					<c:if test="${not empty att_vo.ddate}">
						<span class="mainfont-b-18-inactive">${fn:substring(att_vo.ddate,0,10)}</span>
					</c:if>
				</div>
				<div class="col-12"><hr/></div>
			</c:forEach>
			<div class="col-12">
				
			</div>
		</div>
		</div>
		<div style="width:760px; margin: 0 auto;">
			<hr/>
			<ul class="pagination text-center justify-content-center border-secondary">	
				<c:if test="${pageVO.nowPage>1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/attendance/list?pageSize=${pageVO.pageSize}&nowPage=1">첫페이지</a></li></c:if>
				<c:if test="${pageVO.curBlock>0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/attendance/list?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock-1)*pageVO.blockSize+1}">이전블록</a></li></c:if>
				<c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize+1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
					<c:if test="${i<=pageVO.totalPage && i== pageVO.nowPage}"><li class="page-item active bg-secondary"><a class="page-link bg-secondary" href="#">${i}</a></li></c:if>
					<c:if test="${i<=pageVO.totalPage && i!= pageVO.nowPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/attendance/list?pageSize=${pageVO.pageSize}&nowPage=${i}">${i}</a></li></c:if>
				</c:forEach>
				<c:if test="${pageVO.curBlock<pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/attendance/list?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock+1)*pageVO.blockSize+1}">다음블록</a></li></c:if>
				<c:if test="${pageVO.nowPage<pageVO.totalPage}"><li class="page-item"><a class="page-link  text-secondary" href="${ctp}/attendance/list?pageSize=${pageVO.pageSize}&nowPage=${pageVO.totalPage}">마지막페이지</a></li></c:if>
			</ul>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	<!-- The Modal -->
  <div class="modal fade" id="attendUpdateModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">출석 한마디 수정하기</h4>
          <button type="button" class="close" data-dismiss="modal">×</button>
        </div>
        <!-- Modal body -->
        <div class="modal-body">
          <div class="fontdot-20 mt-3" name="updateDate" id="updateDate" ></div>
          <input type="text" name="updateContent" id="updateContent" value="" class="form-control">
          <input type="hidden" namer="updateAtt_idx" id="updateAtt_idx" value="">
          <div class="text-right mt-3">
          	<button type="button" class="btn border" onclick="attendanceUpdateCheck()">수정하기</button>
          	<button type="button" class="btn border" onclick="attendanceDeleteCheck()">삭제하기</button>
          </div>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>
</body>
</html>