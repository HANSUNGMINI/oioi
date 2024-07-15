<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" class="">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>오이마켓 - 관리자 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css?v=1652870200386">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png"/>
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
	<link href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css" rel="stylesheet">
	<!-- 토스트UI -->
	<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />	
	<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css"/>
	<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	
	<!--  모달 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
	
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
				<li>마스터 관리자</li>
				<li>상품 카테고리</li>
			</ul>
		</div>
	</section>
	<section class="section main-section">
	    <div class="card has-table">
	    	<header class="card-header">
	        	<p class="card-header-title">
	          	<span class="icon"><i class="mdi mdi-account-multiple"></i></span>
	          		상품 카테고리
	        	</p>
	        	
	        	
				<ul class="categor-list" style="display : flex; height: 20px; margin : auto 0px;">
	            	<li>
	                    <select id="type" onchange="search(this.value, false)">
	                    	<option value=""> 대분류를 선택하시오 </option>
	                        <c:forEach var="cate1" items="${categoryList}">
	                            <option value="${cate1.CTG_CODE}">${cate1.CTG_NAME}</option>
	                        </c:forEach>
	                    </select>
	                </li>
	               
	                <li>          
	                    <select id="type2" disabled onchange="search2(this.value)">
	                        <option value=""> 중분류를 선택하시오</option>
	                    </select>
	                </li>
	            </ul>
				
						        	
	        	<div class="buttons right nowrap">
      				<button class="button small green" id="btn-add" type="button">
      					<span class="icon"><i class="mdi mdi-plus-box-multiple"></i></span>
      				</button>
      				
     			</div>
	        	
	        	<div class="buttons right nowrap">
      				<button class="button small blue" id="btn-apply" type="button">
      					<span class="icon"><i class="mdi mdi-content-save"></i></span>
      				</button>
     			</div>
	        	
	        	<div class="buttons right nowrap">
      				<button class="button small blue" id="btn-add" type="button" onclick="location.reload()">
      					<span class="icon"><i class="mdi mdi-reload"></i></span>
      				</button>
     			</div>
	        	
	        	
	      	</header>
	      	<!-- 그리드 -->
	       	<div id="grid"></div>
		</div>	
	</section>
	</div>
</body>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.min.js?v=1652870200386"></script>
	<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
 	<script src="https://uicdn.toast.com/tui-code-snippet/latest/tui-code-snippet.js"></script>
 	<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
	<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
	<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/toastUI/renderer.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin/admin_category_code_list.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin/admin.js"></script>
    <script>
    </script>
	
	
</html>
    