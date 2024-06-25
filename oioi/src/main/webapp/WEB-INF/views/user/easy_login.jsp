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
    <title> 간편 로그인 </title>
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
	 <!-- 카카오 JavaScript SDK -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
</head>
<style>
.login-option {
	text-align: center;
	align-items: center;
}

.login-option {
	display: inline-block;
	margin: 0 25px;
}

.login-images {
    display: flex;
    justify-content: center;
    flex-direction: column; /* 이미지를 세로로 배치합니다 */
    gap: 20px; /* 이미지 사이의 간격을 설정합니다 */
}

.login-images img {
    width: 250px;
    height: auto;
    display: block;
    margin: 0 auto; /* 이미지를 중앙에 배치합니다 */
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
								<li><a href="./">Home<i class="ti-arrow-right"></i></a></li>
								<li class="active"><a href="easy_login">간편 로그인</a></li>
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
							<h2>간편 로그인</h2>
							<p>회원가입 없이 빠르게 로그인하세요</p>
							<!-- Form -->
							<form class="form" method="post" action="easy_login">
								<div class="row">
									<div class="col-12">
										<div class="login-images">
											<a href="#" id="kakao-login-btn"><img src="${pageContext.request.contextPath}/resources/images/kakao.png"></a>
											<a href="#" id="naver-login-btn"><img src="${pageContext.request.contextPath}/resources/images/naver.png"></a>
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
 	<script>
 // 카카오 SDK 초기화
 	Kakao.init('76f6b3828f0b7b30e9de07f0dcc7f3ed'); // 발급받은 JavaScript 키를 입력합니다.

 	// 카카오 로그인 버튼 클릭 이벤트
 	document.getElementById('kakao-login-btn').addEventListener('click', function(e) {
 	    e.preventDefault();
 	    Kakao.Auth.login({
 	        success: function(authObj) {
 	            // 로그인 성공 시 액세스 토큰을 서버로 전송
 	            fetch('kakao_login', {
 	                method: 'POST',
 	                headers: {
 	                    'Content-Type': 'application/json'
 	                },
 	                body: JSON.stringify({ token: authObj.access_token })
 	            })
 	            .then(response => {
 	                if (!response.ok) {
 	                    throw new Error('네트워크 응답 실패!');
 	                }
 	                return response.json();
 	            })
 	            .then(data => {
 	                if (data.success) {
 	                    // 서버에서 사용자 정보를 성공적으로 가져왔을 때 처리할 내용
 	                    console.log('유저 정보 :', data.user);
 	                    // 예: 메인 페이지로 이동
 	                    window.location.href = './';
 	                } else {
 	                    alert('유저 정보 패치 실패!');
 	                }
 	            })
 	            .catch(error => {
 	                console.error('Error:', error);
 	                alert('에러 발생! : ' + error.message);
 	            });
 	        },
 	        fail: function(err) {
 	            alert('카카오 로그인 실패! : ' + JSON.stringify(err));
 	        }
 	    });
 	});
 	
 // 네이버 로그인 초기화
	var naverLogin = new naver.LoginWithNaverId({
	    clientId: 'jYR_TimjsvzQr8BV06yT',
	    callbackUrl: 'http://localhost:8081/oi/easy_login',
	    isPopup: false,
	    callbackHandle: true
	});
	naverLogin.init();

	// 네이버 로그인 버튼 클릭 이벤트
	document.getElementById('naver-login-btn').addEventListener('click', function(e) {
	    e.preventDefault();
	    naverLogin.getLoginStatus(function(status) {
	        if (status) {
	            // 로그인 성공 시 액세스 토큰을 서버로 전송
	            fetch('naver_login', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify({ token: naverLogin.accessToken.accessToken })
	            })
	            .then(response => {
	                if (!response.ok) {
	                    throw new Error('네트워크 응답 실패!');
	                }
	                return response.json();
	            })
	            .then(data => {
	                if (data.success) {
	                    // 서버에서 사용자 정보를 성공적으로 가져왔을 때 처리할 내용
	                    console.log('유저 정보 :', data.user);
	                    // 예: 메인 페이지로 이동
	                    window.location.href = './';
	                } else {
	                    alert('유저 정보 패치 실패!');
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	                alert('에러 발생! : ' + error.message);
	            });
	        } else {
	            alert('네이버 로그인 실패!');
	        }
	    });
	});
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
