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
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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
	
	<style type="text/css">
		.owl-stage {
		}
	
		 .overlay {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            height: 100%;
            width: 100%;
            opacity: 0.7;
            background-color: black;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            border-radius: 5px;
        }
        
        .non_overlay {
        	display : none;
        }
	</style>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script type="text/javascript">
    $(function() {
        function updateCountdown() {
            $('.apdCount').each(function() {
                var endTimeString = $(this).data('endtime');
                var endTime = new Date(endTimeString.replace(/-/g, '/'));
                console.log("endTime" + endTime);
                var now = new Date();
                console.log("now" + now);
                var timeRemain = endTime - now;
                console.log("timeRemain" + timeRemain);
                if (timeRemain <= 0) {
                    $(this).text('경매가 끝났습니다.');
                    return;
                }

                var days = Math.floor(timeRemain / (1000 * 60 * 60 * 24));
                var hours = Math.floor((timeRemain % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((timeRemain % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((timeRemain % (1000 * 60)) / 1000);

                $(this).html(days + '일 ' + hours + '시간 ' + minutes + '분 ' + seconds + '초');
            });
        }

        setInterval(updateCountdown, 1000);

        updateCountdown();
    });
	</script>	
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
						
						
						<c:forEach var="item" items="${auctionProducts}" varStatus="status">
							  <div class="big-content" style="height: 400px;">
<%-- 							    <img src="${pageContext.request.contextPath}/resources/upload/${item.APD_MAIN_IMAGE}" style="width: 550px; height: 100%;">  --%>
							    <img src="<%= request.getContextPath() %>/resources/upload/${item.APD_MAIN_IMAGE}" style="width: 500px; height: 100%;"> 
<!-- 								<div class="inner" style="width: 50%;"> -->
<%-- 									<a id="apdCount_${status.index}" style="font-size: 45px; font-weight: 2px;" class="apdCount" data-endtime="${item.AT_END_TIME}"></a> --%>
<!-- 									<br> -->
<!-- 									<br> -->
<%-- 									<h4 class="title">${item.APD_NAME }</h4> --%>
<%-- 									<p class="des">경매 종료일 ${item.AT_END_TIME}<br> 현재 입찰된 가격 ${item.FINAL_BID_PRICE}<br> 즉시구매가 ! ${item.APD_BUY_NOW_PRICE}원</p> --%>
<!-- 									<div class="button"> -->
<%-- 										<a href="auctionDetail?APD_IDX=${item.APD_IDX}" class="btn">참가하기 </a> --%>
<!-- 									</div> -->
<!-- 								</div> -->
								<div class="inner" style="margin-right: 100px;">
									<h4 class="title"><a id="apdCount_${status.index}" class="apdCount" data-endtime="${item.AT_END_TIME}"></a></h4>
									<h4 class="title">${item.APD_NAME }</h4>
									<p class="des">[경매 종료일] ${item.AT_END_TIME}<br>[현재 입찰된 가격] <fmt:formatNumber value="${item.FINAL_BID_PRICE}" pattern="#,###"/>원<br> [즉시구매가] <fmt:formatNumber value="${item.APD_BUY_NOW_PRICE}" pattern="#,###"/>원</p>
									<div class="button">
										<a href="auctionDetail?APD_IDX=${item.APD_IDX}" class="btn">참가하기</a>
									</div>
								</div>
							</div>
						</c:forEach>						
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ End Hero Area 2 -->
	
	<!-- 인기 상품? -->
	<div class="product-area most-popular section">
        <div class="container">
            <div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>인기 상품</h2>
<!-- 						<a href="#"> 더보기</a> -->
						<a href="trade?filter=popular"> 더보기</a>
					</div>
				</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="owl-carousel popular-slider">
                    
                    	<c:forEach var="popular" items="${popularProducts}">
							<!-- 제품 하나하나 -->
							<div class="single-product">
								<div class="product-img">
									<a href="productDetail?PD_IDX=${popular.PD_IDX}">
										<img class="default-img" src="<%= request.getContextPath() %>/resources/upload/${popular.IMG}">
										<c:if test="${not (popular.PD_STATUS_VALUE eq '판매 중')}">
											<div class="overlay">${popular.PD_STATUS_VALUE}</div>
										</c:if>
	<!-- 									<img class="hover-img"   alt="#"> -->
<%-- 										<span class="${popular.PD_STATUS_COLOR}">${popular.PD_STATUS_VALUE}</span> <!-- out-of-stock = 빨간색 / new = 파란?보라?색 / price-dec = 초록색 --> --%>
									</a>
									<div class="button-head">
<!-- 										<div class="product-action"> -->
<!-- 											<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a> -->
<!-- 										</div> -->
										<div class="product-action-2">
											<a title="Add to cart" href="productDetail?PD_IDX=${popular.PD_IDX}">상품 상세페이지로 바로가기</a>
										</div>
									</div>
								</div>
								<div class="product-content">
									<h3><a href="product-details.html">${popular.PD_SUBJECT}</a></h3>
									<div class="product-price">
										<!-- 세일 기준 -->
	<!-- 									<span class="old">이전가격</span> -->
										<span>${popular.PD_PRICE} 원</span>
										<span class="pro_time" style="float:right; color:gray"><small>${popular.RD_DATE}</small></span>
									</div>
								</div>
							</div>
							<!-- 제품 하나 끝 -->
                    	</c:forEach>
                    
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- End Most Popular Area -->
	
	<!-- 최근 본 상품 -->
	<div class="product-area most-popular section">
        <div class="container">
            <div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>최근 본 상품</h2>
<!-- 						<a href="#"> 더보기</a> -->
					</div>
				</div>
            </div>
            <div class="row">
                <div class="col-12" id="noProduct">
                    <div class="owl-carousel popular-slider" id="recentLookProduct">
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
<!-- 						<a href="#"> 더보기</a> -->
					</div>
				</div>
            </div>
            <div class="row" >
                <div class="col-12"  id="noKeyword">
                <!-- popular-slider owl-carousel -->
                	<div class="popular-slider owl-carousel" id="recentKeywordProduct">
                		<!-- <div class="owl-stage-outer" id="recentKeywordProduct" > -->
<!--                  	<div class="owl-stage" style="transform: translate3d(0px, 0px, 0px); transition: all 0s ease 0s; width: 285px;" id="recentKeywordProduct">  -->
                	<!-- 이곳에 상세 설명 나옴-->
                		<!-- </div> -->
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
<!-- 									<div class="add-to-cart"> -->
<!-- 										<a href="#" class="btn">Add to cart</a> -->
<!-- 										<a href="#" class="btn min"><i class="ti-heart"></i></a> -->
<!-- 										<a href="#" class="btn min"><i class="fa fa-compress"></i></a> -->
<!-- 									</div> -->
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
 	
 	<!-- 상품 불러오기 -->
  	<script src="${pageContext.request.contextPath}/resources/js/mainProduct.js"></script> 
 
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