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
#custom-border {
	border: 1px solid #ccc; 
	padding: 10px; 
	position: relative; /* 부모 요소에 position: relative; 적용 */
}

#store-info {
	display: flex;
	margin-top : 15px;
	flex-wrap: wrap; /* 줄 바꿈을 허용할 경우 사용 */
	gap: 5px; /* 요소 사이의 간격 조정 */
}

#store-info > div {
	display: flex;
	align-items: center; /* 중앙 정렬 */
	margin-right: 15px; /* 오른쪽 여백 조정 */
}

#store-info > div > div {
	margin: 0 10px; /* 내부 요소 간의 간격 조정 */
}

.short {
	flex-grow: 1;
}
.product-des button {
	text-size-adjust: 100%;
	box-sizing: border-box;
	font-family: inherit;
	line-height: 1.15;
	margin: 0px;
	overflow: visible;
	text-transform: none;
	font-synthesis: none;
	direction: ltr;
	text-align: left;
	letter-spacing: -0.5px;
	appearance: none;
	background-color: transparent;
	cursor: pointer;
	outline: none;
	height: 20px;
	display: flex;
	align-items: center;
	padding: 0px 5px;
	color: rgb(136, 136, 136);
	border: 1px solid rgb(238, 238, 238);
	font-size: 11px;
}
.border-right {
    border-right: 1px solid #ccc;
}

</style>
<body class="js">
	<header><jsp:include page="../INC/top.jsp"></jsp:include></header>

<section class="shop single section">
	<div class="container">
    	<div class="row"> 
            <div class="col-12">
                <div class="row" id="custom-border">
                    <div class="col-lg-3 col-12 border-right">
                        <div class="single-team">
                            <!-- Image -->
                            <div class="image">
                                <img src="${pageContext.request.contextPath}/resources/images/test.jpg" alt="#">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 col-12">
                        <div class="product-des">
                            <!-- Description -->
                            <div class="short">
                                <h4>상점7777777호</h4>
                                <div class="rating-main" id="store-info">
                                	<div>
                                		<i class="fa-solid fa-shop"></i><div id="store-column">상점오픈일</div>
                                		<div>1 일 전</div>
                                	</div>
                                	<div>
                                		<i class="fa-solid fa-person"></i><div id="store-column">상점방문수</div>
                                		<div>0 명</div>
                                	</div>
                                	<div>
                                		<i class="fa-solid fa-bag-shopping"></i><div id="store-column">상품판매</div>
                                		<div>0 회</div>
                                	</div>
                                	<div>
                                		<i class="fa-solid fa-box"></i><div id="store-column">택배발송</div>
                                		<div>0 회</div>
                                	</div>
                                </div>
                                <hr>
                            </div>
                            <div>
                            	<button>소개글 수정</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="product-info">
                            <div class="nav-main">
                                <!-- Tab Nav -->
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#product" role="tab">상품</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#review" role="tab">상점후기</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#choice" role="tab">찜</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#following" role="tab">팔로잉</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#follower" role="tab">팔로워</a></li>
                                </ul>
                                <!--/ End Tab Nav -->
                            </div>
                            <div class="tab-content" id="myTabContent">
                                <!-- Description Tab -->
                                <div class="tab-pane fade show active" id="product" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="single-des">
                                                	<h5>상품 0</h5>
                                                </div>
                                                <hr>
                                                <div class="single-des">
                                                	<p>등록된 상품이 없습니다.</p>
                                                </div>
                                    		</div>
                                  		</div>
                                  	</div>
                                </div>
                                <!--/ End Description Tab -->
                                <!-- Reviews Tab -->
                                <div class="tab-pane fade" id="review" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="single-des">
                                                	<h5>상점 후기 0</h5>
                                                </div>
                                                <hr>
                                                <div class="single-des">
                                                	<p>상점후기가 없습니다.</p>
                                                </div>
                                    		</div>
                                  		</div>
                                  	</div>
                                </div>
                                <!--/ End Reviews Tab -->
                                <!-- Choice Tab -->
                                <div class="tab-pane fade" id="choice" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="single-des">
                                                	<h5>찜 0</h5>
                                                </div>
                                                <hr>
                                                <div class="single-des">
                                                	<p>찜한 상품이 없습니다.</p>
                                                </div>
                                    		</div>
                                  		</div>
                                  	</div>
                                </div>
                                <!--/ End Choice -->
                                <div class="tab-pane fade" id="following" role="tabpanel">
                                   <div class="tab-single">
                                       <div class="row">
                                           <div class="col-12">
                                               <div class="single-des">
                                               	<h5>팔로잉 0</h5>
                                               </div>
                                               <hr>
                                               <div class="single-des">
                                               	<p>아직 팔로우한 사람이 없습니다.</p>
                                               </div>
                                   		</div>
                                 		</div>
                                 	</div>
                               </div>
                               <div class="tab-pane fade" id="follower" role="tabpanel">
                                   <div class="tab-single">
                                       <div class="row">
                                           <div class="col-12">
                                               <div class="single-des">
                                               	<h5>팔로워 0</h5>
                                               </div>
                                               <hr>
                                               <div class="single-des">
                                               	<p>아직 이 상점을 팔로우한 사람이 없습니다.</p>
                                               </div>
                                   			</div>
                               			</div>
									</div>	
								</div>
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