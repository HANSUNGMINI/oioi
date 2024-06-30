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
											<c:choose>
												<c:when test="${empty report_RP_IMG2}">
													<li data-thumb="<%= request.getContextPath() %>/resources/upload/${report_RP_IMG1}" rel="adjustX:10, adjustY:">
														<img src="<%= request.getContextPath() %>/resources/images/no-image01.gif" alt="#">
													</li>
												</c:when>
												<c:otherwise>
													<li data-thumb="<%= request.getContextPath() %>/resources/upload/${report_RP_IMG1}" rel="adjustX:10, adjustY:">
														<img src="<%= request.getContextPath() %>/resources/upload/${report_RP_IMG1}" alt="#">
													</li>
												</c:otherwise>
											</c:choose>
											<c:if test="${not empty report_RP_IMG2}">
												<li data-thumb="<%= request.getContextPath() %>/resources/upload/${report_RP_IMG2}">
													<img src="<%= request.getContextPath() %>/resources/upload/${report_RP_IMG2}" alt="#">
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
										<h4>신고 내용 상세</h4>
									</div>
									<div class="color" style="margin-top: 30px;">
										<p class="price"><span class="discount">신고자</span> : ${report.TO_US_ID}</p>
										<p class="price"><span class="discount">신고 대상자</span>: ${report.FROM_US_ID}</p><br>
									</div>
									<hr>
									<div class="size">
										<h3>내용</h3>
										<ul class="content">
											<li>신고 카테고리 : <b>${report.RP_CATEGORY}</b></li>
											<li>상세 내용 : <b>${report.RP_CONTENT}</b></li>
											<li>신고 날짜 : <b>${report.RP_TIME}</b></li>
											<li>
												<select id="RP_STATUS" onchange="changeStatus()">
													<c:forEach var="item" items="${rpStatusSelectBox}">
														<option value="${item.code}" <c:if test="${item.value eq report.RP_STATUS}"> selected</c:if>> ${item.value }</option>
													</c:forEach>
												</select>
											</li>
										</ul>
									</div>
									<!--/ End Size -->
									<!-- Product Buy -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	<script>
		function changeStatus(){
			$.ajax({
				type : "POST",
				url : "reportStatus",
				data : {
					"RP_STATUS" : $("#RP_STATUS").val(),
					"RP_IDX" : "${report.RP_IDX}",
					"FROM_US_ID" : "${report.FROM_US_ID}",
				},
				dataType : "JSON",
				success : function (response) {
					if(response > 0 ) {
						alert("성공적으로 변경되었습니다!")
					} else {
						alert("변경에 실패했습니다")
					}
				}
			})
		}
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
