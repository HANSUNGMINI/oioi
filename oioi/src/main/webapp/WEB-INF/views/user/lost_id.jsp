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
	$(function() {
		document.fr.onsubmit = function() {
			if (!isValidName($("#phone_member_name").val())) { // 이름 확인
		    	alert("이름을 확인해주세요.");
		        document.fr.phone_member_name.focus();
		        return false;
		    } else if (!isValidPhoneNumber($("#member_phone").val())) {
		    	alert("전화번호를 확인해주세요.");
		    	document.fr.member_phone.focus();
		    	return false;
		    } else if (serverAuthNum == "") { // 인증번호 요청 확인
		        alert("인증번호 요청을 먼저 해주세요.");
		        document.fr.member_phone.focus();
		        return false;
		    } else if ($("#auth_num").val() == "") {
		    	alert("인증번호를 입력해주세요");
		    	document.fr.auth_num.focus();
		        return false; 
		    } else if($("#auth_num").val() !== serverAuthNum){
				alert("인증번호를 확인해주세요.");
				return false;
			} else if ($("#auth_num").val() == serverAuthNum) {
				alert("인증되었습니다.");
				checkAuthNumResult = true;
			} else if (!checkAuthNumResult) {
		    	alert("전화번호 인증을 완료해주세요.");
		        return false; 
		    }
		}
		
		
	
	}); 

	function phoneAuth() {
		let member_phone = $("#member_phone").val();
		
		if (!isValidPhoneNumber(member_phone) || member_phone == "") {
			alert("전화번호를 확인해주세요.");
			document.fr.member_phone.focus();
			return false;
		}
		
		$.ajax({
			
			type : "POST",
			url : "send-one",
			data : {
				"member_phone" : member_phone
			},
			dataType :"json",
			success : function(response){
		        if (response.success) {
		            serverAuthNum = response.auth_num;  // 서버에서 받은 인증번호를 저장
		            
		            alert("인증번호가 전송되었습니다.");
		            
		            
		        } else {
		            alert("인증번호 전송에 실패했습니다.");
		        }
				
			},
			error : function() {
				alert("전화번호 인증에 실패했습니다. 다시 시도해주세요.");
			}
			
		});
	}
	
	

	function isValidName(name) { // 이름 유효성 검사
	    return /^[가-힣]{2,5}$/.test(name);
	}

	function isValidPhoneNumber(phoneNumber) { // 휴대폰 번호 유효성 검사
		return /^[0-9]{10,11}$/.test(phoneNumber);
	}
	</script>
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
										<div class="form-group">
											<h4>본인확인 이메일로 인증</h4><br>
											<label>이메일<span>*</span></label>
											<div style="display: flex">
												<input type="email" name="user_email" id="user_email" placeholder="이메일" >
												<input type="button" name="check_email" class="check_email" id="check_email" value="인증메일발송" onclick="sendAuthMail()">
											</div>
											<div id="authBox" style="display: flex">
												<input type="text" placeholder="인증번호" id="mail_auth_num" name="mail_auth_num" maxlength="6"/>
											</div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>전화번호<span>*</span></label>
											<div style="display: flex">
												<input type="text" name="user_phone" id="user_phone" placeholder="전화번호" maxlength="11" >
												<input type="button" class="check_tel" id="check_tel" value="문자전송" onclick="phoneAuth()">
											</div>
											<div id="authBox" style="display: flex">
												<input type="text" placeholder="인증번호" id="auth_num" name="auth_num" maxlength="4"/>
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
</html>
