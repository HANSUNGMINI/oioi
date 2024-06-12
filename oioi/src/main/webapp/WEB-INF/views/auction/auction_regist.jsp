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
				<div class="row"> 
					<div class="col-lg-6 offset-lg-3 col-12">
						<div class="login-form">
							<h2>경매 상품 등록</h2>
							<p>상품 정보를 입력해주세요</p>
							<!-- Form -->
							<form class="form" method="post" action="register" name="fr">
								<div class="row">
									<div class="col-12">
										<div class="form-group">
											<label>카테고리<span>*</span></label>
											<input type="text" name="member_id" id="member_id" placeholder="카테고리" >
											<select id="manufacturer" name="car_brand" class="form-control" required>
				                                <option value="">대분류</option>
				                                <c:forEach var="cate1" items="${cate1}">
				                                    <option value="${cate1.CTG_CODE}">${cate1.CTG_NAME}</option>
				                                </c:forEach>
				                            </select>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>상품명<span>*</span></label>
											<input type="text" name="member_id" id="member_id" placeholder="상품명" >
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>상품설명<span>*</span></label>
											<input type="text" name="member_name" id="member_name" maxlength="5" placeholder="상품설명" >
										</div>
									</div>
									<div class="col-12" style="margin-bottom: 15px;">
									    <div class="">
									        <label>상품상태<span style="color: red; margin-left: 5px;">*</span></label>
									        <div style="display: flex; align-items: center;">
									            <label for="male" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="male" name="gender" value="male" >새상품(미사용)
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;" >
									                <input type="radio" id="female" name="gender" value="female" size="5">사용감 없음
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="female" name="gender" value="female">사용감 적음
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="female" name="gender" value="female">사용감 많음
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="female" name="gender" value="female">고장/파손 상품
									            </label>
									        </div>
									    </div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>판매시작가<span>*</span></label>
											<input type="text" name="member_nick" id="member_nick" maxlength="16" placeholder="시작가" >
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>즉시판매가<span>*</span></label>
											<input type="text" name="member_nick" id="member_nick" maxlength="16" placeholder="즉시판매가" >
										</div>
									</div>
									<div class="col-12" style="margin-bottom: 15px;">
									    <div>
									        <label>거래방식<span style="color: red; margin-left: 5px;">*</span></label>
									        <div style="display: flex; align-items: center;">
									            <label for="male" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="male" name="gender" value="male" >모두가능
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;" >
									                <input type="radio" id="female" name="gender" value="female" size="5">직거래만 가능
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="female" name="gender" value="female">택배거래만 가능
									            </label>
									        </div>
									    </div>
									</div>
									<div class="col-12" style="margin-bottom: 15px;">
										<div>
											<label>입찰마감기한<span style="color: red; margin-left: 5px;">*</span></label>
											<div style="display: flex; align-items: center;">
									            <label for="male" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="male" name="gender" value="male" >15일
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;" >
									                <input type="radio" id="female" name="gender" value="female" size="5">30일
									            </label>
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="female" name="gender" value="female">60일
									            </label>
									        </div>
										</div>
									</div>
									<div class="col-12">
										<div class="">
											<label>상품 이미지(최대 5장)<span style="color: red; margin-left: 5px;">*</span></label>
											<input type="file" accept="image/*" multiple id="addfile" style="width: 80%;" class="btn">
											<img src="${pageContext.request.contextPath}/resources/images/submitIMG.png" class="tempImg addImg">
										</div>
									</div>
									<div class="col-12">
										<div class="form-group login-btn">
											<button class="btn" type="submit" onsubmit="submit()">상품등록</button>
										</div>
									</div>
								</div>
							</form>
							<!--/ End Form -->
						</div>
					</div>
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