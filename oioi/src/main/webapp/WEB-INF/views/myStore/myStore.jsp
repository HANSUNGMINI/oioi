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
<title>내 상점</title>
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
<style>

</style>
<body class="js">
	<header><jsp:include page="../INC/top.jsp"></jsp:include></header>

<section class="shop single section">
	<div class="container">
		<div class="row"> 
			<div class="col-12">
				<div class="row">
					<div class="col-lg-4 col-12">
						<!-- Product Slider -->
						<div class="product-gallery">
							<!-- Images slider -->
							<div class="flexslider-thumbnails">
								
							<div class="flex-viewport" style="overflow: hidden; position: relative;"><ul class="slides" style="width: 1200%; transition-duration: 0.6s; transform: translate3d(-1110px, 0px, 0px);"><li data-thumb="images/bx-slider4.jpg" class="clone" style="width: 555px; float: left; display: block;">
								<img src="images/bx-slider4.jpg" alt="#">
									</li>
									<li data-thumb="images/bx-slider1.jpg" rel="adjustX:10, adjustY:" class="" style="width: 555px; float: left; display: block;">
										<img src="images/bx-slider1.jpg" alt="#">
									</li>
									<li data-thumb="images/bx-slider2.jpg" class="flex-active-slide" style="width: 555px; float: left; display: block;">
										<img src="images/bx-slider2.jpg" alt="#">
									</li>
									<li data-thumb="images/bx-slider3.jpg" style="width: 555px; float: left; display: block;" class="">
										<img src="images/bx-slider3.jpg" alt="#">
									</li>
									<li data-thumb="images/bx-slider4.jpg" style="width: 555px; float: left; display: block;" class="">
										<img src="images/bx-slider4.jpg" alt="#">
									</li>
								<li data-thumb="images/bx-slider1.jpg" rel="adjustX:10, adjustY:" class="clone" style="width: 555px; float: left; display: block;">
										<img src="images/bx-slider1.jpg" alt="#">
									</li></ul></div><ol class="flex-control-nav flex-control-thumbs"><li><img src="images/bx-slider1.jpg" class=""></li><li><img src="images/bx-slider2.jpg" class="flex-active"></li><li><img src="images/bx-slider3.jpg" class=""></li><li><img src="images/bx-slider4.jpg" class=""></li></ol><ul class="flex-direction-nav"><li><a class="flex-prev" href="#"></a></li><li><a class="flex-next" href="#"></a></li></ul></div>
							<!-- End Images slider -->
						</div>
						<!-- End Product slider -->
					</div>
					<div class="col-lg-8 col-12">
						<div class="product-des">
							<!-- Description -->
							<div class="short">
								<h4>상점 7777777호</h4>
								<div class="rating-main">
									<ul class="rating">
										<li><i class="fa fa-star"></i></li>
										<li><i class="fa fa-star"></i></li>
										<li><i class="fa fa-star"></i></li>
										<li><i class="fa fa-star-half-o"></i></li>
										<li class="dark"><i class="fa fa-star-o"></i></li>
									</ul>
									<a href="#" class="total-review">(102) Review</a>
								</div>
								<p class="price"><span class="discount">$70.00</span><s>$80.00</s> </p>
								<p class="description">eget velit. Donec ac tempus ante. Fusce ultricies massa massa. Fusce aliquam, purus eget sagittis vulputate, sapien libero hendrerit est, sed commodo augue nisi non neque. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, lorem et placerat vestibulum, metus nisi posuere nisl, in</p>
							</div>
							<!--/ End Description -->
							<!-- Color -->
							<div class="color">
								<h4>Available Options <span>Color</span></h4>
								<ul>
									<li><a href="#" class="one"><i class="ti-check"></i></a></li>
									<li><a href="#" class="two"><i class="ti-check"></i></a></li>
									<li><a href="#" class="three"><i class="ti-check"></i></a></li>
									<li><a href="#" class="four"><i class="ti-check"></i></a></li>
								</ul>
							</div>
							<!--/ End Color -->
							<!-- Size -->
							<div class="size">
								<h4>Size</h4>
								<ul>
									<li><a href="#" class="one">S</a></li>
									<li><a href="#" class="two">M</a></li>
									<li><a href="#" class="three">L</a></li>
									<li><a href="#" class="four">XL</a></li>
									<li><a href="#" class="four">XXL</a></li>
								</ul>
							</div>
							<!--/ End Size -->
							<!-- Product Buy -->
							<div class="product-buy">
								<div class="quantity">
									<h6>Quantity :</h6>
									<!-- Input Order -->
									<div class="input-group">
										<div class="button minus">
											<button type="button" class="btn btn-primary btn-number" disabled="disabled" data-type="minus" data-field="quant[1]">
												<i class="ti-minus"></i>
											</button>
										</div>
										<input type="text" name="quant[1]" class="input-number" data-min="1" data-max="1000" value="1">
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
								<p class="cat">Category :<a href="#">Clothing</a></p>
								<p class="availability">Availability : 180 Products In Stock</p>
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
									<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#description" role="tab">Description</a></li>
									<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#reviews" role="tab">Reviews</a></li>
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
													<p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with deskto</p>
												</div>
												<div class="single-des">
													<p>Suspendisse consequatur voluptates lorem nobis accumsan natus mattis. Optio pede, optio qui metus, delectus! Ultricies impedit, minus tempor fuga, quasi, pede felis commodo bibendum voluptas nisi? Voluptatem risus tempore tempora. Quaerat aspernatur? Error praesent laoreet, cras in fames hac ea, massa montes diamlorem nec quaerat, quos occaecati leo nam aliquet corporis, ab recusandae parturient, etiam fermentum, a quasi possimus commodi, mollis voluptate mauris mollis, quisque donec</p>
												</div>
												<div class="single-des">
													<h4>Product Features:</h4>
													<ul>
														<li>long established fact.</li>
														<li>has a more-or-less normal distribution. </li>
														<li>lmany variations of passages of. </li>
														<li>generators on the Interne.</li>
													</ul>
												</div>
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
												<div class="ratting-main">
													<div class="avg-ratting">
														<h4>4.5 <span>(Overall)</span></h4>
														<span>Based on 1 Comments</span>
													</div>
													<!-- Single Rating -->
													<div class="single-rating">
														<div class="rating-author">
															<img src="images/comments1.jpg" alt="#">
														</div>
														<div class="rating-des">
															<h6>Naimur Rahman</h6>
															<div class="ratings">
																<ul class="rating">
																	<li><i class="fa fa-star"></i></li>
																	<li><i class="fa fa-star"></i></li>
																	<li><i class="fa fa-star"></i></li>
																	<li><i class="fa fa-star-half-o"></i></li>
																	<li><i class="fa fa-star-o"></i></li>
																</ul>
																<div class="rate-count">(<span>3.5</span>)</div>
															</div>
															<p>Duis tincidunt mauris ac aliquet congue. Donec vestibulum consequat cursus. Aliquam pellentesque nulla dolor, in imperdiet.</p>
														</div>
													</div>
													<!--/ End Single Rating -->
													<!-- Single Rating -->
													<div class="single-rating">
														<div class="rating-author">
															<img src="images/comments2.jpg" alt="#">
														</div>
														<div class="rating-des">
															<h6>Advin Geri</h6>
															<div class="ratings">
																<ul class="rating">
																	<li><i class="fa fa-star"></i></li>
																	<li><i class="fa fa-star"></i></li>
																	<li><i class="fa fa-star"></i></li>
																	<li><i class="fa fa-star"></i></li>
																	<li><i class="fa fa-star"></i></li>
																</ul>
																<div class="rate-count">(<span>5.0</span>)</div>
															</div>
															<p>Duis tincidunt mauris ac aliquet congue. Donec vestibulum consequat cursus. Aliquam pellentesque nulla dolor, in imperdiet.</p>
														</div>
													</div>
													<!--/ End Single Rating -->
												</div>
												<!-- Review -->
												<div class="comment-review">
													<div class="add-review">
														<h5>Add A Review</h5>
														<p>Your email address will not be published. Required fields are marked</p>
													</div>
													<h4>Your Rating</h4>
													<div class="review-inner">
														<div class="ratings">
															<ul class="rating">
																<li><i class="fa fa-star"></i></li>
																<li><i class="fa fa-star"></i></li>
																<li><i class="fa fa-star"></i></li>
																<li><i class="fa fa-star"></i></li>
																<li><i class="fa fa-star"></i></li>
															</ul>
														</div>
													</div>
												</div>
												<!--/ End Review -->
												<!-- Form -->
												<form class="form" method="post" action="mail/mail.php">
													<div class="row">
														<div class="col-lg-6 col-12">
															<div class="form-group">
																<label>Your Name<span>*</span></label>
																<input type="text" name="name" required="required" placeholder="">
															</div>
														</div>
														<div class="col-lg-6 col-12">
															<div class="form-group">
																<label>Your Email<span>*</span></label>
																<input type="email" name="email" required="required" placeholder="">
															</div>
														</div>
														<div class="col-lg-12 col-12">
															<div class="form-group">
																<label>Write a review<span>*</span></label>
																<textarea name="message" rows="6" placeholder=""></textarea>
															</div>
														</div>
														<div class="col-lg-12 col-12">
															<div class="form-group button5">	
																<button type="submit" class="btn">Submit</button>
															</div>
														</div>
													</div>
												</form>
												<!--/ End Form -->
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




<!-- 	<section class="about-us section"> -->
<!-- 		<div class="container"> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-lg-3 col-12"> -->
<!-- 					<div class="img"> -->
<%-- 						<img src="${pageContext.request.contextPath}/resources/images/test.jpg" alt="#"> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="col-lg-9 col-12"> -->
<!-- 					<div class="about-content"> -->
<!-- 						<h3>상점<span>7777777</span>호</h3> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</section> -->
	
	
	
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