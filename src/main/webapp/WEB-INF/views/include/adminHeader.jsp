<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
	<script>
		'use Strict';
		
		function ruleUpdateFormPost(){
			ruleUpdateForm.submit();
		};
		
		function adminReportFormPost(){
			adminReportForm.submit();
		};
		
		function adminAskFormPost(){
			adminAskForm.submit();
		};
		
		function adminBanListFormPost(){
			adminBanListForm.submit();
		};
	</script>
<div class="row mt-4">
	<div class="col-12 text-center">
		<span class="mainfont-b-22">관리자 페이지</span>
	</div>
	<div class="col-12 text-center mainfont-b-18">
		<a href="javascript:ruleUpdateFormPost()">사이트관리</a> | 
		<a href="javascript:adminReportFormPost()">신고관리</a> | 
		<a href="javascript:adminAskFormPost()">문의관리</a> | 
		<a href="javascript:adminBanListFormPost()">제재유저관리</a> | 
		<a href="${ctp}/admin/adminBoardList">게시글관리</a>
		<form name="ruleUpdateForm" method="post" action="${ctp}/admin/ruleUpdateForm" style="display:none"></form>
		<form name="adminReportForm" method="post" action="${ctp}/admin/adminReportForm" style="display:none"></form>
		<form name="adminAskForm" method="post" action="${ctp}/admin/adminAskForm" style="display:none"></form>
		<form name="adminBanListForm" method="post" action="${ctp}/admin/adminBanListForm" style="display:none"></form>
	</div>
</div>