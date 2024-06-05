<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="zxx">
<head>
	<!-- Meta Tag -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name='copyright' content=''>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Title Tag  -->
    <title> 상품등록 </title>
	<!-- Favicon 
	     인터넷 위에보면 아이콘 넣기 가능 이미지만 바꾸며ㅑㄴ댐-->
<%-- 	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png"> --%>
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
	
	<!-- StyleSheet -->
	
	<!-- Bootstrap -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
	<!-- Magnific Popup -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/magnific-popup.min.css">
	<!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
	<!-- Fancybox -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css">
	<!-- Themify Icons -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/themify-icons.css">
	<!-- Nice Select CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/niceselect.css">
	<!-- Animate CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
	<!-- Flex Slider CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flex-slider.min.css">
	<!-- Owl Carousel -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl-carousel.css">
	<!-- Slicknav -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slicknav.min.css">
	
	<!-- Eshop StyleSheet -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/responsive.css">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/color.css">
	
</head>
<body class="js">

	<header><jsp:include page="INC/top.jsp"></jsp:include></header>
	
		<!-- Breadcrumbs -->
		<div class="breadcrumbs">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="bread-inner">
							<ul class="bread-list">
								<li><a href="index1.html">Home<i class="ti-arrow-right"></i></a></li>
								<li class="active"><a href="blog-single.html">상품등록</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Breadcrumbs -->
				
		<!-- Shop Login -->
		<section class="shop login section">
			<div class="container">
<!-- 				<div class="row">  -->
<!-- 					<div class="col-lg-6 col-12"> -->
						<div class="login-form">
							<h2>상품등록</h2>
							<!-- Form -->
							<form method="post" action="#">
								<ul>
									<li>
										<label> 상품 이미지</label>
										<input type="text">
									</li>
									<li>
										<label> 상품명</label>
									</li>
									<li>
										<label> 카테고리</label>
									</li>
									<li>
										<label> 상품설명</label>
									</li>
								</ul>
<!-- 								<div class="row"> -->
<!-- 									<div class="col-12"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>상품명<span>*</span></label> -->
<!-- 											<input type="text" class="input" placeholder="상품명 입력란"> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-12"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>태그 등록<span>*</span></label> -->
<!-- 											<input type="text" class="input" placeholder="태그 입력란"> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-12"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>가격(₩)<span>*</span></label> -->
<!-- 											<input type="text" class="input" placeholder="가격₩"><br> -->
<!-- 											<input type="checkbox" checked>제시가능 -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-12"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>상품 이미지<span>*</span></label> -->
<!-- 											<input type="file" accept="image/*" multiple="multiple" class="input" placeholder="상품이미지 등록"> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-12"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label> 이미지 미리보기 <span>*</span></label> -->
<!-- 											<div style="display : flex;"> -->
<%-- 												<img src="${pageContext.request.contextPath}/resources/images/no-image01.gif"> --%>
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="col-12"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<label>상품상태<span>*</span></label><br> -->
<!-- 											<input type="radio" name="condition">미개봉(미사용)<small>아직 개봉하지 않은 새상품</small><br> -->
<!-- 											<input type="radio" name="condition">사용감 없음<small>사용은 했지만 눈에 띄는 흔적이나 얼룩이 없음</small><br> -->
<!-- 											<input type="radio" name="condition">사용감 적음<small>눈에 띄는 흔적이나 얼룩이 약간 있음</small><br> -->
<!-- 											<input type="radio" name="condition">사용감 많음<small>눈에 띄는 흔적이나 얼룩이 많이 있음</small><br> -->
<!-- 											<input type="radio" name="condition">고장 및 파손<small>기능 이상이나 외관 손상 등으로 수리/수선 필요</small> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
							</form>
							<!--/ End Form -->
						</div>
					</div>
<!-- 				</div> -->
<!-- 			</div> -->
		</section>
		<!--/ End Login -->
		
		<footer><jsp:include page="INC/bottom.jsp"></jsp:include></footer>
 
	<!-- Jquery -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-migrate-3.0.0.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<!-- Popper JS -->
	<script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
	<!-- Bootstrap JS -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<!-- Color JS -->
	<script src="${pageContext.request.contextPath}/resources/js/colors.js"></script>
	<!-- Slicknav JS -->
	<script src="${pageContext.request.contextPath}/resources/js/slicknav.min.js"></script>
	<!-- Owl Carousel JS -->
	<script src="${pageContext.request.contextPath}/resources/js/owl-carousel.js"></script>
	<!-- Magnific Popup JS -->
	<script src="${pageContext.request.contextPath}/resources/js/magnific-popup.js"></script>
	<!-- Fancybox JS -->
	<script src="${pageContext.request.contextPath}/resources/js/facnybox.min.js"></script>
	<!-- Waypoints JS -->
	<script src="${pageContext.request.contextPath}/resources/js/waypoints.min.js"></script>
	<!-- Countdown JS -->
	<script src="${pageContext.request.contextPath}/resources/js/finalcountdown.min.js"></script>
	<!-- Nice Select JS -->
	<script src="${pageContext.request.contextPath}/resources/js/nicesellect.js"></script>
	<!-- Ytplayer JS -->
	<script src="${pageContext.request.contextPath}/resources/js/ytplayer.min.js"></script>
	<!-- Flex Slider JS -->
	<script src="${pageContext.request.contextPath}/resources/js/flex-slider.js"></script>
	<!-- ScrollUp JS -->
	<script src="${pageContext.request.contextPath}/resources/js/scrollup.js"></script>
	<!-- Onepage Nav JS -->
	<script src="${pageContext.request.contextPath}/resources/js/onepage-nav.min.js"></script>
	<!-- Easing JS -->
	<script src="${pageContext.request.contextPath}/resources/js/easing.js"></script>
	<!-- Active JS -->
	<script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
</body>
</html>