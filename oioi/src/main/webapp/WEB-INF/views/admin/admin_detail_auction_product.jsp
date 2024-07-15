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
    <script src = "${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<!-- Favicon -->
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
	<style>
		.flex-control-thumbs li {
			margin : 0px !important;
		}
		.content li{
			display : block !important;
		}
	
	</style>
	<script>
		let status = '';
		$(function(){
			
			status = $("#APD_STATUS").val();
			
			const rejection = $("#APD_REJECTION").val();
			// 거래 완료 상태 시 셀렉트박스 dsiabled
			if (status === 'APD09') {
				$('#APD_STATUS').prop('disabled', true).niceSelect('update');
				$('#APD_REJECTION').prop('disabled', true).niceSelect('update');
			}
			
			$("#regitBtn").on("click", regDnum);
		})
		
		function regDnum(){
			$.ajax({
	       		url : "regDnum",
	       	 	type : "POST",
	       	 	data : {
	       			APD_IDX : "${param.target}",
	       			US_ID : "${product.APD_OWNER}",
	       			DV_NUM : $("#dNum").val(),
	       	 	},
	       	 	dataType : "JSON",
	       	 	success : function(response){
		       	 	if(response > 0 ) {
						alert("성공적으로 등록되었습니다!")
						location.reload();
		       	 	} else {
		       	 		alert("등록실패")	
		       	 	}
	       	 	}
			})
			
		}
		function confirmUpdate() {
			if(status == 'APD05' || status == 'APD06' || status == 'APD07') {
				let b = confirm("경매가 이미 진행중입니다. 변경하시겠습니까?");
				if(b == false) {
					return;
				}
			}
			
			chageProduct()
		}
		
		function chageProduct() {
						
			$.ajax({
				type : "POST",
				url : "updateAPD",
				data : {
					"APD_STATUS" : $("#APD_STATUS").val(),
					"APD_REJECTION" : $("#APD_REJECTION").val(),
					"APD_IDX" : "${param.target}",
					"APD_DEADLINE" : "${product.APD_DEADLINE}",
					"APD_START_PRICE" : "${product.APD_START_PRICE}"
				},
				dataType : "JSON",
				success : function (response) {
					
					if(response > 0 ) {
						alert("성공적으로 변경되었습니다!")
						
						if($("#APD_STATUS").val() == "APD05") {
// 							var socket = new WebSocket('ws://localhost:8081/oi/push');
							let socket = new WebSocket('ws://c3d2401t1.itwillbs.com/oioi/push');
							socket.onopen = function (){
								socket.send(toJsonString("toUsers", "registAPD"));
							};
						}
						
						location.reload();
					} else if (response == -1) {
						alert("이미 등록된 상품입니다")
					} else {
						alert("변경에 실패했습니다. 다시 시도하여 주십시오");
						location.reload();
					}
					
				} // success 끝
			})
		}
		
		function regBanner() {
			$.ajax({
				type : "POST",
				url : "RegMainBanner",
				data : {
					"APD_IDX" : "${param.target}",
				},
				dataType : "JSON",
				success : function (response) {
					
					if(response > 0 ) {
						alert("등록되었습니다!")
					} else {
						alert("등록에 실패했습니다")
					}
				} // success 끝
			})
		}
		
		function toJsonString(type, msg){
			let data = {
				type : type,
				msg : msg
			};
			return JSON.stringify(data);
		}
		
	</script>
</head>
<body class="js">
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
											<li data-thumb="<%= request.getContextPath() %>/resources/upload/${product.image1}" rel="adjustX:10, adjustY:">
												<img src="<%= request.getContextPath() %>/resources/upload/${product.image1}" alt="#">
											</li>
											<c:if test="${not empty product.image2}">
												<li data-thumb="<%= request.getContextPath() %>/resources/upload/${product.image2}">
													<img src="<%= request.getContextPath() %>/resources/upload/${product.image2}" alt="#">
												</li>
											</c:if>
											<c:if test="${not empty product.image3}">
												<li data-thumb="<%= request.getContextPath() %>/resources/upload/${product.image3}">
													<img src="<%= request.getContextPath() %>/resources/upload/${product.image3}" alt="#">
												</li>
											</c:if>
											<c:if test="${not empty product.image4}">
												<li data-thumb="<%= request.getContextPath() %>/resources/upload/${product.image4}">
													<img src="<%= request.getContextPath() %>/resources/upload/${product.image4}" alt="#">
												</li>
											</c:if>
											<c:if test="${not empty product.image5}">
												<li data-thumb="<%= request.getContextPath() %>/resources/upload/${product.image5}">
													<img src="<%= request.getContextPath() %>/resources/upload/${product.image5}" alt="#">
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
										<h4>${product.APD_NAME}</h4>
										<p class="cat" style="margin-top: -1px;">Category :<a href="#">${product.APD_CATEGORY}</a></p>
									</div>
									<div class="color" style="margin-top: 30px;">
										<p class="price"><span class="discount">시작 가격 </span>￦<fmt:formatNumber value="${product.APD_START_PRICE}" pattern="#,###"/></p>
										<p class="price"><span class="discount">즉시구매 가격 </span>￦<fmt:formatNumber value="${product.APD_BUY_NOW_PRICE}" pattern="#,###"/></p><br>
									</div>
									<hr>
									<div class="size">
										<h3>등록 정보</h3>
										<ul class="content">
											<li><p class="one"><span>등록 유저 : ${product.APD_OWNER}</span></p></li>
											<li>
												<select id="APD_STATUS">
													<c:forEach var="item" items="${apdStatusSelectBox}">
														<option value="${item.code}" <c:if test="${item.value eq product.APD_STATUS}"> selected</c:if>> ${item.value} </option>
													</c:forEach>
												</select>
											</li>
											<li>
												<select id="APD_REJECTION">
													<c:forEach var="item" items="${apdRejectionSelectBox}">
														<option value="${item.code }" <c:if test="${item.value eq product.APD_REJECTION}"> selected</c:if>> ${item.value }</option>
													</c:forEach>
												</select>
											</li><br><br><br>
											<li><span>상품 상태 : <b>${product.APD_CONDITION}</b></span></li>
											<li><span>등록 날짜 : <b>${product.APD_REG_DATE}</b></span></li><br>
											<c:if test="${product.APD_STATUS eq '경매종료'}">
												<li>
												<span>운송장 번호 등록 : <input type="text" placeholder="입력" id="dNum"><input type="button" id="regitBtn" value="등록"></span>
												</li>
											</c:if>
											<c:if test="${not empty product.APD_DELIVERY}">
												<li><span>운송장 번호 : <b>${product.APD_DELIVERY}</b></span></li><br>
											</c:if>
										</ul>
									</div>
									<!--/ End Size -->
									<!-- Product Buy -->
									<div class="product-buy">
										<ul class="nav nav-tabs" id="myTab" role="tablist">
											<li class="nav-item"><a onclick="confirmUpdate()">수정하기</a></li>
											<c:if test="${product.APD_STATUS eq '상품등록' || product.APD_STATUS eq '입찰중'}">
												<li class="nav-item"><a onclick="regBanner()">메인 배너 등록</a></li>
											</c:if>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	<script>
		
	</script>
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
