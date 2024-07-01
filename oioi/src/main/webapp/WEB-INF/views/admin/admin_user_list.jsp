<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Tables - Admin One Tailwind CSS Admin Dashboard</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css?v=1652870200386">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
	
	<!--  아이콘 -->
	<link href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css" rel="stylesheet">
	<!-- 토스트UI -->
	<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />	
	<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	
	<style>
		#buttons {
			margin : 0px auto;
		}
		
		
	</style>
</head>
<body>
	<div id="app">
	<nav class="app-header navbar navbar-expand bg-body" ><jsp:include page="../INC/admin_nav.jsp"></jsp:include></nav>
	<aside class="aside is-placed-left is-expanded"><jsp:include page="../INC/admin_aside.jsp"></jsp:include></aside>
	<section class="is-title-bar">
		<div class="flex flex-col md:flex-row items-center justify-between space-y-6 md:space-y-0">
			<ul>
				<li>관리자</li>
				<li>회원</li>
			</ul>
		</div>
	</section>
	<section class="section main-section">
	    <div class="card has-table">
	    	<header class="card-header">
	        	<p class="card-header-title">
	          	<span class="icon"><i class="mdi mdi-account-multiple"></i></span>
	          		회원목록
	        	</p>
	        	
	        	<select id="type">
	        		<option value="US_NAME">이름</option>
	        		<option value="US_ID">아이디</option>
	        		<option value="US_NICK">닉네임</option>
	        	</select>
	        	<input type="text" id="keyword" placeholder="검색어 입력">
	        	
	        	<div class="buttons right nowrap">
      				<button class="button small blue" id="btn-add" type="button" onclick="search()">
      					<span class="icon"><i class="mdi mdi-text-search"></i></span>
      				</button>
     			</div>
	        	
	      	</header>
	      	
	      	<!-- 그리드 -->
	       	<div id="grid"></div>
	       	<div id="pagination"></div>
		</div>	
	</section>
	</div>
</body>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.min.js"></script>
	
	<!-- ToastUI  -->
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/toastUI/renderer.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin/admin_user_list.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin/admin.js"></script>
	
</html>
    