<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Tables - Admin One Tailwind CSS Admin Dashboard</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css?v=1652870200386">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png"/>
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png"/>
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png"/>
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
				<li>Admin</li>
				<li>Tables</li>
			</ul>
		</div>
	</section>
	<section class="section main-section">
	    <div class="card has-table">
	    	<header class="card-header">
	        	<p class="card-header-title">
	          	<span class="icon"><i class="mdi mdi-account-multiple"></i></span>
	          		카테고리
	        	</p>
	        	
	        	<div class="buttons right nowrap" align="right">
         			<button class="button small blue --jb-modal" data-target="sample-modal-2" type="button">
         				<span class="icon"><i class="mdi mdi-plus-box-multiple"></i></span>
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.min.js?v=1652870200386"></script>
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
	<script>
		// 컬럼 헤더 
		const columns = [
	        {header: '코드', name: 'code'},
	        {header: '내용', name: 'value'},
	        {header: '사용여부', name: 'hide'},
	    ]
		// 조회할 테이블
		const table = "common";
		let type = ""
	</script>
    <script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
	
	
</html>
    