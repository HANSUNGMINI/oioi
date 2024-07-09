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
	<!-- Favicon -->
<%-- 	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png"> --%>
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
	
	<!-- StyleSheet -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/magnific-popup.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/themify-icons.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/niceselect.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flex-slider.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl-carousel.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slicknav.min.css">
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
									</div>
									<div class="color" style="margin-top: 30px;">
										<p class="price"><span class="discount">가 격 </span>￦<fmt:formatNumber value="${productInfo.PD_PRICE}" pattern="#,###"/></p><br>
									</div>
									<!--/ End Description -->
									<!-- Size -->
									<div class="size">
										<h3>태그</h3>
										<ul>
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
											<li><p class="one"><span>상품 상태 : ${productInfo.PD_CONDITION}</span></p></li><br>
											<li><p class="two"><span>가격 흥정 : ${productInfo.PD_PRICE_OFFER}</span></p></li><br>
											<li><p class="three"><span>거래 방식 :  ${productInfo.PD_TRADE_METHOD}</span></p></li><br>
											<li><p class="four"><span>안전 거래 : ${productInfo.PD_SAFE_TRADE}</span></p></li><br>
											<li><p class="five"><span>거래 상태 : ${productInfo.PD_STATUS}</span></p></li><br>
										</ul>
									</div>
									<!--/ End Size -->
									<!-- Product Buy -->
									<div class="product-buy">
										<ul class="nav nav-tabs" id="myTab" role="tablist">
											<li class="nav-item"><a class="nav-link ${productInfo.wish_yn}" data-toggle="tab" id="goWish" href="#" role="tab" onclick="addToWishList()">♥</a></li>
											<li class="nav-item"><a class="nav-link" data-toggle="tab" id="goChat" role="tab" onclick="goChatting()">채팅</a></li>
											<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#" id="directBuy" role="tab" onclick="">바로구매</a></li>
										</ul>
										<p class="cat">조회 수 : ${productInfo.PD_READCOUNT}</p>
<!-- 										<div class="quantity"> -->
<!-- 											<h6>찜하기</h6> -->
<!-- 										</div> -->
<!-- 										<div class="add-to-cart"> -->
<!-- 											<a href="#" class="btn min"><i class="ti-heart"></i></a> -->
<!-- 										</div> -->
<!-- 										<p class="availability">연관 상품 갯수? or 태그 : 뭘로하까</p> -->
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
											<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#reviews" id="sellerInfoTab" role="tab" onclick="myStore()">판매자 정보보기</a></li>
<!-- 											<li class="nav-item"><a class="nav-link" data-toggle="tab" id="goChat" role="tab" onclick="goChatting()">채팅</a></li> -->
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
	
	<script type="text/javascript">
	
	$(function(){
		makeProducts();
	})
	
	    function myStore() {
	        var userId = '${productInfo.US_ID}';
	        console.log(userId);
	        window.location.href = 'myStore?userId=' + userId;
	    }
	    
	    function goChatting(){
    	 	var userId = '${productInfo.US_ID}';
    	 	var productId = '${productInfo.PD_IDX}';
    	 	var sId = '${sessionScope.US_ID}'
    	 	
    	 	window.open('Chatting?TO_ID=' + userId + '&PD_IDX='+ productId + '&FROM_ID=' + sId, '_blank','width=500, height=700, left=720, top=200, resizable=no'); 
	    }
	    
	    /* localStorage 저장하기 */
	     function makeProducts() {
			
	    	// 클릭한 상품의 IDX 저장
	    	let pro_id = '${productInfo.PD_IDX}';
			
			if(pro_id != "" && pro_id != null){
			
				//******************** 최근 본 상품 보관함 생성 ************************
				// 로컬스토리지에 저장할 키의 이름
				const localStorageKey = 'products';
				
				// 기존의 저장된 키워드 배열 가져오기
				let products = JSON.parse(localStorage.getItem(localStorageKey)) || [];
				
				// 포함되어 있지 않을 경우 새로운 상품 목록 추가하기 
				if (!products.includes(products)) {
					products.push(pro_id);
				}
				
				// 최대 갯수를 초과하는 경우 가장 오래된 데이터부터 제거
				if (products.length > 10) {
					products = products.slice(products.length - 10);
				}
				
				// 로컬스토리지에 업데이트된 키워드 배열 저장
				localStorage.setItem(localStorageKey, JSON.stringify(products));
				//********************  최근 본 상품 보관함 생성 ************************
			}
		}
	</script>
	<script type="text/javascript">
	function addToWishList(){
		var session = '${sessionScope.US_ID}';
		if (session === '') {
			if(confirm("로그인이 필요합니다. \n로그인 페이지로 이동합니다.")){
				window.location.href = 'login'; // 로그인 페이지로 이동
			}
			return;	
		}
		
		var productId = '${productInfo.PD_IDX}';
	 	
	 		$.ajax({
             url: 'addToWishlist',
             type: 'POST',
             data: {
                 productId: productId
             }, 
             dataType : "JSON",
             success: function(response) {
				$('#goWish').removeClass("active")
				$('#goWish').addClass(response.wish_yn)
				
// 				if (result == "NotLoggedIn") {
// 					alert("로그인이 필요합니다. \n로그인 페이지로 이동합니다.");
// 					window.location.href = 'login'; // 로그인 페이지로 이동
// 				}
				
// 				if(result == "Removed"){
// 					alert("해당 상품을 찜목록에서 제거하였습니다!");
// 				} else if (result == "Success") {
// 					if (confirm("선택하신 상품이 찜목록에 등록되었습니다!\n찜목록을 확인하시겠습니까?")) {
// 						window.location.href = 'myStore';
// 					} 
// 				} else if (result == "fail") {
// 					alert("실패");
// 				} 
             }
 		});
    }
	</script>
</body>
</html>
