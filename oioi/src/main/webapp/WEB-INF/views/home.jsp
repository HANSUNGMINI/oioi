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
    <title> 오늘, 이곳에서 -메인-</title>
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
	
	<!-- 섹션 -->
	<!-- 메인 BIG 컨텐츠 -->
	<section class="hero-area4">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="home-slider-4">
						<!-- 하나만 놔두면 오류? -->
						
						<div class="big-content" style="background-image:url('')">
							<div class="inner">
								<h4 class="title">이곳에 <br> 정보를 <br> 넣는</h4>
								<p class="des">Hipster style is a fashion trending for Gentleman and Lady<br>with tattoos. Youâll become so cool and attractive with yourâs girl.<br> Now let come hare and grab it now !</p>

								<div class="button">
									<a href="#" class="btn">1번</a>
								</div>
							</div>
						</div>
						
						<div class="big-content" >
							<div class="inner">
								<h4 class="title">이곳에 <br> 정보를 <br> 넣는</h4>
								<p class="des">Hipster style is a fashion trending for Gentleman and Lady<br>with tattoos. Youâll become so cool and attractive with yourâs girl.<br> Now let come hare and grab it now !</p>
								<div class="button">
									<a href="#" class="btn">2번</a>
								</div>
							</div>
						</div>
					
						
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ End Hero Area 2 -->
	
	<!-- 최근 본 상품? -->
	<div class="product-area most-popular section">
        <div class="container">
            <div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>최근 본 상품</h2>
						<a href="#"> 더보기</a>
					</div>
				</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="owl-carousel popular-slider">
						<!-- 제품 하나하나 -->
						<div class="single-product">
							<div class="product-img">
								<a href="product-details.html">
									<img class="default-img"  src="https://image.msscdn.net/images/goods_img/20231213/3754860/3754860_17025174767964_500.jpg"  alt="#">
<!-- 									<img class="hover-img"   alt="#"> -->
									<span class="out-of-stock">Hot</span>
								</a>
								<div class="button-head">
									<div class="product-action">
										<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a>
									</div>
									<div class="product-action-2">
										<a title="Add to cart" href="#">상품 상세페이지로 바로가기</a>
									</div>
								</div>
							</div>
							<div class="product-content">
								<h3><a href="product-details.html">제품 이름 넣는곳</a></h3>
								<div class="product-price">
									<!-- 세일 기준 -->
									<span class="old">이전가격</span>
									<span>현재가격</span>
								</div>
							</div>
						</div>
						<!-- 제품 하나 끝 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- End Most Popular Area -->
	
	<!-- 인기 상품 -->
	<div class="product-area most-popular section">
        <div class="container">
            <div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>인기 상품</h2>
						<a href="#"> 더보기</a>
					</div>
				</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="owl-carousel popular-slider">
						<!-- 제품 하나하나 -->
						<div class="single-product">
							<div class="product-img">
								<a href="product-details.html">
									<img class="default-img" src="https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/2fb6ff59-aca1-4f1f-a836-0888d4f119a6/v2k-%EB%9F%B0-%EC%8B%A0%EB%B0%9C-TeZkXP2L.png"  alt="#">
									<span class="out-of-stock">Hot</span>
								</a>
								<div class="button-head">
									<div class="product-action">
										<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a>
									</div>
									<div class="product-action-2">
										<a title="Add to cart" href="#">상품 상세페이지로 바로가기</a>
									</div>
								</div>
							</div>
							<div class="product-content">
								<h3><a href="product-details.html">제품 이름 넣는곳</a></h3>
								<div class="product-price">
									<!-- 세일 기준 -->
									<span class="old">이전가격</span>
									<span>현재가격</span>
								</div>
							</div>
						</div>
						<!-- 제품 하나 끝 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- End Most Popular Area -->
	
	<!-- 최근 검색한 키워드 연관 상품 -->
	<div class="product-area most-popular section">
        <div class="container">
            <div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>최근 검색한 키워드 연관 상품</h2>
						<a href="#"> 더보기</a>
					</div>
				</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="owl-carousel popular-slider">
						<!-- 제품 하나하나 -->
						<div class="single-product">
							<div class="product-img">
								<a href="product-details.html">
									<img class="default-img"  src="https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/3f12c33f-de0d-4d7f-848a-b4eb273c2a7d/p-6000-%ED%94%84%EB%A6%AC%EB%AF%B8%EC%97%84-%EC%8B%A0%EB%B0%9C-PDwmNHw5.png" alt="#">
<!-- 									<img class="hover-img"   alt="#"> -->
									<span class="out-of-stock">Hot</span>
								</a>
								<div class="button-head">
									<div class="product-action">
<!-- 										<a data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a> -->
										<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a>
									</div>
									<div class="product-action-2">
										<a title="Add to cart" href="#">상품 상세페이지로 바로가기</a>
									</div>
								</div>
							</div>
							<div class="product-content">
								<h3><a href="product-details.html">제품 이름 넣는곳</a></h3>
								<div class="product-price">
									<!-- 세일 기준 -->
									<span class="old">이전가격</span>
									<span>현재가격</span>
								</div>
							</div>
						</div>
						<!-- 제품 하나 끝 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- End Most Popular Area -->
	
	
	
	
	<!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="ti-close" aria-hidden="true"></span></button>
                    </div>
                    <div class="modal-body">
                        <div class="row no-gutters">
                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                                <!-- Product Slider -->
									<div class="product-gallery">
										<div class="quickview-slider-active">
											<div class="single-slider">
												<img src="https://via.placeholder.com/569x528" alt="#">
											</div>
											<div class="single-slider">
												<img src="https://via.placeholder.com/569x528" alt="#">
											</div>
											<div class="single-slider">
												<img src="https://via.placeholder.com/569x528" alt="#">
											</div>
											<div class="single-slider">
												<img src="https://via.placeholder.com/569x528" alt="#">
											</div>
										</div>
									</div>
								<!-- End Product slider -->
                            </div>
                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                                <div class="quickview-content">
                                    <h2>Flared Shift Dress</h2>
                                    <div class="quickview-ratting-review">
                                        <div class="quickview-ratting-wrap">
                                            <div class="quickview-ratting">
                                                <i class="yellow fa fa-star"></i>
                                                <i class="yellow fa fa-star"></i>
                                                <i class="yellow fa fa-star"></i>
                                                <i class="yellow fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <a href="#"> (1 customer review)</a>
                                        </div>
                                        <div class="quickview-stock">
                                            <span><i class="fa fa-check-circle-o"></i> in stock</span>
                                        </div>
                                    </div>
                                    <h3>$29.00</h3>
                                    <div class="quickview-peragraph">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia iste laborum ad impedit pariatur esse optio tempora sint ullam autem deleniti nam in quos qui nemo ipsum numquam.</p>
                                    </div>
									<div class="size">
										<div class="row">
											<div class="col-lg-6 col-12">
												<h5 class="title">Size</h5>
												<select>
													<option selected="selected">s</option>
													<option>m</option>
													<option>l</option>
													<option>xl</option>
												</select>
											</div>
											<div class="col-lg-6 col-12">
												<h5 class="title">Color</h5>
												<select>
													<option selected="selected">orange</option>
													<option>purple</option>
													<option>black</option>
													<option>pink</option>
												</select>
											</div>
										</div>
									</div>
                                    <div class="quantity">
										<!-- Input Order -->
										<div class="input-group">
											<div class="button minus">
												<button type="button" class="btn btn-primary btn-number" disabled="disabled" data-type="minus" data-field="quant[1]">
													<i class="ti-minus"></i>
												</button>
											</div>
											<input type="text" name="quant[1]" class="input-number"  data-min="1" data-max="1000" value="1">
											<div class="button plus">
												<button type="button" class="btn btn-primary btn-number" data-type="plus" data-field="quant[1]">
													<i class="ti-plus"></i>
												</button>
											</div>
										</div>
										<!--/ End Input Order -->
									</div>
									<div class="add-to-cart">
										<a href="#" class="btn">Add to cart</a>
										<a href="#" class="btn min"><i class="ti-heart"></i></a>
										<a href="#" class="btn min"><i class="fa fa-compress"></i></a>
									</div>
                                    <div class="default-social">
										<h4 class="share-now">Share:</h4>
                                        <ul>
                                            <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></a></li>
                                            <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li>
                                            <li><a class="youtube" href="#"><i class="fa fa-pinterest-p"></i></a></li>
                                            <li><a class="dribbble" href="#"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
    <!-- Modal end -->
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