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
	<title>관리자 페이지 </title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css?v=1652870200386">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png"/>
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png"/>
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png"/>
	<link rel="stylesheet" href="https://cdn.materialdesignicons.com/4.9.95/css/materialdesignicons.min.css">

  <!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130795909-1"></script>
	<script>
	  window.dataLayer = window.dataLayer || [];
	  function gtag(){dataLayer.push(arguments);}
	  gtag('js', new Date());
	  gtag('config', 'UA-130795909-1');
	</script>

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
			<button class="button light">Button</button>
		</div>
	</section>
	
	<section class="section main-section">
		<div class="grid gap-6 grid-cols-1 md:grid-cols-3 mb-6">
			<div class="card">
		  		<div class="card-content">
		    		<div class="flex items-center justify-between">
		      			<div class="widget-label">
		        			<h3>Clients</h3>
		        			<h1>512</h1>
      					</div>
		      			<span class="icon widget-icon text-green-500"><i class="mdi mdi-account-multiple mdi-48px"></i></span>
		    		</div>
		  		</div>
			</div>
		    <div class="card">
				<div class="card-content">
  					<div class="flex items-center justify-between">
    					<div class="widget-label">
      						<h3>Sales</h3>
      						<h1>213</h1>
		            	</div>
		            	<span class="icon widget-icon text-blue-500"><i class="mdi mdi-cart-outline mdi-48px"></i></span>
		          	</div>
		        </div>
			</div>
	    	<div class="card">
	        	<div class="card-content">
	          		<div class="flex items-center justify-between">
	            		<div class="widget-label">
		              		<h3>Performance</h3>
		              		<h1>256%</h1>
	            		</div>
	            		<span class="icon widget-icon text-red-500"><i class="mdi mdi-finance mdi-48px"></i></span>
	          		</div>
	        	</div>
	      	</div>
		</div>
		
	    <div class="card mb-6">
	    	<header class="card-header">
	        	<p class="card-header-title">
	          		<span class="icon"><i class="mdi mdi-finance"></i></span>
	          		Performance
	        	</p>
	      	</header>
	    	<div class="card-content">
	        	<div class="chart-area">
	          		<div class="h-full">
	            		<div class="chartjs-size-monitor">
	              			<div class="chartjs-size-monitor-expand">
		 	      	        </div>
	            <div class="chartjs-size-monitor-shrink">
	            	<div></div>
	            </div>
	            </div>
	            <canvas id="big-line-chart" width="2992" height="1000" class="chartjs-render-monitor block" style="height: 400px; width: 1197px;"></canvas>
	          </div>
	        </div>
	      </div>
	    </div>
	
  		</section>
  	</div>
  	<!-- 섹션 끝 -->

	<!-- 모달 -->
		<div id="sample-modal" class="modal">
		  <div class="modal-background --jb-modal-close"></div>
		  <div class="modal-card">
		    <header class="modal-card-head">
		      <p class="modal-card-title">Sample modal</p>
		    </header>
		    <section class="modal-card-body">
		      <p>Lorem ipsum dolor sit amet <b>adipiscing elit</b></p>
		      <p>This is sample modal</p>
		    </section>
		    <footer class="modal-card-foot">
		      <button class="button --jb-modal-close">Cancel</button>
		      <button class="button red --jb-modal-close">Confirm</button>
		    </footer>
		  </div>
		</div>
	
		<div id="sample-modal-2" class="modal">
		  <div class="modal-background --jb-modal-close"></div>
		  <div class="modal-card">
		    <header class="modal-card-head">
		      <p class="modal-card-title">Sample modal</p>
		    </header>
		    <section class="modal-card-body">
		      <p>Lorem ipsum dolor sit amet <b>adipiscing elit</b></p>
		      <p>This is sample modal</p>
		    </section>
		    <footer class="modal-card-foot">
		      <button class="button --jb-modal-close">Cancel</button>
		      <button class="button blue --jb-modal-close">Confirm</button>
		    </footer>
		  </div>
		</div>
	</div>
</body>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.min.js?v=1652870200386"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chart.sample.min.js"></script>
</html>
    