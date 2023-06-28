<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<style>
	nav {
	  margin:0 auto;
	  width:100%;
	  height:70px;
	  display:inline-block;
	  background:#37bc9b;
	}
	
	nav ul {
	  margin:0;padding:0;
	  list-style-type:none;
	  float:left;
	  display:inline-block;
	}
	
	nav ul li {
	  position:relative;
	  margin:0 20px 0 0;
	  float:left;
	  display:inline-block;
	}
	
	li > a:after {  } /* Change this in order to change the Dropdown symbol */
	
	li > a:only-child:after { content: ''; }
	
	nav ul li a {
	  padding:20px;
	  display:inline-block;
	  color:white;
	  text-decoration:none;
	}
	
	nav ul li a:hover {
	  opacity:0.5;
	}
	
	nav ul li ul {
	  display:none;
	  position:absolute;
	  left:0;
	  background:#848484;
	  float:left;
	}
	
	nav ul li ul li {
	  width:100%;
	  border-bottom:1px solid rgba(255,255,255,.3);
	}
	
	nav ul li:hover ul {
	  display:block;
	}
	.navTitle{
		width: 150px;
	}
</style>



<nav class="navbar navbar-expand-sm bg-dark navbar-dark M-0 P-0">
	<a class="navbar-brand" href="${ctp}/" style="margin-left: 10px"><span class="navTitle">메인으로</span></a>
	  <ul>	
    <li class="navTitle text-center"><a href="#">News</a>
      <ul>
        <li class="navSubject"><a href="#">새 소식</a></li>
        <li class="navSubject"><a href="#">공지사항</a></li>
      </ul>
    </li>
    <li class="navTitle text-center"><a href="#">Board</a>
      <ul>
        <li class="navSubject"><a href="#">전체게시판</a></li>
        <li class="navSubject"><a href="#">잡담게시판</a></li>
        <li class="navSubject"><a href="#">정보게시판</a></li>
        <li class="navSubject"><a href="#">질문게시판</a></li>
      </ul>
    </li>
    <li class="navTitle"><a href="#">갤러리</a></li>
	<c:if test="${sLogin =='ok'}">
	<li class="navTitle text-center"><a href="${ctp}/member/myPage">마이페이지</a></li>
	<li class="navTitle text-center"><a href="${ctp}/member/logout">로그아웃</a></li>
	</c:if>
  </ul>	
</nav>