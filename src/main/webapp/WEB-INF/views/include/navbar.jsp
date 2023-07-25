<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<style>
/* Style The Dropdown Button */
.dropbtn {
  background-color: #4CAF50;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
  position: relative;
  display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {background-color: #f1f1f1}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
  display: block;
}

/* Change the background color of the dropdown button when the dropdown content is shown */
.dropdown:hover .dropbtn {
  background-color: #3e8e41;
}
</style>
<script>
	function adminHomePost(){
		adminHome.submit();
	}
</script>


<nav class="navbar navbar-expand-sm bg-dark navbar-dark M-0 P-0">
	<a class="navbar-brand" href="${ctp}/" style="margin-left: 10px"><span class="navTitle">메인으로</span></a>
<ul class="navbar-nav">
	<li>
		<a class="nav-link" href="${ctp}/attendance/list">attendance</a>
	</li>
</ul>
<div class="dropdown">
  <button class="dropbtn">News</button>
  <div class="dropdown-content">
    <a href="${ctp}/board/news/2">새 소식</a>
    <a href="${ctp}/board/news/1">공지사항</a>
  </div>
</div>	
<div class="dropdown">
  <button class="dropbtn">Board</button>
  <div class="dropdown-content">
    <a href="${ctp}/board/list/all">게시판 전부보기</a>
  <c:forEach var="nav_vo" items="${nav_vos}" varStatus="st">
  	<a href="${ctp}/board/list/${nav_vo.category}">${nav_vo.name} 게시판</a>
  </c:forEach>

  </div>
</div>
<ul class="navbar-nav">
  <li class="nav-item">
    <a class="nav-link" href="${ctp}/gether/home">gether</a>
  </li>
  <c:if test="${sLogin =='ok'}">
  <li class="nav-item">
    <a class="nav-link" href="${ctp}/member/myPage">마이페이지</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="${ctp}/member/logout">로그아웃</a>
  </li>
  <c:if test="${sLevel<2}">
	  <li class="nav-item">
		    <a class="nav-link" href="javascript:adminHomePost()">관리자 페이지</a>
	  </li>
  </c:if>
  </c:if>
</ul>
</nav>
<form name="adminHome" method="post" action="${ctp}/admin/home" style="display:none"></form>