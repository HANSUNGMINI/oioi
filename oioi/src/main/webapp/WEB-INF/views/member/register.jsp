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
    <title> 로그인 </title>
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
	<!-- Jquery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript">
	let checkPasswdResult = false;
	let checkPasswd2Result = false;
	let checkAuthNumResult = false;
	let serverAuthNum = "";
	
	$(function() {
		
		document.querySelector("#member_id").onclick = function() { //아이디 중복체크&유효성검사 새창 오픈
			window.open("check_id", "아이디 중복확인", "width=600, height=300, top=150, left=650");
		};
		
// 		document.querySelector("#member_email").onclick = function() { //아이디 중복체크&유효성검사 새창 오픈
// 			window.open("check_id", "이메일 인증", "width=600, height=300, top=150, left=650");
// 		};
		
		$("#member_passwd").keyup(function() { // 비밀번호 유효성 검사
			
		    let passwd = $("#member_passwd").val();
			
		    let msg = "";
			let color = "";
			
			let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
		    
		    if(lengthRegex.exec(passwd)) {
		    	let engUpperRegex = /[A-Z]/; // 대문자
		    	let engLowerRegex = /[a-z]/; // 소문자
		    	let numRegex = /\d/; // / [0-9]
		    	let specRegex = /[!@#$%^&*]/; // 특수문자
		    	
		    	let count = 0;
		    	
		    	if(engUpperRegex.exec(passwd)) { count++; } // 대문자 포함할 경우
		    	if(engLowerRegex.exec(passwd)) { count++; } // 소문자 포함할 경우
		    	if(numRegex.exec(passwd)) { count++; }      // 숫자 포함할 경우
		    	if(specRegex.exec(passwd)) { count++; }     // 특수문자 포함할 경우
 		    	
		    	switch (count) {
					case 4: msg = "안전"; color = "GREEN"; checkPasswdResult = true; break;
					case 3: msg = "보통"; color = "ORANGE"; checkPasswdResult = true; break;
					case 2: msg = "위험"; color = "RED"; checkPasswdResult = true; break;
					case 1:
					case 0: 
						msg = "영문 대소문자,숫자,특수문자 중 2개 이상을 포함시켜주세요."; 
						color = "RED"; 
						checkPasswdResult = false;
				}
		    	
		    } else {
				msg = "영문 대소문자,숫자,특수문자 중 2개 이상을 포함시켜주세요."; 
				color = "RED";
				
		    	checkPasswdResult = false;
		    }
		    
			if(passwd.search($("#member_id").val()) > -1) {
				msg = "비밀번호에 아이디가 포함되었습니다.";
				color = "RED";
				
				checkPasswdResult = false;
		    }    
			
			
		    $("#checkPwResult").text(msg);
			$("#checkPwResult").css("color", color);
			
		}); //비밀번호 유효성 검사 끝
		
		$("#member_passwd2").keyup(checkSamePasswd); // 비밀번호 일치 확인
		$("#member_passwd").change(checkSamePasswd); // 비밀번호 변경시 일치 확인
		
		//회원가입 버튼 클릭시 발생하는 이벤트 
		document.fr.onsubmit = function() {
			if(document.fr.member_id.value == "") { // 아이디 확인
				alert("아이디를 확인해주세요!");
				document.fr.member_id.focus();
				return false;
			} else if(!checkPasswdResult) { // 비밀번호 확인
				alert("비밀번호를 확인해주세요!");
				document.fr.member_passwd.focus();
				return false;
			} else if(!checkPasswd2Result) { // 비밀번호 일치확인 
				alert("비밀번호가 일치하지 않습니다!");
				document.fr.member_passwd2.focus();
				return false;
			} else if(!isValidEmail($("#member_email").val())) { // 이메일 확인
		        alert("E-Mail을 확인해주세요.");
		        document.fr.member_email.focus();
		        return false;
		    } else if (!isValidName($("#member_name").val())) { // 이름 확인
		    	alert("이름을 확인해주세요.");
		        document.fr.member_name.focus();
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
		    } else if (!checkAuthNumResult) {
		    	alert("전화번호 인증을 완료해주세요.");
		        return false; 
		    }
		}
		
	}); // document 객체의 ready 이벤트 끝
	
	function checkSamePasswd() { // 비밀번호 확인 일치 검사
		let passwd = document.fr.member_passwd.value; 
		let passwd2 = document.fr.member_passwd2.value;
		
		if(passwd == passwd2) { // 패스워드 일치
	    	$("#checkPwResult2").text("*비밀번호가 일치합니다.");
			$("#checkPwResult2").css("color", "BLUE");
	    	
	    	checkPasswd2Result = true;
		} else { // 패스워드 불일치
	    	$("#checkPwResult2").text("*비밀번호가 일치하지 않습니다.");
			$("#checkPwResult2").css("color", "RED");
	    	
	    	checkPasswd2Result = false;
		}
	}

	function isValidEmail(email) { //이메일 유효성 검사
	    return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email);
	}
	
	function isValidName(name) { // 이름 유효성 검사
		return  /^[가-힣&&[^ㄱ-ㅎㅏ-ㅣ]{2,5}$/.test(name);
	}
	
	function isValidBirth(birth) { // 생일 유효성 검사
	    return /^[0-9]{8}$/.test(birth);
	}
	
	function isValidPhoneNumber(phoneNumber) { // 휴대폰 번호 유효성 검사
		return /^[0-9]{10,11}$/.test(phoneNumber);
	}

	function sendAuthMail() {
		// 아이디 입력 텍스트박스에 입력된 아이디 가져오기
		let eMail = $("#member_email").val();
		
		if(!isValidEmail(eMail)) { // 이메일 확인
	        alert("E-Mail을 정확히 입력해주세요.");
	        document.fr.member_email.focus();
	        return false;
	    } 
		
		// 이메일이 입력되지 않았을 경우 경고창 출력
		if(eMail == "") {
			alert("이메일을 입력해주세요!");
			$("#member_email").focus();
			return;
		}
		
		// SendAuthMail 서블릿 주소 요청 => 파라미터로 아이디 전달
		
		location.href = "SendAuthMail?member_email=" + eMail;
	}
	
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
		            
		            $("#check_tel").remove();
		            $("#member_phone").css("margin-right", "105px");
		            $("#auth_num").after(
		            	'<input type="button" class="check_tel" id="check_tel" value="인증하기" onclick="phoneAuthCheck()">'	
		            );
		            $("#authBox").css("margin-left", "100px")
		            
		            
		        } else {
		            alert("인증번호 전송에 실패했습니다.");
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
								<li class="active"><a href="blog-single.html">회원가입</a></li>
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
							<h2>회원가입</h2>
							<p>정보를 입력해주세요</p>
							<!-- Form -->
							<form class="form" method="post" action="register" name="fr">
								<div class="row">
									<div class="col-12">
										<div class="form-group">
											<label>이름<span>*</span></label>
											<input type="text" name="member_name" id="member_name" maxlength="5" placeholder="이름" required="required">
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>아이디<span>*</span></label>
											<input type="text" name="member_id" id="member_id" placeholder="아이디" required>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>이메일<span>*</span></label>
											<input type="email" name="email" id="member_email" placeholder="이메일" required>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>주소<span>*</span></label>
											<input type="text" name="address" placeholder="주소" required="required">
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>전화번호<span>*</span></label>
											<input type="text" name="member-phone" id="member-phone" placeholder="전화번호" maxlength="11" required>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>비밀번호<span>*</span></label>
											<input type="password" name="member_passwd" id="member_passwd" placeholder="비밀번호" required>
											<div id="checkPwResult"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>비밀번호 확인<span>*</span></label>
											<input type="password" name="member_passwd2" id="member_passwd2" placeholder="비밀번호 확인" required>
											<div id="checkPwResult2"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group login-btn">
											<button class="btn" type="submit" onsubmit="submit()">가입하기</button>
											<a href="login.html" class="btn">로그인</a>
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