<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script>
		"use strict";
		document.title = '${category_Name} 목록';
		
		function newsSearch(){
			let searchStr = newsSearchForm.searchStr.value;
			
			if(searchStr.trim()==""){
				alert("검색할 단어를 입력해 주세요.");
				return false;
			}
			 newsSearchForm.submit();
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
	<div class="mainTitle" style="margin-top: 3%">게시판</div>
	<div class="row">
		<div class="col-6">
			<div class="mainTitle">${category_Name}</div>
		</div>
		<div class="col-6 text-right">
			<c:if test="${sLevel<4}">
				<form method="post" action="${ctp}/board/write/${category}">
				<button type="submit" class="btn border" ><span class="material-symbols-outlined write-icon">edit_notifications</span><span class="mainfont-b-18">글 작성</span></button>
				</form>
			</c:if>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-2 text-center"><!-- 사이드바 영역 -->
			<c:forEach var="category_vo" items="${nav_vos}" varStatus="st">
				<a href="${ctp}/board/list/${category_vo.category}" class="subTitle-dot">
					<c:if test="${category==category_vo.category}">${category_vo.name}</c:if>
					<c:if test="${category!=category_vo.category}"><span class="inactive">${category_vo.name}</span></c:if>
					<hr/>
				</a>
			</c:forEach>
		</div><!-- 사이드바 영역 끝 -->
		<div class="col-sm-10"><!-- 본문 리스트 영역 -->
			<div class="row text-center mainfont-m-16">
				<div class="col-2">작성자</div>
				<div class="col-6">제목</div>
				<div class="col-1">조회수</div>
				<div class="col-1">추천수</div>
				<div class="col-2">작성일</div>
				<div class="col-12"><hr/></div>
			</div>
			<div class="row text-center">
				<c:forEach var="boardList_vo" items="${boardList_vos}" varStatus="st">
					<div class="col-2">${boardList_vo.nickName}</div>
					<div class="col-6">
						<c:if test="${boardList_vo.ddate == null}">
						<a href="${ctp}/board/read/${boardList_vo.boa_idx}/${category}">${boardList_vo.title}</a>
						</c:if>
						<c:if test="${boardList_vo.ddate != null}">
						<span class="mainfont-b-16 inactive">삭제된 글입니다</span>
						</c:if>
					</div>
					<div class="col-1">${boardList_vo.viewCnt}</div>
					<div class="col-1">${boardList_vo.recommendCnt}</div>
					<div class="col-2">${fn:substring(boardList_vo.wdate,0,10)}</div>
					<div class="col-12"><hr/></div>
				</c:forEach>
			</div>
			<form name="newsSearchForm" method="get" action="${ctp}/board/list/${category}/search">
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
               <button type="button" onclick="newsSearch()" class="input-group-text" class="btn btn-border">검색</button>
            </div>
        	</div>
				</div>
				<div class="col-3"></div>
			</div><!-- 검색창 영역끝 -->
			</form>
			<div class="row">
				<div class="col-12">
				<ul class="pagination text-center justify-content-center border-secondary">	
					<c:if test="${pageVO.nowPage>1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/list/${category}?pageSize=${pageVO.pageSize}&nowPage=1">첫페이지</a></li></c:if>
					<c:if test="${pageVO.curBlock>0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/list/${category}?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock-1)*pageVO.blockSize+1}">이전블록</a></li></c:if>
					<c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize+1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
						<c:if test="${i<=pageVO.totalPage && i== pageVO.nowPage}"><li class="page-item active bg-secondary"><a class="page-link bg-secondary" href="#">${i}</a></li></c:if>
						<c:if test="${i<=pageVO.totalPage && i!= pageVO.nowPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/list/${category}?pageSize=${pageVO.pageSize}&nowPage=${i}">${i}</a></li></c:if>
					</c:forEach>
					<c:if test="${pageVO.curBlock<pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/list/${category}?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock+1)*pageVO.blockSize+1}">다음블록</a></li></c:if>
					<c:if test="${pageVO.nowPage<pageVO.totalPage}"><li class="page-item"><a class="page-link  text-secondary" href="${ctp}/board/list/${category}?pageSize=${pageVO.pageSize}&nowPage=${pageVO.totalPage}">마지막페이지</a></li></c:if>
				</ul>
				</div>
			</div>
		</div><!-- 본문 리스트 영역 -->
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>