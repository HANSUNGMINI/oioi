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
    <title> 경매상품등록 </title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
   	<script src="https://unpkg.com/@yaireo/tagify"></script>
	<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
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
<%-- 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css"> --%>
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
	
	<!-- Test -->
	<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
	
</head>
<body class="js">

	<header><jsp:include page="../INC/auctionTop.jsp"></jsp:include></header>
	
		<!-- Breadcrumbs -->
		<div class="breadcrumbs">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="bread-inner">
							<ul class="bread-list">
								<li><a href="index1.html">Home<i class="ti-arrow-right"></i></a></li>
								<li class="active"><a href="blog-single.html">경매 상품 등록</a></li>
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
						<div class="login-form">
							<h2>경매 상품 등록</h2>
							<!-- Form -->
							<form class="regForm">
								<ul>
									<li class="preView">
										<label> 상품 이미지<small>(최대 5장)</small></label>
										<input type="file" accept="image/*" multiple id="addfile">
										<img src="${pageContext.request.contextPath}/resources/images/submitIMG.png" class="tempImg addImg">
										
									</li>
									<li>
										<label> 상품명</label>
										<input type="text" placeholder="상품명을 입력하여 주세요">
									</li>
									<li>
										<label> 카테고리</label>
										<input type="text">
									</li>
									<li>
										<label> 태그(선택)</label>
										<input class="tagify" placeholder="태그를 입력해주세요" maxlength="6">
										
										<script>
											var input = document.querySelector('.tagify')
											tagify = new Tagify(input, {
												maxTags: 5, // 최대 허용 태그 갯수
											})
											  
											// 태그가 추가되면 이벤트 발생
											tagify.on('add', function() {
											  console.log(tagify.value); // 입력된 태그 정보 객체
											})
										</script>
									</li>
									<li>
										<label> 상품상태 </label>
										<ul>
											<li><input type="radio" name="condition" checked> 미개봉</li>
											<li><input type="radio" name="condition"> 사용감 적음</li>
											<li><input type="radio" name="condition"> 사용감 많음</li>
										</ul>
									</li>
									<li>
										<label> 가격 </label>
										<input type="text" id="price" placeholder="원"><br>
										<label class="checkbox-inline" for="2"><input name="deal" id="2" type="checkbox" checked>가격 제안 가능</label>
									</li>
									<li>
										<label> 상품설명</label>
										<textarea placeholder="브랜드, 모델명, 구매시기를 자세히 기입하여 주십시오"></textarea>
									</li>
									<li>
										<label> 거래 방식 </label>
										<ul>
											<li><input type="radio" name="trade" checked> 모두 가능</li>
											<li><input type="radio" name="trade"> 직거래만 가능</li>
											<li><input type="radio" name="trade"> 택배거래만 가능</li>
										</ul>
									</li>
									<li>
										<label> 안전 거래 여부 </label>
										<label class="checkbox-inline" for="2"><input name="safeTrade" id="2" type="checkbox" checked>안전 거래 사용</label>
									</li>															
								</ul>
							</form>
							<input type="button" id="subimit" value="등록하기">
							<!--/ End Form -->
						</div>
					</div>
		</section>
		<!--/ End Login -->
		
		<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
 
	<!-- Jquery -->
	<script>
		$(function() {
			$(".addImg").on("click",function(){
				$('#addfile').click();
			});
			
			
			$("#addfile").on("change",function(event){
				for (var image of event.target.files) {
					let reader = new FileReader();

		          reader.onload = function(event) {
		            var img = document.createElement("img");
		            img.setAttribute("src", event.target.result);
		            img.setAttribute("class", "tempImg");
		           	$(".preView").append(img);
		          };
		          
		          reader.readAsDataURL(image);
				}
			});
			
		}); //ready
	</script>
    
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
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/ytplayer.min.js"></script> --%>
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
	
	
	<!-- Test -->

	
</body>
</html>