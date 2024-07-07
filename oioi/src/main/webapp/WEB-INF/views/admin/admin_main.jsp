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
	<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css">
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
				  사이트 현황
				</h1>
				<button class="button light" onclick="location.reload()">새로 고침</button>
			</div>
		</section>
		<div style="display:flex">
			<div id="chart" style="width: 50%; height: 500px;"></div>
		
		</div>
		
		
	</div>
  	</div>
</body>
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
<script>
	$(function(){
		getMostRegistCategory();
		
	})
	
	function getMostRegistCategory(){
		$.ajax({
			type : "GET",
			url : "MostRegistCategory",
			dataType : "JSON",
			success : function(response) {
				const series1 = [];
					
				for(var item of response){
					let data = {
						name : item.category,
						data : item.cnt
					}
					series1.push(data);
				};
				
				const chart = toastui.Chart;
				const data = {
					categories: ['Categories'],
			        series: series1,
				};

			    const options = {
// 			        chart: { width: 900, height: 500 },
			        series: {
			            radiusRange: ['40%', '100%'],
			            showLabel: true
			        },
			        tooltip: {
			            suffix: '%'
			        }
			    };
		    	chart.pieChart({ el: document.getElementById('chart'), data, options });
			} // success 끝
		})
	}
</script>
</html>
    