<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>오이마켓 - 관리자 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css?v=1652870200386">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
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
				<li>신고</li>
			</ul>
		</div>
	</section>
	<section class="section main-section">
	    <div class="card has-table">
	    	<header class="card-header">
	        	<p class="card-header-title">
	          	<span class="icon"><i class="mdi mdi-account-multiple"></i></span>
	          		신고목록
	        	</p>
	        	
	        	<select id="type">
	        		<option value="TO_US_ID">신고대상</option>
	        		<option value="FROM_US_ID">신고자</option>
	        	</select>
	        	<input type="text" id="keyword" placeholder="검색어 입력">
	        	
	        	<div class="buttons right nowrap">
      				<button class="button small blue" id="btn-add" type="button">
      					<span class="icon"><i class="mdi mdi-text-search"></i></span>
      				</button>
     			</div>
	        	
	        	<div class="buttons right nowrap">
		        	<input type="checkbox" id="selectPastReport"> 이전 내용 검색
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
    <script src="${pageContext.request.contextPath}/resources/js/admin/admin_report_list.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin/admin.js"></script>
	
</html>
    