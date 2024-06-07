<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="zxx"><head>
	<!-- Meta Tag -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="copyright" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Title Tag  -->
    <title>마이페이지</title>
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
	<!-- StyleSheet -->
	<script src="https://kit.fontawesome.com/ef42a902c7.js" crossorigin="anonymous"></script>
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

<style>
	#highlighted-row {
		border: 1px solid #eeeeeec2; 
	}
</style>
<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<!-- Preloader -->
<!-- Start Blog Single -->
<section class="blog-single shop-blog grid section">
	<div class="container">
		<div class="row">
			<div class="col-lg-3 col-12">
				<div class="main-sidebar">
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">나의 정보 관리</h3>
						<ul class="categor-list">
							<li><a href="#">회원정보 수정</a></li>
							<li><a href="#">비밀번호 변경</a></li>
						</ul>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">나의 프로필 관리</h3>
						<ul class="categor-list">
							<li><a href="#">프로필 등록 및 수정</a></li>
						</ul>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">나의 거래 내역</h3>
						<ul class="categor-list">
							<li><a href="#">나의 구매 내역</a></li>
							<li><a href="#">나의 판매 내역</a></li>
						</ul>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">나의 경매 내역</h3>
						<ul class="categor-list">
							<li><a href="#">나의 경매 등록 내역</a></li>
							<li><a href="#">나의 경매 입찰 내역</a></li>
						</ul>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">나의 리뷰 내역</h3>
						<ul class="categor-list">
							<li><a href="#">나의 작성 리뷰 내역</a></li>
							<li><a href="#">나의 상품 리뷰 내역</a></li>
						</ul>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">나의 문의 내역</h3>
						<ul class="categor-list">
							<li><a href="#">나의 1:1 문의 내역</a></li>
						</ul>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">나의 신고 내역</h3>
						<ul class="categor-list">
							<li><a href="#">나의 신고 내역</a></li>
							<li><a href="#">나의 신고된 내역</a></li>
						</ul>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">로그아웃</h3>
					</div>
					<!--/ End Single Widget -->
					<!-- Single Widget -->
					<div class="single-widget category">
						<h3 class="title">회원탈퇴</h3>
					</div>
					<!--/ End Single Widget -->
				</div>
			</div>
			<div class="col-lg-9 col-12" id="highlighted-row">
				<div class="row">
					<!-- Add your content here for the highlighted row -->
				</div>
			</div>
		</div>
	</div>
</section>
<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
		
	
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