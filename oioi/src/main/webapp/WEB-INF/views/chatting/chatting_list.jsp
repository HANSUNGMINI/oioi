<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<!-- 파비콘 -->
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatting/chatList.css">

</head>
<body>
<div class="container">
<div class="row">
<div class="col-md-8">
	<div class="chat_container">
		<div class="job-box">
			<div class="job-box-filter">
			
			<%-- 상단바 --%>
			
				<div class="row">
				
					<%-- 카테고리 --%>
					<div class="col-md-6 col-sm-6">
<!-- 						<select name="datatable_length" class="form-control input-sm"> -->
<!-- 						<option value="10">전체</option> -->
<!-- 						<option value="10">안 읽은 메세지</option> -->
<!-- 						<option value="25">읽은 메세지</option> -->
<!-- 						</select> -->
					</div>
					
					<%-- 검색 --%>
<!-- 					<div class="col-md-6 col-sm-6"> -->
<!-- 						<div class="filter-search-box text-right"> -->
<!-- 							<input type="search" class="form-control input-sm" placeholder="검색어를 입력해 주세요"> -->
<!-- 						</div> -->
<!-- 					</div> -->
				</div>
				
			<%-- ========================================================= --%>
			
			</div>
			
			
			<div class="inbox-message">
				<ul>

				<%-- 대화 내역이 없을 경우 --%>
					<c:if test="${empty combinedList}">
						<div style="height: 380px; text-align: center; margin-top: 300px">
							🥒 <br>
							대화 내역이 존재하지 않습니다. <br>
							대화를 통해 거래를 진행해 보세요 ! 
						</div>
					</c:if>
					
					
				<%-- 한 개의 대화방 --%>
					<c:forEach var="chat" items="${combinedList}">
						<c:set var="info" value="${chat.info}"/>
    					<c:set var="list" value="${chat.list}"/>
    					
					
    					<c:if test="${not empty list.list}">
							<li>
								<a href="Chatting?CR_ID=${info.CR_ID}&PD_IDX=${info.PD_IDX}&FROM_ID=${info.FROM_ID}&TO_ID=${info.TO_ID}&US_ID=${sessionScope.US_ID}">
									<%-- 사용자 이미지 --%>
									<div class="message-avatar">
										<img src="${chat.info.US_PROFILE}" alt="">
									</div>
									
									<%-- 메세지 내용 --%>
									<div class="message-body">
										<div class="message-body-heading">
											<h5> ${chat.info.US_NICK} 
												<c:if test="${list.readCount != 0}">
													<span class="unread">${list.readCount}</span>
												</c:if>
											</h5> <%-- 클래스 종류 : unread(초록) / important(빨강) / pending (파랑) --%>
											<span>${list.list.MS_END_DATE}</span>										
										</div>
										<p>
											<c:choose>
												<c:when test="${list.status eq 1}"> <span style="color:red">자동 이체를 진행해 주세요!</span> </c:when>
												<c:otherwise>${list.list.MS_CONTENT}</c:otherwise>
											</c:choose>
										</p>
									</div>
								</a>
							</li>
    					</c:if>
					</c:forEach>
					
					<%-- ====================================================================================== --%>
					
					
				</ul>
			</div>
		</div>
	</div>
</div>
</div>
</div>

</body>
</html>