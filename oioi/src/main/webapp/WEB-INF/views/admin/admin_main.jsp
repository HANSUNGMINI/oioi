<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
    
<!DOCTYPE html>
<html lang="ko">
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

</head>
<body>
	<div id="app">
	<!-- 상단 네비게이션 -->
	<nav class="app-header navbar navbar-expand bg-body" ><jsp:include page="../INC/admin_nav.jsp"></jsp:include></nav>
	<aside class="aside is-placed-left is-expanded"><jsp:include page="../INC/admin_aside.jsp"></jsp:include></aside>
	<div class="section">
		<section class="is-title-bar">
			<div class="flex flex-col md:flex-row items-center justify-between space-y-6 md:space-y-0">
			    <ul>
			      <li>관리자</li>
			      <li>메인화면</li>
			    </ul>
			  </div>
		</section>
		
		<section class="is-hero-bar">
			<div class="flex flex-col md:flex-row items-center justify-between space-y-6 md:space-y-0">
				<h1 class="title">
				  Dashboard
				</h1>
				<button class="button light" onclick="location.reload()">새로 고침</button>
			</div>
		</section>
	</div>
  	</div>
</body>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.min.js?v=1652870200386"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chart.sample.min.js"></script>
</html>
    