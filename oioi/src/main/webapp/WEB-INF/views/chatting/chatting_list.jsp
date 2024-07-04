<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<select name="datatable_length" class="form-control input-sm">
						<option value="10">전체</option>
						<option value="10">안 읽은 메세지</option>
						<option value="25">읽은 메세지</option>
						</select>
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
				
				<%-- 한 개의 대화방 --%>
					<li>
						<a href="Chatting">
							<%-- 사용자 이미지 --%>
							<div class="message-avatar">
								<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="">
							</div>
							
							<%-- 메세지 내용 --%>
							<div class="message-body">
								<div class="message-body-heading">
									<h5> 닉네임<span class="unread">3</span></h5> <%-- 클래스 종류 : unread(초록) / important(빨강) / pending (파랑) --%>
									<span>7 시간 전</span>
								</div>
								<p>사고싶어요</p>
							</div>
						</a>
					</li>
					
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