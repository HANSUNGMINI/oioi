<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="zxx">
<head>
  <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
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
	let checkMailAuthNumResult = false;
	let serverAuthNum = "";
	let serverMailAuthNum = "";
	$(function() {
		
		document.querySelector("#user_id").onclick = function() { //아이디 중복체크&유효성검사 새창 오픈
			window.open("check_id", "아이디 중복확인", "width=600, height=300, top=150, left=650");
		};
		
		$("#user_passwd").keyup(function() { // 비밀번호 유효성 검사
			
		    let passwd = $("#user_passwd").val();
			
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
		    
			if(passwd.search($("#user_id").val()) > -1) {
				msg = "비밀번호에 아이디가 포함되었습니다.";
				color = "RED";
				
				checkPasswdResult = false;
		    }    
			
			
		    $("#checkPwResult").text(msg);
			$("#checkPwResult").css("color", color);
			
		}); //비밀번호 유효성 검사 끝
		
		$("#user_passwd2").keyup(checkSamePasswd); // 비밀번호 일치 확인
		$("#user_passwd").change(checkSamePasswd); // 비밀번호 변경시 일치 확인
		
		// 닉네임 중복확인 새 창 발생
		document.querySelector("#user_nick").onclick = function() { 
			window.open("check_nick", "닉네임 중복확인", "width=600, height=300, top=150, left=650");
		};
		
		
		//회원가입 버튼 클릭시 발생하는 이벤트 
		document.fr.onsubmit = function() {
			
			 if(document.fr.user_id.value == "") { // 아이디 확인
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '아이디를 확인해주세요!',
			            didClose: () => document.fr.user_id.focus()
			        });
			        return false;
			    } else if(!checkPasswdResult) { // 비밀번호 확인
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '비밀번호를 확인해주세요!',
			            didClose: () => document.fr.user_passwd.focus()
			        });
			        return false;
			    } else if(!checkPasswd2Result) { // 비밀번호 일치확인 
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '비밀번호가 일치하지 않습니다!',
			            didClose: () => document.fr.user_passwd2.focus()
			        });
			        return false;
			    } else if (!isValidName($("#user_name").val())) { // 이름 확인
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '이름을 확인해주세요!',
			            didClose: () => document.fr.user_name.focus()
			        });
			        return false;
			    } else if(document.fr.user_nick.value == "") { // 닉네임 확인
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '닉네임을 확인해주세요!',
			            didClose: () => document.fr.user_nick.focus()
			        });
			        return false;    
			    } else if(!isValidEmail($("#user_email").val())) { // 이메일 확인
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: 'E-Mail을 확인해주세요!',
			            didClose: () => document.fr.user_email.focus()
			        });
			        return false;
			    } else if(serverMailAuthNum == "") {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '인증메일발송을 먼저 요청해주세요',
			            didClose: () => document.fr.check_email.focus()
			        });
			        return false;
			    } else if ($("#mail_auth_num").val() == "") {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '인증번호를 입력해주세요!',
			            didClose: () => document.fr.mail_auth_num.focus()
			        });
			        return false;
			    } else if (!checkMailAuthNumResult) {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '이메일 인증을 완료해주세요!',
			            didClose: () => document.fr.mail_auth_num.focus()
			        });
			        return false; 
			    } else if(document.fr.user_post_code.value == "" || document.fr.user_address1.value == "") {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '주소를 확인해주세요!',
			            didClose: () => document.fr.user_post_code.focus()
			        });
			        return false;
			    } else if(document.fr.user_address2.value == "") {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '상세 주소를 확인해주세요!',
			            didClose: () => document.fr.user_address2.focus()
			        });
			        return false;    
			    } else if (!isValidPhoneNumber($("#user_phone").val())) {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '전화번호를 확인해주세요!',
			            didClose: () => document.fr.user_phone.focus()
			        });
			        return false;
			    } else if (serverAuthNum == "") { // 인증번호 요청 확인
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '인증번호 요청을 먼저 해주세요!',
			            didClose: () => document.fr.user_phone.focus()
			        });
			        return false;
			    } else if ($("#auth_num").val() == "") {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '인증번호를 입력해주세요!',
			            didClose: () => document.fr.auth_num.focus()
			        });
			        return false; 
			    } else if (!checkAuthNumResult) {
			        Swal.fire({
			            icon: 'error',
			            title: '실패!',
			            text: '전화번호 인증을 완료해주세요!',
			            didClose: () => document.fr.auth_num.focus()
			        });
			        return false; 
			    }
			}
	}); // document 객체의 ready 이벤트 끝
	
	function checkSamePasswd() { // 비밀번호 확인 일치 검사
		let passwd = document.fr.user_passwd.value; 
		let passwd2 = document.fr.user_passwd2.value;
		
		if(passwd == passwd2) { // 패스워드 일치
	    	$("#checkPwResult2").text("*비밀번호가 일치합니다.");
			$("#checkPwResult2").css("color", "#34A853");
	    	
	    	checkPasswd2Result = true;
		} else { // 패스워드 불일치
	    	$("#checkPwResult2").text("*비밀번호가 일치하지 않습니다.");
			$("#checkPwResult2").css("color", "RED");
	    	
	    	checkPasswd2Result = false;
		}
	}

	function isValidEmail(email) { //이메일 유효성 검사
		return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email) && !/[ㄱ-ㅎㅏ-ㅣ가-힣]/.test(email);
	}
	
	function isValidName(name) { // 이름 유효성 검사
		return  /^[가-힣&&[^ㄱ-ㅎㅏ-ㅣ]{2,5}$/.test(name);
	}
	
	function isValidPhoneNumber(phoneNumber) { // 휴대폰 번호 유효성 검사
		return /^[0-9]{10,11}$/.test(phoneNumber);
	}
	
	let isMailAuthButtonCreated = false; // 버튼이 생성되었는지 여부를 나타내는 변수
	
	function sendAuthMail() {
	    // 이메일 입력창에 입력된 이메일 가져오기
	    let eMail = $("#user_email").val();
	    // 한글 포함 여부 검사
	    if (/[ㄱ-ㅎㅏ-ㅣ가-힣]/.test(eMail)) {
	        Swal.fire({
	            icon: 'error',
	            title: '이메일에 한글을 포함할 수 없습니다.'
	        });
	        return false;
	    } else if(!isValidEmail(eMail)) { // 이메일 확인
	        Swal.fire({
	            icon: 'error',
	            title: 'E-Mail을 정확히 입력해주세요.',
	            didClose: () => document.fr.user_email.focus()
	        });
	        return false;
	    } 

	    $.ajax({
	        url : "SendAuthMail",
	        type : "POST",
	        contentType: "application/json",
	        data : JSON.stringify({"user_email": eMail}),
	        dataType: "json",
	        success : function(authInfo){
	            console.log(authInfo);
	            if(authInfo.success){
	                serverMailAuthNum = authInfo.auth_code;
	                Swal.fire({
	                    icon: 'success',
	                    title: '인증메일이 전송되었습니다.'
	                });
	                // 버튼이 생성되지 않았다면 생성
	                if (!isMailAuthButtonCreated) {
	                    $("#mail_auth_num").parent().append(
	                        '<input type="button" class="check_email" id="check_email" value="인증하기" onclick="mailAuthCheck()">'
	                    );
	                    isMailAuthButtonCreated = true; // 버튼이 생성되었음을 표시
	                }
	            } else {
	                Swal.fire({
	                    icon: 'error',
	                    title: '인증메일 발송에 실패했습니다.'
	                });
	            }
	        },
	        error : function() {
	            Swal.fire({
	                icon: 'error',
	                title: '인증메일 발송에 실패했습니다. 다시 시도주세요.'
	            });
	        }
	    });
	}

	function mailAuthCheck(){
	    if($("#mail_auth_num").val() !== serverMailAuthNum){
	        Swal.fire({
	            icon: 'error',
	            title: '인증번호를 확인해주세요.'
	        });
	        return false;
	    } else {
	        Swal.fire({
	            icon: 'success',
	            title: '인증되었습니다.'
	        });
	        checkMailAuthNumResult = true;
	    }
	}

	let isPhoneAuthButtonCreated = false;
	function phoneAuth() {
	    let user_phone = $("#user_phone").val();

	    if (!isValidPhoneNumber(user_phone) || user_phone == "") {
	        Swal.fire({
	            icon: 'error',
	            title: '전화번호를 확인해주세요.',
	            didClose: () => document.fr.user_phone.focus()
	        });
	        return false;
	    }

	    $.ajax({
	        type : "POST",
	        url : "send-one",
	        contentType: "application/json",
	        data : JSON.stringify({"user_phone": user_phone}),
	        dataType :"json",
	        success : function(response){
	            if (response.success) {
	                serverAuthNum = response.auth_num;  // 서버에서 받은 인증번호를 저장
	                
	                Swal.fire({
	                    icon: 'success',
	                    title: '인증번호가 전송되었습니다.'
	                });
	                if (!isPhoneAuthButtonCreated) {
	                    $("#auth_num").parent().append(
	                        '<input type="button" class="check_tel" id="check_tel" value="인증하기" onclick="phoneAuthCheck()">'    
	                    );
	                    isPhoneAuthButtonCreated = true; // 버튼이 생성되었음을 표시
	                }
	            } else {
	                Swal.fire({
	                    icon: 'error',
	                    title: '인증번호 전송에 실패했습니다.'
	                });
	            }
	        },
	        error : function() {
	            Swal.fire({
	                icon: 'error',
	                title: '전화번호 인증에 실패했습니다. 다시 시도해주세요.'
	            });
	        }
	    });
	}

	function phoneAuthCheck(){
	    if($("#auth_num").val() !== serverAuthNum){
	        Swal.fire({
	            icon: 'error',
	            title: '인증번호를 확인해주세요.'
	        });
	        return false;
	    } else {
	        Swal.fire({
	            icon: 'success',
	            title: '인증되었습니다.'
	        });
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
	width : 35%;
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
											<label>아이디<span>*</span></label>
											<input type="text" name="user_id" id="user_id" placeholder="아이디" readonly>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>비밀번호<span>*</span></label>
											<input type="password" name="user_passwd" id="user_passwd" placeholder="비밀번호" maxlength="12" >
											<div id="checkPwResult"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>비밀번호 확인<span>*</span></label>
											<input type="password" name="user_passwd2" id="user_passwd2" placeholder="비밀번호 확인" maxlength="12" >
											<div id="checkPwResult2"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>이름<span>*</span></label>
											<input type="text" name="user_name" id="user_name" maxlength="5" placeholder="이름" >
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>닉네임<span>*</span></label>
											<input type="text" name="user_nick" id="user_nick" maxlength="16" placeholder="닉네임" readonly>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>이메일<span>*</span></label>
											<div style="display: flex">
												<input type="text" name="user_email" id="user_email" placeholder="이메일" >
												<input type="button" name="check_email" class="check_email" id="check_email" value="인증메일발송" onclick="sendAuthMail()">
											</div>
											<div id="authBox" style="display: flex">
												<input type="text" placeholder="인증번호" id="mail_auth_num" name="mail_auth_num" maxlength="6"/>
											</div>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>주소<span>*</span></label>
											<input type="text" name="user_post_code" id="postCode" size="6" placeholder="우편번호" readonly onclick="search_address()">
											<input type="text" id="address1" name="user_address1" placeholder="기본주소" size="25" readonly onclick="search_address()">
											<input type="text" id="address2" name="user_address2" placeholder="상세주소" size="25" >
											<input type="hidden" id="US_LAT" name="US_LAT">
											<input type="hidden" id="US_LNG" name="US_LNG">
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
<!-- 									<div class="col-12"> -->
<!-- 									    <div class="form-group"> -->
<!-- 									        <label>성별<span>*</span></label> -->
<!-- 									        <div style="display: flex; align-items: center;"> -->
<!-- 									            <label for="male" style="display: flex; align-items: center; margin-right: 10px;"> -->
<!-- 									                <input type="radio" id="male" name="user_gender" value="남성" style="margin-right: 5px;"> 남 -->
<!-- 									            </label> -->
<!-- 									            <label for="female" style="display: flex; align-items: center;"> -->
<!-- 									                <input type="radio" id="female" name="user_gender" value="여성" style="margin-right: 5px;"> 여 -->
<!-- 									            </label> -->
<!-- 									        </div> -->
<!-- 									    </div> -->
<!-- 									</div> -->
									<div class="col-12">
										<div class="form-group login-btn">
											<button class="btn" type="submit" onsubmit="submit()">가입하기</button>
											<a href="login" class="btn">로그인</a>
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
<!-- ================================================================================== -->
	<!-- 카카오(다음) 우편번호 API 서비스 활용 -->
	<!-- postcode.v2.js 스크립트 파일 로딩 필수! (직접 다운로드 대신 URL 지정으로 로딩) -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function search_address() {
	        new daum.Postcode({ // daum.Postcode 객체 생성
	            oncomplete: function(data) {
	                document.fr.postCode.value = data.zonecode;
	        		let address = data.address; // 기본주소 변수에 저장
	        		
	        		if(data.buildingName != "") {
	        			address += " (" + data.buildingName + ")";
	        		}
	        		document.fr.address1.value = address;
	        		document.fr.address2.focus();
	        		
	        		getLatLng(address);
	            }
	        }).open();
	    };
	    
	    function getLatLng(address) {
            const baseUrl = "https://maps.googleapis.com/maps/api/geocode/json";
            const apiKey = "AIzaSyDxE6_KxiuRqxlJbzS1QrPbctEG7K-vuY8"
            const params = new URLSearchParams({
                address: address,
                key: apiKey
            });
            
            $.ajax({
                url: baseUrl,
                method: "GET",
                data: {
                    address: address,
                    key: apiKey
                },
                success: function(response) {
	                const location = response.results[0].geometry.location;
	                $("#US_LAT").val(location.lat);
	                $("#US_LNG").val(location.lng);
                },
            });
        }
	</script>
	<!-- ================================================================================== -->   
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