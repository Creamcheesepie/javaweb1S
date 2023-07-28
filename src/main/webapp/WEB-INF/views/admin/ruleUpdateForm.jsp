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
	'use strict';
	
	function pointChange(part,count){
		let point = $("#point"+count).val();
		let c_reason = $("#point_c_reason"+count).val();
		
		$.ajax({
			type:'post',
			data:{part:part,point:point,c_reason:c_reason},
			url:"${ctp}/admin/pointChangeOk",
			success:function(res){
				if(res==1){
					alert("성공적으로 포인트가 수정되었습니다.");
				}
				else{
					alert("오류가 발생하여 포인트가 수정되지 않았습니다. 같은 현상이 반복되면 관리자에게 연락해주세요.")
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자에게 연락해주세요.");
			}
		})
		
	}
	
	function categoryInputCheck(){
		let ans = confirm("정말로 추가하시겠습니까? 많은 게시판의 난립은 사용자에게 혼란을 줄 수 있으니 신중하게 추가하여 주십시오.");
		if(!ans)return false;
		
		let categoryName = $("#categoryNameInput").val();
		
		$.ajax({
			type:"post",
			url:"${ctp}/admin/categoryInput",
			data:{categoryName:categoryName},
			success:function(res){
				if(res==1){
					alert("카테고리 추가에 성공하였습니다.");
					location.reload();
				}
				else{
					alert("오류가 발생하여 카테고리 추가에 실패하였습니다.");
				}
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 현상이 반복된다면 관리자에게 연락해주십시오.")
			}
		})
	}
	
	function categoryChangeName(category,st){
		let name = $("#categoryNameUpdate"+st).val();
		
		$.ajax({
			type:"post",
			data:{category:category,name:name},
			url:"${ctp}/admin/categoryUpdate",
			success:function(){
				alert("카테고리를 수정하였습니다.");
				location.reload();
			},
			error:function(){
				alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자에게 연락해주세요.");
			}
		})
		
	}
	
	function BoardlimitDataChange(){
		let rule_idx = '2';
		let limitHour = $("#Board_autoLimitHour").val();
		limitHour = limitHour.padStart(2,'0');
		
		let limitMinute = $("#Board_autoLimitMinute").val();
		limitMinute = limitMinute.padStart(2,'0');
		
		let strLimitTime = "0000-00-00 "+limitHour+":"+limitMinute+":00";
		let actionLimit = $("#Board_autoLimitCount").val();
		
		let ans = confirm("게시글 작성 제한 설정을 바꿉니다.\n"+limitHour+"시간 "+limitMinute+"분 안에 "+actionLimit+"회 이상 게시글 작성시\n제재시간 동안 글을 작성하지 못합니다.");
		if(!ans)return false
		else{
			$.ajax({
				type:"post",
				data:{strLimitTime:strLimitTime,actionLimit:actionLimit,rule_idx:rule_idx},
				url:"${ctp}/admin/autoLimitChange",
				success:function(){
					alert("성공적으로 조건을 바꾸었습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자에게 연락해주십시오.");
				}
			})
		}
	}
	
	function boardPenaltyDataChange(){
		let rule_idx = '2';
		let limitHour = $("#Board_autoPenaltyHour").val();
		limitHour = limitHour.padStart(2,'0');
		
		let limitMinute = $("#Board_autoPenaltyMinute").val();
		limitMinute = limitMinute.padStart(2,'0');
		
		let strPenaltyTime = "0000-00-00 "+limitHour+":"+limitMinute+":00";
		
		let ans = confirm("게시글 제재 설정을 바꿉니다.\n"+limitHour+"시간 "+limitMinute+"분 동안 글을 작성하지 못합니다.");
		if(!ans)return false
		else{
			$.ajax({
				type:"post",
				data:{strPenaltyTime:strPenaltyTime,rule_idx:rule_idx},
				url:"${ctp}/admin/autoPenaltyChange",
				success:function(){
					alert("성공적으로 조건을 바꾸었습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복된다면 관리자에게 연락해주십시오.");
				}
			})
		}
		
	}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>
<div class="mainTitle">사이트 관리<hr></div>
<div class="subTitle">포인트 관리</div>
<div class="mainfont-b-16">사이트 활동시 부여되는 포인트를 관리합니다.<hr></div>
<div class="row">
	<c:forEach var="point_vo" items="${point_vos}" varStatus="st">
		<div class="col-2">
		<span class="mainfont-b-16">${point_vo.name}</span><br>
		<span class="mainfont-m-14"  >변경사유</span>
		<textarea rows="3" class="form-control" name="point_c_reason${st.count}" id="point_c_reason${st.count}" placeholder="변경하는 이유를 적어주세요.">${point_vo.c_reason}</textarea>
		<c:if test="${!empty point_vo.cdate}">
		<span class="mainfont-m-14">최종 변경일자<br>${fn:substring(point_vo.cdate,0,10)}</span>
		</c:if>
		<div class="input-group">
			<input name="point${st.count}" id="point${st.count}" type="number" value="${point_vo.point}" class="form-control">
			<div class="input-group-append">
				<button type="button" onclick="pointChange('${point_vo.part}','${st.count}')" class="btn border">변경하기</button>
			</div>
		</div>
	</div>
	</c:forEach>
</div>
<hr>
<div class="subTitle">게시판 카테고리 관리</div>
<div class="mainfont-b-16">현재 커뮤니티에 존재하는 게시판 카테고리를 관리합니다. 카테고리는 최대 100개까지 추가가 가능합니다. 사용자를 고려해 신중히 게시판 카테고리를 수정/추가해 주십시오.<hr></div>
<div class="row">
	<div class="col-12 mainfont-b-16">카테고리 추가</div>
	<div class="col-4 mb-2">
		<div class="input-group">
			<input type="text" name="categoryNameInput" id="categoryNameInput" class="form-control">
			<div class="input-group-append">
				<button type="button" class="btn border" onclick="categoryInputCheck()">추가하기</button> 
			</div>
		</div>
	</div>
	<div class="col-12 p0 m0"></div>
	<div class="col-12 mainfont-b-16">기존 카테고리 변경</div>
	<c:forEach var="category_vo" items="${category_vos}" varStatus="st">
	<div class="col-2">
		${category_vo.name}
		<div class="input-group">
			<input type="text" name="categoryNameUpdate${st.count}" id="categoryNameUpdate${st.count}" value="${category_vo.name}" class="form-control">
			<div class="input-group-append">
				<button type="button" class="btn border" onclick="categoryChangeName('${category_vo.category}','${st.count}')">변경하기</button> 
			</div>
		</div>
		<div class="mt-2 mb-2">대표이미지 등록</div>
		<form action="${ctp}/admin/MainImageUpload/${st.index}" method="post" enctype="multipart/form-data">
		<input type="file" name="fName" id="fName" class="form-control-file border">
		<button type="submit" class="btn border mt-2">등록</button>
		</form>
	</div>
	</c:forEach>
</div>
<hr>
<div class="subTitle">도배방지 기능 관리</div>
<div class="mainfont-b-16">특정 시간내에 몇 회 이상 글과 댓글을 올릴시 자동으로 제재되는 기능의 시간과 횟수를 설정합니다.</div>
<hr>
<div class="row">
	<div class="col-2">
	<div class="mainfont-b-16">게시글 제한 시간</div>
	<div class="row">
		<div class="col-5 mr-0 pr-0">
			<input type="number" class="form-control" max="24" min="0" name="Board_autoLimitHour" id="Board_autoLimitHour" value="${boardRuleInfo[0]}">
		</div>
		<div class="col-1 align-self-center text-center">:</div>
		<div class="col-5 ml-0 pl-0">
			<input type="number" class="form-control" max="60" min="0" name="Board_autoLimitMinute" id="Board_autoLimitMinute" value="${boardRuleInfo[1]}">
		</div>
	</div>
	</div>
	<div class="col-2">
		<div class="mainfont-b-16">제한횟수</div>
		<div class="row">
			<div class="col-5 mr-0 pr-0">
				<input type="number" class="form-control" max="999" min="0" name="Board_autoLimitCount" id="Board_autoLimitCount" value="${boardRuleInfo[4]}">
			</div>
			<div class="col-1 align-self-center text-center">회</div>
			<div class="col-5 mr-0 pr-0">
				<button type="button" class="btn border form-control" onclick="BoardlimitDataChange()">변경</button>
			</div>
		</div>
	</div>
	<div class="col-1">&nbsp;</div>
	<div class="col-2">
		<div class="mainfont-b-16">댓글 제한 시간</div>
		<div class="row">
			<div class="col-5 mr-0 pr-0">
				<input type="number" class="form-control" max="24" min="0" name="reply_autoLimitHour"  value="${replyRuleInfo[0]}">
			</div>
			<div class="col-1 align-self-center text-center">:</div>
			<div class="col-5 ml-0 pl-0">
				<input type="number" class="form-control" max="60" min="0" name="reply_autoLimitMinute"  value="${replyRuleInfo[1]}">
			</div>
		</div>
	</div>
	<div class="col-2">
		<div class="mainfont-b-16">제한횟수</div>
		<div class="row">
			<div class="col-5 mr-0 pr-0">
				<input type="number" class="form-control" max="999" min="0" name="reply_autoLimitCount"  value="${replyRuleInfo[4]}">
			</div>
			<div class="col-1 align-self-center text-center">회</div>
			<div class="col-5 mr-0 pr-0">
				<button type="button" class="btn border form-control" onclick="limitDataChange('3')">변경</button>
			</div>
		</div>
	</div>
	<div class="col-12"></div>
	<div class="col-2">
		<div class="mainfont-b-16">게시글 제제 시간</div>
		<div class="row">
			<div class="col-5 mr-0 pr-0">
				<input type="number" class="form-control" max="24" min="0" name="Board_autoPenaltyHour" id="Board_autoPenaltyHour" value="${boardRuleInfo[2]}">
			</div>
			<div class="col-1 align-self-center text-center">:</div>
			<div class="col-5 ml-0 pl-0">
				<input type="number" class="form-control" max="60" min="0" name="Board_autoPenaltyMinute" id="Board_autoPenaltyMinute" value="${boardRuleInfo[3]}">
			</div>
		</div>
	</div>
	<div class="col-2">
		<div class="mainfont-b-16">&nbsp;</div>
		<div class="row">
			<div class="col-5 mr-0 pr-0">
				<button type="button" class="btn border form-control" onclick="boardPenaltyDataChange()">변경</button>
			</div>
		</div>
	</div>
	<div class="col-1"></div>
	<div class="col-2">
		<div class="mainfont-b-16">댓글 제제 시간</div>
		<div class="row">
			<div class="col-5 mr-0 pr-0">
				<input type="number" class="form-control" max="24" min="0" name="reply_autoPaneltyHour"  value="${replyRuleInfo[2]}">
			</div>
			<div class="col-1 align-self-center text-center">:</div>
			<div class="col-5 ml-0 pl-0">
				<input type="number" class="form-control" max="60" min="0" name="reply_autoPaneltyMinute"  value="${replyRuleInfo[3]}">
			</div>
		</div>
	</div>
	<div class="col-2">
		<div class="mainfont-b-16">&nbsp;</div>
		<div class="row">
			<div class="col-5 mr-0 pr-0">
				<button type="button" class="btn border form-control">변경</button>
			</div>
		</div>
	</div>
</div>
<hr>


</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>