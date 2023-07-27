<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 관리</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
	'use strict'
	
	function boardRestore(boa_idx){
		let ans =confirm("정말로 복구하시겠습니까?");
		if(!ans){
			return false;
		}
		
		$.ajax({
			type: "post",
			data:{boa_idx:boa_idx},
			url:"${ctp}/admin/boardRestore",
			success:function(){
				alert("게시글이 복구되었습니다.");
				location.reload();
			},
			error:function(){
				alert("전송오류가 발생하였습니다.같은 오류가 반복되면 관리자에게 연락해주십시오.");
			}
		})
	}
	
	function boardDelete(boa_idx){
		let ans =confirm("정말로 삭제하시겠습니까?");
		if(!ans){
			return false;
		}
		
		$.ajax({
			type: "post",
			data:{boa_idx:boa_idx},
			url:"${ctp}/admin/boardDelete",
			success:function(){
				alert("게시글이 삭제되었습니다.");
				location.reload();
			},
			error:function(){
				alert("전송오류가 발생하였습니다.같은 오류가 반복되면 관리자에게 연락해주십시오.");
			}
		})
	}
	
	function dataBaseDelete(boa_idx){
		let ans =confirm("정말로 제거하시겠습니까?");
		if(!ans){
			return false;
		}
		else{
			let ans =confirm("제거하시면 게시판에서 완전히 지워집니다.\n복구할 수 없습니다! 정말로 제거하시겠습니까?");
			
			if(!ans){
				return false;
			}
			
			
				$.ajax({
					type: "post",
					data:{boa_idx:boa_idx},
					url:"${ctp}/admin/dateBaseDelete",
					success:function(){
						alert("게시글이 완전히 제거되었습니다.");
						location.reload();
					},
					error:function(){
						alert("전송오류가 발생하였습니다.같은 오류가 반복되면 관리자에게 연락해주십시오.");
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
	<div class="mainTitle">게시글 관리 : 전체 게시판</div>
	<hr>
	<div class="row">
		<div class="col-sm-2 text-center"><!-- 사이드바 영역 -->
			<a href="${ctp}/admin/boardDeleteList" class="subTitle-dot">
			<c:if test="${delSw == 'ok'}">
			삭제글 관리
			</c:if>
			<c:if test="${delSw != 'ok'}">
			<span class="inactive">
			삭제글 관리
			</span>
			</c:if>
			</a>
			<hr>
		</div><!-- 사이드바 영역 끝 -->
		<div class="col-sm-10"><!-- 본문 리스트 영역 -->
			<div class="row text-center mainfont-m-16">
				<div class="col-1">분류</div>
				<div class="col-2">작성자</div>
				<div class="col-4">제목</div>
				<div class="col-1">조회수</div>
				<div class="col-1">추천수</div>
				<div class="col-2">작성일</div>
				<div class="col-1">비고</div>
				<div class="col-12"><hr/></div>
			</div>
			<div class="row text-center">
				<c:forEach var="boardList_vo" items="${boardVOS}" varStatus="st">
					<div class="col-1">${boardList_vo.categoryName}</div>
					<div class="col-2">${boardList_vo.nickName}</div>
					<div class="col-4">
						<c:if test="${boardList_vo.ddate == null}">
						<a href="${ctp}/board/read/${boardList_vo.boa_idx}/${boardList_vo.category}">${boardList_vo.title}</a>
						</c:if>
						<c:if test="${boardList_vo.ddate != null}">
						<span class="mainfont-b-16 inactive">
						<a href="${ctp}/board/read/${boardList_vo.boa_idx}/${boardList_vo.category}">(삭제글)${boardList_vo.title}</a>
						</span>
						</c:if>
					</div>
					<div class="col-1">${boardList_vo.viewCnt}</div>
					<div class="col-1">${boardList_vo.recommendCnt}</div>
					<div class="col-2">${fn:substring(boardList_vo.wdate,0,10)}</div>
					<div class="col-1">
					<c:if test="${boardList_vo.deleteCnt le 14 && boardList_vo.ddate != null}">
						<a href="javascript:boardRestore('${boardList_vo.boa_idx}')">복구</a>
					</c:if>
					<c:if test="${boardList_vo.deleteCnt>14}">
						<a href="javascript:dataBaseDelete('${boardList_vo.boa_idx}')">제거</a>
						<br>
						<a href="javascript:boardRestore('${boardList_vo.boa_idx}')">복구</a>
					</c:if>
					<c:if test="${boardList_vo.deleteCnt==0 && boardList_vo.ddate == null}">
						<a href="javascript:boardDelete('${boardList_vo.boa_idx}')">삭제</a>
					</c:if>
					</div>
					<div class="col-12"><hr/></div>
				</c:forEach>
			</div>
			<form name="boardSearchForm" method="get" action="${ctp}/board/list/${category}/search">
			<div class="row"><!-- 검색창 영역 -->
			<div class="col-3"></div> 
				<div class="col-1 m-0 p-0">
				  <select class="form-control" name="searchOption" id="searchOption">
				    <option value="title">제목</option>
				    <option value="content">내용</option>
				    <option value="nickName">닉네임</option>
				    <option value="mid">아이디</option>
				  </select>
				</div>
				<div class="col-5 m-0 p-0">
					<div class="input-group mb-3">
          	<input type="text" name="searchStr" class="form-control">
            <div class="input-group-append">
               <button type="button" onclick="boardSearch()" class="input-group-text" class="btn btn-border">검색</button>
            </div>
        	</div>
				</div>
				<div class="col-3"></div>
			</div><!-- 검색창 영역끝 -->
			</form>
			<div class="row">
				<div class="col-12">
				<ul class="pagination text-center justify-content-center border-secondary">	
					<c:if test="${pageVO.nowPage>1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/listAll?pageSize=${pageVO.pageSize}&nowPage=1">첫페이지</a></li></c:if>
					<c:if test="${pageVO.curBlock>0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/listAll?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock-1)*pageVO.blockSize+1}">이전블록</a></li></c:if>
					<c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize+1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
						<c:if test="${i<=pageVO.totalPage && i== pageVO.nowPage}"><li class="page-item active bg-secondary"><a class="page-link bg-secondary" href="#">${i}</a></li></c:if>
						<c:if test="${i<=pageVO.totalPage && i!= pageVO.nowPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/listAll?pageSize=${pageVO.pageSize}&nowPage=${i}">${i}</a></li></c:if>
					</c:forEach>
					<c:if test="${pageVO.curBlock<pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/listAll?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock+1)*pageVO.blockSize+1}">다음블록</a></li></c:if>
					<c:if test="${pageVO.nowPage<pageVO.totalPage}"><li class="page-item"><a class="page-link  text-secondary" href="${ctp}/board/listAll?pageSize=${pageVO.pageSize}&nowPage=${pageVO.totalPage}">마지막페이지</a></li></c:if>
				</ul>
				</div>
			</div>
		</div><!-- 본문 리스트 영역 -->
	</div>


</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>