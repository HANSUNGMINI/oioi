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
    <title> 상세이미지 </title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">
	
</head>
<body class="js">

	<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
	
		<!-- Breadcrumbs -->
		<div class="breadcrumbs">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="bread-inner">
							<ul class="bread-list">
								<li><a href="index1.html">Home<i class="ti-arrow-right"></i></a></li>
								<li class="active"><a href="blog-single.html">Shop Details</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Breadcrumbs -->
				
		<!-- Shop Single -->
		<section class="shop single section">
					<div class="container">
						<div class="row"> 
							<div class="col-12">
								<div class="row">
									<div class="col-lg-6 col-12">
										<!-- Product Slider -->
										<div class="product-gallery">
											<!-- Images slider -->
											<div class="flexslider-thumbnails">
												<ul class="slides">
													<li data-thumb="<%= request.getContextPath() %>/resources/upload/${productInfo.image1}" rel="adjustX:10, adjustY:">
														<img src="<%= request.getContextPath() %>/resources/upload/${productInfo.image1}" alt="#">
													</li>
													<c:if test="${not empty productInfo.image2}">
														<li data-thumb="<%= request.getContextPath() %>/resources/upload/${productInfo.image2}">
															<img src="<%= request.getContextPath() %>/resources/upload/${productInfo.image2}" alt="#">
														</li>
													</c:if>
													<c:if test="${not empty productInfo.image3}">
														<li data-thumb="<%= request.getContextPath() %>/resources/upload/${productInfo.image3}">
															<img src="<%= request.getContextPath() %>/resources/upload/${productInfo.image3}" alt="#">
														</li>
													</c:if>
													<c:if test="${not empty productInfo.image4}">
														<li data-thumb="<%= request.getContextPath() %>/resources/upload/${productInfo.image4}">
															<img src="<%= request.getContextPath() %>/resources/upload/${productInfo.image4}" alt="#">
														</li>
													</c:if>
													<c:if test="${not empty productInfo.image5}">
														<li data-thumb="<%= request.getContextPath() %>/resources/upload/${productInfo.image5}">
															<img src="<%= request.getContextPath() %>/resources/upload/${productInfo.image5}" alt="#">
														</li>
													</c:if>
<!-- 													<li data-thumb="https://via.placeholder.com/570x520"> -->
<!-- 														<img src="https://via.placeholder.com/570x520" alt="#"> -->
<!-- 													</li> -->
<!-- 													<li data-thumb="https://via.placeholder.com/570x520"> -->
<!-- 														<img src="https://via.placeholder.com/570x520" alt="#"> -->
<!-- 													</li> -->
												</ul>
											</div>
											<!-- End Images slider -->
										</div>
										<!-- End Product slider -->
									</div>
									<div class="col-lg-6 col-12">
										<div class="product-des">
											<!-- Description -->
											<div class="short">
												<h4>${productInfo.PD_SUBJECT}</h4>
												<p class="cat" style="margin-top: -1px;">Category :<a href="#">${productInfo.PD_CATEGORY}</a></p>
<%-- 												<p class="price"><span>가 격 : ￦${productInfo.PD_PRICE}</span></p><br> --%>
<!-- 												<p class="description"></p> -->
											</div>
											<div class="color" style="margin-top: 30px;">
												<p class="price"><span class="discount">가 격 </span>￦<fmt:formatNumber value="${productInfo.PD_PRICE}" pattern="#,###"/></p><br>
											</div>
											<!--/ End Description -->
											<!-- Color -->
<!-- 											<div class="color"> -->
<!-- 												<h4>태그 <span>여기다가 태그할까</span></h4> -->
<!-- 												<ul> -->
<!-- 													<li><a href="#" class="one"><i class="ti-check"></i>sdsd</a></li> -->
<!-- 													<li><a href="#" class="one"><i class="ti-check"></i>sdsd</a></li> -->
<!-- 													<li><a href="#" class="two"><i class="ti-check"></i></a></li> -->
<!-- 													<li><a href="#" class="three"><i class="ti-check"></i></a></li> -->
<!-- 													<li><a href="#" class="four"><i class="ti-check"></i></a></li> -->
													
<!-- 												</ul> -->
<!-- 											</div> -->
											<!--/ End Color -->
											<!-- Size -->
											<div class="size">
												<h3>태그</h3>
												<ul>
<!-- 													<li><a href="#" class="one">S</a></li> -->
<!-- 													<li><a href="#" class="two">M</a></li> -->
<!-- 													<li><a href="#" class="three">L</a></li> -->
<!-- 													<li><a href="#" class="four">XL</a></li> -->
<!-- 													<li><a href="#" class="four">XXL</a></li> -->
													<li><p class="one"><span>${productInfo.PD_TAG1}</span></p></li>
													<li><p class="two"><span>${productInfo.PD_TAG2}</span></p></li>
													<li><p class="three"><span>${productInfo.PD_TAG3}</span></p></li>
													<li><p class="four"><span>${productInfo.PD_TAG4}</span></p></li>
													<li><p class="five"><span>${productInfo.PD_TAG5}</span></p></li>
												</ul>
											</div>
											<hr>
											<div class="size">
												<h3>거래 옵션</h3>
												<ul>
													<li><p class="four"><span>상품 상태 : ${productInfo.PD_CONDITION}</span></p></li><br>
													<li><p class="one"><span>가격 흥정 : ${productInfo.PD_PRICE_OFFER}</span></p></li><br>
													<li><p class="three"><span>거래 방식 :  ${productInfo.PD_TRADE_METHOD}</span></p></li><br>
													<li><p class="two"><span>안전 거래 : ${productInfo.PD_SAFE_TRADE}</span></p></li><br>
													<li><p class="five"><span>거래 상태 : ${productInfo.PD_STATUS}</span></p></li><br>
												</ul>
											</div>
											<!--/ End Size -->
											<!-- Product Buy -->
											<div class="product-buy">
												<div class="quantity">
													<h6>찜하기</h6>
												</div>
												<div class="add-to-cart">
													<a href="#" class="btn min"><i class="ti-heart"></i></a>
												</div>
												<p class="cat">조회 수 : ${productInfo.PD_READCOUNT}</p>
												<p class="availability">연관 상품 갯수? or 태그 : 뭘로하까</p>
											</div>
											<!--/ End Product Buy -->
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-12">
										<div class="product-info">
											<div class="nav-main">
												<!-- Tab Nav -->
												<ul class="nav nav-tabs" id="myTab" role="tablist">
													<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#description" role="tab">상품 설명</a></li>
													<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#reviews" role="tab">판매자 정보보기</a></li>
												</ul>
												<!--/ End Tab Nav -->
											</div>
											<div class="tab-content" id="myTabContent">
												<!-- Description Tab -->
												<div class="tab-pane fade show active" id="description" role="tabpanel">
													<div class="tab-single">
														<div class="row">
															<div class="col-12">
																<div class="single-des">
																	<p>${productInfo.PD_CONTENT}</p>
																</div>
<!-- 																<div class="single-des"> -->
<!-- 																	<h4>이건 어케 쓸지 생각중</h4> -->
<!-- 																	<ul> -->
<!-- 																		<li>long established fact.</li> -->
<!-- 																	</ul> -->
<!-- 																</div> -->
															</div>
														</div>
													</div>
												</div>
												<!--/ End Description Tab -->
												<!-- Reviews Tab -->
												<div class="tab-pane fade" id="reviews" role="tabpanel">
													<div class="tab-single review-panel">
														<div class="row">
															<div class="col-12">
																<p> p 태그쓰면 회색</p>
																<p> 음 내 상점 끝나면 거기로 매핑하게 하던지 없애던지~</p>
															</div>
														</div>
													</div>
												</div>
												<!--/ End Reviews Tab -->
											</div>
										</div>
									</div>
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
</html>