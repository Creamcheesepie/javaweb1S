<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		document.title = '${newsRead_vo.title}';
		
		function recommendCheck(boa_idx){
			$.ajax({
				type:"post",
				data:{boa_idx:boa_idx},
				url:"${ctp}/board/recommendCheck",
				success:function(res){
					if(res==1){
						alert("게시글을 추천하였습니다.");
						location.reload();
						return false;
					}
					else if(res==2){
						alert("게시글 추천을 취소하였습니다.");
						location.reload();
						return false;
					}
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 문의해주세요.");
				}
			})
		}
		
		function replyUpdate(boa_idx,m_idx){
			let replyContent = $("#replyContent").val();
			
			if(replyContent.trim()==""){
				alert("댓글 내용을 입력해 주세요");
				$("#replyContent").focus();
				return false;
			}
			
			$.ajax({
				type:"post",
				data:{boa_idx:boa_idx,m_idx:m_idx,content:replyContent},
				url:"${ctp}/board/replyInput",
				success:function(){
					alert("댓글이 등록되었습니다");
					location.reload();
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 문의해주세요.");
				}
			})
		}
		
		function openAnswerReply(count){

			$("#answerReplyForm"+count).show()

			$("#openAnswer"+count).hide();
			$("#closeAnswer"+count).show();
		}
	
		function closeAnswerReply(count){
			$("#closeAnswer"+count).hide();
			$("#answerReplyForm"+count).hide();
			$("#openAnswer"+count).show();
		}
		
		function answerReplyUpdate(boa_idx,rep_group,sM_idx,t_nickName,rep_level,count){
			let ansReplyContent = $("#ansReplyContent"+count).val();
			
			if(ansReplyContent.trim()==""){
				alert("답글의 내용을 입력해주세요.");
				$("#ansReplyContent").focus();
				return false;
			}
			
			$.ajax({
				type:"post",
				data:{content:ansReplyContent,boa_idx:boa_idx,rep_group:rep_group,m_idx:sM_idx,t_nickName:t_nickName,rep_level:rep_level},
				url:"${ctp}/board/answerReply",
				success:function(){
					alert("답글이 등록되었습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 문의해주세요.");			
				}
			})
		}
		
		function newsDelete(){
			let ans = confirm("정말로 지우시겠습니까?");
			if(!ans)return false;
			
			let delM_idx = ${newsRead_vo.m_idx};
			
			$.ajax({
				type:"post",
				data:{delM_idx:delM_idx},
				url:"${ctp}/board/deleteForm/${newsRead_vo.boa_idx}/${category}",
				success:function(res){
					if(res=="1"){
						alert("게시글 삭제에 성공하였습니다.");
						location.href="${ctp}/board/news/${category}?nowPage=${nowPage}";
					}
					else if(res=="2"){
						alert("게시글 삭제는 본인의 글만 가능합니다.");
						return false;
					}
				
				},
				error:function(){
					alert("전송오류가 발생하였습니다. 같은 오류가 반복되면 관리자 또는 운영자에게 문의해주세요.");
				}
			})
		}
	
	</script>
</head>
<body> 
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
	<div class="mainTitle" style="margin-top: 3%">News</div>
	<div class="row" >
		<div class="col-6">
			<div class="mainTitle">${categoryName}</div>
		</div>
		<div class="col-6 text-right">
		</div>
	</div>
	<div class="row" style="margin-bottom: 2%">
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
			<div class="row mainfont-m-16">
				<div class="col-1 text-center align-self-center">
					<span class="mainfont-b-22">제목</span>
				</div>
				<div class="col-8	">
					<span class="mainfont-b-22">${newsRead_vo.title}</span>
				</div>
				<div class="col-3 text-right align-self-center">
					조회수&nbsp;${newsRead_vo.viewCnt}
					추천수&nbsp;${newsRead_vo.recommendCnt}
				</div>
				<div class="col-12"><hr/></div>
				<div class="col-12 mt-3">
					 ${newsRead_vo.content}
				</div>
				<div class="col-12 text-center">
					<c:if test="${sM_idx!=newsRead_vo.m_idx && sM_idx != null}">
						<button type="button" class="btn border" onclick="recommendCheck('${newsRead_vo.boa_idx}')">
							<c:if test="${rec_check == null}">
								추천하기
							</c:if>
							<c:if test="${rec_check != null}">
								추천취소
							</c:if>
						</button>
						<button type="button" class="btn border">문의하기</button>
					</c:if>
					<c:if test="${sM_idx==newsRead_vo.m_idx}">
						<button type="button" class="btn border" onclick="newsUpdateForm.submit()">수정하기</button>
						<button type="button" class="btn border" onclick="newsDelete()">삭제하기</button>
						<form name="newsUpdateForm" method="post" action="${ctp}/board/newsUpdateForm/${newsRead_vo.boa_idx}/${category}"></form>
					</c:if>
				</div>
				<div class="col-12"><hr/></div>
				<div class="col-2">
				<img alt="" src="${ctp}/resources/data/memberprofile/${newsRead_vo.photo}" class="profile_img"> 
				</div>
				<div class="col-6">
				<span class="mainfont-b-18">${newsRead_vo.nickName}(${newsRead_vo.mid})</span><span class="fontdot-12">${newsRead_vo.strLevel}</span><br>
				<span class="minafont-m-16">${newsRead_vo.inst}</span>
				</div>
				<div class="col-4 text-right align-self-end fontdot-12">
					<a>친구신청</a> 
					| 
					<a>쪽지</a> 
					| 
					<a>차단하기</a> 
					| 
					<a>사용자신고</a>
				</div>
				<div class="col-12"><hr/></div>
				<div class="col-12 mainfont-b-20 mb-3">댓글</div>
				<div class="col-12"><!-- 댓글 목록 영역 -->
					<c:forEach var="reply_vo" items="${replyVOS}" varStatus="st">
					<div class="row">
					<c:if test="${reply_vo.rep_level==1}">
						<div class="col-1"></div>
					</c:if>
					<c:if test="${reply_vo.rep_level==2}">
						<div class="col-2"></div>
					</c:if>
					<c:if test="${reply_vo.rep_level==3}">
						<div class="col-3"></div>
					</c:if>
					<c:if test="${reply_vo.rep_level==4}">
						<div class="col-4"></div>
					</c:if>
					<c:if test="${reply_vo.rep_level>4}">
						<div class="col-5"></div>
					</c:if>
					<c:if test="${reply_vo.rep_level==0}">
						<div class="col-12">
					</c:if>
					<c:if test="${reply_vo.rep_level==1}">
						<div class="col-11">
					</c:if>
					<c:if test="${reply_vo.rep_level==2}">
						<div class="col-10">
					</c:if>
					<c:if test="${reply_vo.rep_level==3}">
						<div class="col-9">
					</c:if>
					<c:if test="${reply_vo.rep_level==4}">
						<div class="col-8">
					</c:if>
					<c:if test="${reply_vo.rep_level>4}">
						<div class="col-7">
					</c:if>
						<div class="row">
							<div class="col-1 align-self-center">
								<img src="${ctp}/resources/data/memberprofile/${reply_vo.photo}" style="height: 60px ;width:80px">
							</div>
							<div class="col-11">
								<div class="row">
									<div class="col-12">
										<span class="fontdot-12">${reply_vo.nickName}(${reply_vo.mid})&nbsp;&nbsp;${reply_vo.wdate}</span>
									</div>
									<div class="col-10 mainfont-m-16" style="height:100%">
										<span>${reply_vo.content}</span>
									</div>
									<div class="col-2 text-right">
										<button type="button" name="openAnswer${st.count}" id="openAnswer${st.count}" onclick="openAnswerReply('${st.count}')" class="btn border mainfont-b-16">답글</button>
										<button type="button" name="closeAnswer${st.count}" id="closeAnswer${st.count}" onclick="closeAnswerReply('${st.count}')" class="btn border mainfont-b-16" style="display: none">답글닫기</button>
									</div>
									<div class="col-12 text-right align-self-end">
										<c:if test="${reply_vo.m_idx != sM_idx}">
											<span  class="fontdot-12">
												<a>쪽지</a> 
												| 
												<a>차단</a> 
												| 
												<a>신고</a>
											</span>
										</c:if>
										<c:if test="${reply_vo.m_idx == sM_idx}">
											<span  class="fontdot-12">
												<a>수정</a> 
												| 
												<a>삭제</a>
											</span>
										</c:if>
									</div>
								</div>
							</div>
						</div>
						<hr>
						<div name="answerReplyForm${st.count}" id="answerReplyForm${st.count}" style="display: none;">
							<div class="row" style="">
								<div class="col-10 mr-0 pr-0">
									<textarea rows="3" class="form-control" name="ansReplyContent${st.count}" id="ansReplyContent${st.count}"></textarea>
								</div>
								<div class="col-2 ml-0 pl-0">
									<button type="button" class="btn border form-control" style="height:100%;" onclick="answerReplyUpdate('${newsRead_vo.boa_idx}','${reply_vo.rep_group}','${sM_idx}','${reply_vo.nickName}','${reply_vo.rep_level}','${st.count}')">답글달기</button>				
								</div>
							</div>
						</div>
						</div>
					</div>
					</c:forEach>
					<c:if test="${empty replyVOS}">
						현재 작성된 댓글이 없습니다.
					</c:if>				
				</div>
				<div class="col-12">${sNickName}(${sMid})</div>
				<div class="col-10 mr-0 pr-0">
					<textarea rows="3" class="form-control" name="replyContent" id="replyContent"></textarea>
				</div> 	
				<div class="col-2 ml-0 pl-0">
					<button type="button" class="btn border form-control" style="height:100%;" onclick="replyUpdate('${newsRead_vo.boa_idx}','${sM_idx}')">댓글달기</button>				
				</div>
				<div class="col-12">
					<hr>
				</div>
				<div class="col-11">
					<c:if test="${!empty prevNextContentVOS[1].boa_idx}">
						<div class="align-self-center">
							<span class="material-symbols-outlined align-self-center">keyboard_arrow_up</span><a href="${ctp}/board/newsRead/${prevNextContentVOS[1].boa_idx}/${category}">${prevNextContentVOS[1].title}</a><br>
						</div>
					</c:if>			
					<c:if test="${newsRead_vo.boa_idx>prevNextContentVOS[0].boa_idx}">
						<div class="align-self-center">
							<span class="material-symbols-outlined align-self-center">keyboard_arrow_down</span><a href="${ctp}/board/newsRead/${prevNextContentVOS[0].boa_idx}/${category}">${prevNextContentVOS[0].title}</a><br>
						</div>
					</c:if>
					<c:if test="${newsRead_vo.boa_idx<prevNextContentVOS[0].boa_idx}">
						<div class="align-self-center">
							<span class="material-symbols-outlined">keyboard_arrow_up</span><a href="${ctp}/board/newsRead/${prevNextContentVOS[0].boa_idx}/${category}">${prevNextContentVOS[0].title}</a><br>
						</div>
					</c:if>
				</div>
				<div class="col-1">
					<button type="button" onclick="location.href='${ctp}/board/news/${category}?nowPage=${nowPage}'" class="btn border form-control p0">목록</button>
				</div>
			</div>
		</div><!-- 본문 리스트 영역 -->
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>