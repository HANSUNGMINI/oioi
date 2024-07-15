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
    <title>비밀번호 변경</title>
	<!-- Favicon 
	     인터넷 위에보면 아이콘 넣기 가능 이미지만 바꾸며ㅑㄴ댐-->
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
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
 <script type="text/javascript">
        let checkPasswdResult = false;
        let checkPasswd2Result = false;

        $(document).ready(function() {
            const id = "<%= request.getParameter("user_id") %>";

            $("#user_passwd").keyup(function() {
                checkPassword(id);
            });

            $("#user_passwd2").keyup(function() {
                checkSamePassword();
            });

            $("form").on("submit", function() {
                return validateForm();
            });
        });

        function checkPassword(id) {
            let passwd = $("#user_passwd").val();
            let msg = "";
            let color = "";
            let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;

            if (lengthRegex.test(passwd)) {
                let engUpperRegex = /[A-Z]/;
                let engLowerRegex = /[a-z]/;
                let numRegex = /\d/;
                let specRegex = /[!@#$%^&*]/;
                let count = 0;
                if (engUpperRegex.test(passwd)) count++;
                if (engLowerRegex.test(passwd)) count++;
                if (numRegex.test(passwd)) count++;
                if (specRegex.test(passwd)) count++;

                switch (count) {
                    case 4: msg = "안전"; color = "green"; checkPasswdResult = true; break;
                    case 3: msg = "보통"; color = "orange"; checkPasswdResult = true; break;
                    case 2: msg = "위험"; color = "red"; checkPasswdResult = true; break;
                    default: msg = "영문 대소문자, 숫자, 특수문자 중 2개 이상을 포함시켜주세요."; color = "red"; checkPasswdResult = false;
                }
            } else {
                msg = "영문 대소문자, 숫자, 특수문자 중 2개 이상을 포함시켜주세요.";
                color = "red";
                checkPasswdResult = false;
            }

            if (passwd.includes(id)) {
                msg = "비밀번호에 아이디가 포함되었습니다.";
                color = "red";
                checkPasswdResult = false;
            }

            $("#checkPwResult").text(msg);
            $("#checkPwResult").css("color", color);
        }

        function checkSamePassword() {
            let passwd = $("#user_passwd").val();
            let passwd2 = $("#user_passwd2").val();

            if (passwd === passwd2) {
                $("#checkPwResult").text("*비밀번호가 일치합니다.");
                $("#checkPwResult").css("color", "blue");
                checkPasswd2Result = true;
            } else {
                $("#checkPwResult").text("*비밀번호가 일치하지 않습니다.");
                $("#checkPwResult").css("color", "red");
                checkPasswd2Result = false;
            }
        }

        function validateForm() {
            if (!checkPasswdResult) {
                alert("새 비밀번호를 확인해주세요!");
                $("#user_passwd").focus();
                return false;
            } else if (!checkPasswd2Result) {
                alert("비밀번호가 일치하지 않습니다!");
                $("#user_passwd2").focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
	<%
    // URL 파라미터에서 user_id 값을 가져옵니다.
    String userId = request.getParameter("user_id");
	%>
	
	<!-- Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="bread-inner">
						<ul class="bread-list">
							<li><a href="index1.html">홈<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="login">로그인<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="lost_passwd">비밀번호 찾기<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="change_passwd">비밀번호 변경하기</a></li>
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
						<h2>비밀번호 변경</h2>
						<p>새로운 비밀번호를 설정해주세요</p>
						<!-- Form -->
						<form class="form" method="post" action="change_passwd">
							<div class="row">
								<div class="col-12">
									<div class="form-group">
										<input type="hidden" class="user_id" name="user_id" value="<%= userId %>" placeholder="아이디">
									</div>
								</div>
								<div class="col-12">
									<div class="form-group">
										<label>새 비밀번호<span>*</span></label>
										<input type="password" class="user_passwd" name="user_passwd" id="user_passwd" placeholder="새 비밀번호">
									</div>
								</div>
								<div class="col-12">
									<div class="form-group">
										<label>새 비밀번호 확인<span>*</span></label>
										<input type="password" class="user_passwd2" name="user_passwd2" id="user_passwd2" placeholder="새 비밀번호 확인">
										<div id="checkPwResult"></div>
									</div>
								</div>
								<div class="col-12">
									<div class="form-group login-btn">
										<button class="btn" type="submit">확인</button>
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
