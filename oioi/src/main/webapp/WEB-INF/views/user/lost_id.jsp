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
    <title>아이디 찾기</title>
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
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	
	<script>
	let checkAuthNumResult = false;
	let serverAuthNum = "";
	
	
	function isValidEmail(email) { //이메일 유효성 검사
		return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email);
	}
	
	function isValidName(name) { // 이름 유효성 검사
		return  /^[가-힣&&[^ㄱ-ㅎㅏ-ㅣ]{2,5}$/.test(name);
	}
	
	function isValidPhoneNumber(phoneNumber) { // 휴대폰 번호 유효성 검사
		return /^[0-9]{10,11}$/.test(phoneNumber);
	}
	
	let isPhoneAuthButtonCreated = false;
	function phoneAuth() {
		let user_name2 = $("#user_name2").val();
	    let user_phone = $("#user_phone").val();
	    
	    if (!isValidName(user_name2) || user_name2 == "") {
	        alert("이름을 확인해주세요.");
	        document.fr.user_name2.focus();
	        return false;
	    }

	    if (!isValidPhoneNumber(user_phone) || user_phone == "") {
	        alert("전화번호를 확인해주세요.");
	        document.fr.user_phone.focus();
	        return false;
	    }
		
		$.ajax({
			
			type : "POST",
			url : "send-user-id",
			contentType: "application/json",
			data : JSON.stringify({"user_name2": user_name2, "user_phone": user_phone}),
			dataType :"json",
			success : function(response){
		        if (response.success) {
		            
		            alert("회원님의 ID 정보가 문자로 전송되었습니다.");
		            window.location.href = "${pageContext.request.contextPath}/login"
		        } else {
		            alert("해당 이름과 전화번호로 등록된 회원이 없습니다.");
		        }
				
			},
			error : function() {
				alert("전화번호 인증에 실패했습니다. 다시 시도해주세요.");
			}
			
		});
	}
	
	function phoneAuthCheck(){
		if($("#auth_num").val() !== serverAuthNum){
			alert("인증번호를 확인해주세요.");
			return false;
		} else {
			alert("인증되었습니다.");
			checkAuthNumResult = true;
		}
	}
	
	</script>
</head>
<style>
#check_email:hover {
	text-size-adjust: 100%;
	box-sizing: inherit;
	touch-action: manipulation;
	font: inherit;
	margin: 0;
	overflow: visible;
	cursor: pointer;
	font-family: 'Poppins', sans-serif;
	position: relative;
	font-weight: 500;
	font-size: 14px;
	transition: all 0.4s ease;
	z-index: 5;
	padding: 13px 32px;
	border-radius: 0px;
	text-transform: uppercase;
	text-decoration: none;
	border: none;
	display: inline-block;
	height: 45px;
	line-height: 20px;
	color: #fff;
	background: #34A853;
}

#check_email {
	width: 35%;
	box-sizing: inherit;
	touch-action: manipulation;
	font: inherit;
	margin: 0;
	overflow: visible;
	cursor: pointer;
	font-family: 'Poppins', sans-serif;
	position: relative;
	font-weight: 500;
	font-size: 14px;
	background: #333;
	transition: all 0.4s ease;
	z-index: 5;
	padding: 13px 32px;
	border-radius: 0px;
	text-transform: uppercase;
	border: none;
	display: inline-block;
	height: 45px;
	color: #fff !important;
	line-height: 20px;
}

#check_tel:hover {
	text-size-adjust: 100%;
	box-sizing: inherit;
	touch-action: manipulation;
	font: inherit;
	margin: 0;
	overflow: visible;
	cursor: pointer;
	font-family: 'Poppins', sans-serif;
	position: relative;
	font-weight: 500;
	font-size: 14px;
	transition: all 0.4s ease;
	z-index: 5;
	padding: 13px 32px;
	border-radius: 0px;
	text-transform: uppercase;
	text-decoration: none;
	border: none;
	display: inline-block;
	height: 45px;
	line-height: 20px;
	color: #fff;
	background: #34A853;
}

#check_tel {
	width: 35%;
	box-sizing: inherit;
	touch-action: manipulation;
	font: inherit;
	margin: 0;
	overflow: visible;
	cursor: pointer;
	font-family: 'Poppins', sans-serif;
	position: relative;
	font-weight: 500;
	font-size: 14px;
	background: #333;
	transition: all 0.4s ease;
	z-index: 5;
	padding: 13px 32px;
	border-radius: 0px;
	text-transform: uppercase;
	border: none;
	display: inline-block;
	height: 45px;
	color: #fff !important;
	line-height: 20px;
}

</style>
<body class="js">

	<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
	
		<!-- Breadcrumbs -->
		<div class="breadcrumbs">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="bread-inner">
							<ul class="bread-list">
								<li><a href="index1.html">홈<i class="ti-arrow-right"></i></a></li>
								<li class="active"><a href="login">로그인<i class="ti-arrow-right"></i></a></li>
								<li class="active"><a href="lost_id">아이디찾기</a></li>
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
							<h2>아이디 찾기</h2>
							<p>아이디를 찾기 위해 본인확인을 진행해주세요.</p>
							<!-- Form -->
							<form class="form" method="post" action="lost_id" name="fr">
								<div class="row">
									<div class="col-12">
										<div class="nav-main">
											 <!-- Tab Nav -->
                              				<ul class="nav nav-tabs" id="myTab" role="tablist">
			                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#lost_id" role="tab">이메일로 ID 찾기</a></li>
			                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#lost_id2" role="tab">전화번호로 ID 찾기</a></li>
			                                </ul>
										</div>
										<div class="tab-content" id="myTabContent">
											<div class="tab-pane fade show active" id="lost_id" role="tabpanel">
												<div class="tab-single">
													<div class="form-group">
														<input type="text" name="user_name" id="user_name" maxlength="5" placeholder="이름" >
														<div style="display: flex">
															<input type="email" name="user_email" id="user_email" placeholder="이메일" >
															<input type="submit" name="check_email" class="check_email" id="check_email" value="인증하기">
														</div>
													</div>
												</div>
											</div>
											<div class="tab-pane fade" id="lost_id2" role="tabpanel">
                                   				<div class="tab-single">
													<div class="form-group">
															<input type="text" name="user_name2" id="user_name2" maxlength="5" placeholder="이름" >
														<div style="display: flex">
															<input type="text" name="user_phone" id="user_phone" placeholder="전화번호" maxlength="11" >
															<input type="button" class="check_tel" id="check_tel" value="문자전송" onclick="phoneAuth()">
														</div>
													</div>
												</div>
											</div>
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
</body>
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
</html>
