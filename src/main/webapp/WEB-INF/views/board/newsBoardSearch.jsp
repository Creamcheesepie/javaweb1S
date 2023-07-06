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
	<div class="mainTitle" style="margin-top: 3%">News</div>
	<div class="row">
		<div class="col-6">
			<div class="mainTitle">${category_Name}&nbsp;-&nbsp;${searchOption}&nbsp;:&nbsp;${searchStr}&nbsp;검색결과</div>
		</div>
		<div class="col-6 text-right">
			<c:if test="${sLevel<2}">
				<form method="post" action="${ctp}/board/newsWrite/${category}">
				<button type="submit" class="btn border" ><span class="material-symbols-outlined write-icon">edit_notifications</span><span class="mainfont-b-18">글 작성</span></button>
				</form>
			</c:if>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-2 text-center"><!-- 사이드바 영역 -->
			<a href="${ctp}/board/news/2" class="subTitle-dot">
				<c:if test="${category==2}">새 소식</c:if>
				<c:if test="${category!=2}"><span class="inactive">새 소식</span></c:if>
			</a>
			<hr/>
			<a href="${ctp}/board/news/1" class="subTitle-dot">
				<c:if test="${category==1}">공지사항</c:if>
				<c:if test="${category!=1}"><span class="inactive">공지사항</span></c:if>
			</a>
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
				<c:forEach var="newsList_vo" items="${newsList_vos}" varStatus="st">
					<div class="col-2">${newsList_vo.nickName}</div>
					<div class="col-6">
						<a href="${ctp}/board/newsRead/${newsList_vo.boa_idx}/${category}">${newsList_vo.title}</a>
					</div>
					<div class="col-1">${newsList_vo.viewCnt}</div>
					<div class="col-1">${newsList_vo.recommendCnt}</div>
					<div class="col-2">${fn:substring(newsList_vo.wdate,0,10)}</div>
					<div class="col-12"><hr/></div>
				</c:forEach>
			</div>
			<form name="newsSearchForm" method="get" action="${ctp}/board/news/${category}/search">
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
					<c:if test="${pageVO.nowPage>1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/news/${category}/search?pageSize=${pageVO.pageSize}&nowPage=1">첫페이지</a></li></c:if>
					<c:if test="${pageVO.curBlock>0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/news/${category}/search?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock-1)*pageVO.blockSize+1}">이전블록</a></li></c:if>
					<c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize+1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
						<c:if test="${i<=pageVO.totalPage && i== pageVO.nowPage}"><li class="page-item active bg-secondary"><a class="page-link bg-secondary" href="#">${i}</a></li></c:if>
						<c:if test="${i<=pageVO.totalPage && i!= pageVO.nowPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/news/${category}/search?pageSize=${pageVO.pageSize}&nowPage=${i}">${i}</a></li></c:if>
					</c:forEach>
					<c:if test="${pageVO.curBlock<pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/news/${category}/search?pageSize=${pageVO.pageSize}&nowPage=${(pageVO.curBlock+1)*pageVO.blockSize+1}">다음블록</a></li></c:if>
					<c:if test="${pageVO.nowPage<pageVO.totalPage}"><li class="page-item"><a class="page-link  text-secondary" href="${ctp}/board/news/${category}/search?pageSize=${pageVO.pageSize}&nowPage=${pageVO.totalPage}">마지막페이지</a></li></c:if>
				</ul>
				</div>
			</div>
		</div><!-- 본문 리스트 영역 -->
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>