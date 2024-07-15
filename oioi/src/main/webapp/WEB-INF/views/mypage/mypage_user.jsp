<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 정보 수정</title>
    <!-- 스타일 및 스크립트 로드 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
    <style>
        /* 스타일 정의 */
        #highlighted-row {
            border: 1px solid #eeeeeec2;
            padding: 30px;
            margin-top: 50px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            background-color: #fff;
        }
        .info-card {
            margin: 20px 0;
            border: 1px solid #d4edda;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: #27a745;
            color: #ffffff;
            padding: 15px;
            font-weight: bold;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        .card-body {
            padding: 15px;
            background-color: #f8f8f8;
        }
        .info-item {
            display: grid;
            grid-template-columns: 1fr 2fr 1fr;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
            text-align: center;
        }
        .info-item:last-child {
            border-bottom: none;
        }
        .info-item label {
            font-weight: bold;
            color: #555;
        }
        .info-item span {
            color: #333;
        }
        .profile-image {
            border-radius: 50%;
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-bottom: 20px;
        }
        .edit-btn {
            background-color: #27a745;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        @media (max-width: 768px) {
            .info-item {
                grid-template-columns: 1fr;
                text-align: left;
            }
        }
        
        /* 모달 창 스타일 */
        .ui-dialog .ui-dialog-titlebar {
            background-color: transparent;
            border: none;
        }
        .ui-dialog .ui-dialog-content {
            background-color: #f8f8f8;
        }
        .ui-dialog .ui-dialog-buttonpane {
            background-color: #f8f8f8;
        }
        .ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset button {
            background-color: #d9534f;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
        }
        .ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset button:hover {
            background-color: #c9302c;
        }
        .modal-content img {
            width: 100px;
        }
        .modal-content p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .modal-content form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .modal-content form label {
            width: 100%;
            text-align: left;
            margin-bottom: 5px;
        }
        .modal-content form input {
            width: 100%;
            margin-bottom: 20px;
        }
    </style>
</head>
<body class="js">
<!-- 헤더 -->
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<!-- 메인 섹션 -->
<section class="blog-single shop-blog grid section">
    <div class="container">
        <div class="row">
            <!-- 사이드바 -->
            <div class="col-lg-3 col-12">
                <jsp:include page="../mypage/sidebar.jsp"></jsp:include>
            </div>
            <!-- 메인 컨텐츠 -->
            <div class="col-lg-9 col-12" id="highlighted-row">
                <div class="info-card text-center">
                    <h5 class="card-header">회원 정보</h5>
                    <div class="card-body">
                        <div class="info-item">
                            <label>이름:</label>
                            <span>${user.US_NAME}</span>
                        </div>
                        <div class="info-item">
                            <label>아이디:</label>
                            <span>${user.US_ID}</span>
                        </div>
                        <div class="info-item">
                            <label>비밀번호:</label>
                            <span>********</span>
                            <button class="edit-btn" onclick="openPasswordModal()">수정</button>
                        </div>
                        <div class="info-item">
                            <label>닉네임:</label>
                            <span id="nickname">${user.US_NICK}</span>
                            <button class="edit-btn" onclick="openNickModal()">수정</button>
                        </div>
                        <div class="info-item">
                            <label>이메일:</label>
                            <span id="email">${user.US_EMAIL}</span>
                            <button class="edit-btn" onclick="openEmailModal()">수정</button>
                        </div>
                        <div class="info-item">
                            <label>전화번호:</label>
                            <span id="phone">${user.US_PHONE}</span>
                            <button class="edit-btn" onclick="openPhoneModal()">수정</button>
                        </div>
                        <div class="info-item">
                            <label>주소:</label>
                            <span id="address">${user.US_ADDRESS}</span>
                            <button class="edit-btn" onclick="openAddressModal()">수정</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- 푸터 -->
<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>

<!-- 닉네임 수정 모달 -->
<div id="nickname-modal" title="">
    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block; margin: 0 auto; padding: 10px 0;">
    <p>새 닉네임을 입력하세요:</p>
    <input type="text" id="new-nickname" class="form-control">
    <div id="checkNickResult"></div>
    <button class="nick_check" id="btnCheckNick">중복확인</button>
</div>

<!-- 이메일 수정 모달 -->
<div id="email-modal" title="">
    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block; margin: 0 auto; padding: 10px 0;">
    <p>새 이메일을 입력하세요:</p>
    <input type="email" id="new-email" class="form-control">
    <button class="edit-btn" onclick="sendAuthMail()">인증메일발송</button>
    <input type="text" id="email-auth-code" class="form-control" placeholder="인증코드 입력">
</div>

<!-- 전화번호 수정 모달 -->
<div id="phone-modal" title="">
    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block; margin: 0 auto; padding: 10px 0;">
    <p>새 전화번호를 입력하세요:</p>
    <input type="text" id="new-phone" class="form-control">
    <button class="edit-btn" onclick="sendAuthSMS()">인증번호발송</button>
    <input type="text" id="phone-auth-code" class="form-control" placeholder="인증코드 입력">
</div>

<!-- 주소 수정 모달 -->
<div id="address-modal" title="">
    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block; margin: 0 auto; padding: 10px 0;">
    <p>새 주소를 입력하세요:</p>
    <input type="text" id="new-postcode" class="form-control" placeholder="우편번호" readonly onclick="search_address()">
    <input type="text" id="new-address1" class="form-control" placeholder="기본주소" readonly>
    <input type="text" id="new-address2" class="form-control" placeholder="상세주소">
    <input type="hidden" id="US_LAT" name="US_LAT">
    <input type="hidden" id="US_LNG" name="US_LNG">
</div>

<!-- 비밀번호 수정 모달 -->
<div id="password-modal" title="">
    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block; margin: 0 auto; padding: 10px 0;">
    <p>현재 비밀번호를 입력하세요:</p>
    <input type="password" id="current-password" class="form-control">
    <p>새 비밀번호를 입력하세요:</p>
    <input type="password" id="new-password" class="form-control">
    <div id="checkPwResult"></div>
    <p>새 비밀번호를 다시 입력하세요:</p>
    <input type="password" id="confirm-new-password" class="form-control">
    <div id="checkPwResult2"></div>
</div>

<!-- 회원탈퇴 모달 -->
<div id="withdrawModal" title="회원탈퇴" style="display:none;">
    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block; margin: 0 auto; padding: 10px 0;">
    <p>정말 탈퇴하시겠습니까?</p>
    <form id="withdrawForm" method="post" action="userWithdraw" onsubmit="return submitWithdrawForm()">
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required class="form-control">
    </form>
</div>

<!-- 사용자 정의 모달 알림 창 -->
<div id="custom-alert-modal" title="알림">
    <p id="custom-alert-message"></p>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function() {
    // 사용자 정의 모달 알림 창 초기화
    $("#custom-alert-modal").dialog({
        autoOpen: false,
        modal: true,
        buttons: {
            "확인": function() {
                $(this).dialog("close");
                if ($("#custom-alert-modal").data("reloadPage")) {
                    location.reload(); // 현재 페이지 갱신(새로고침)
                }
            }
        }
    });

    // 닉네임 입력창 이벤트
    $("#new-nickname").on("keyup", function() {
        const newNick = $(this).val();
        if (checkNick(newNick)) { // 닉네임 유효성검사 통과 시
            $("#checkNickResult").text("중복확인 버튼을 눌러주세요.");
            $("#checkNickResult").css("color", "#34A853");
            $("#btnCheckNick").prop("disabled", false);
        } else { // 닉네임 유효성 검사 실패 시 중복확인 버튼 비활성화
            $("#btnCheckNick").prop("disabled", true);
        }
    });

    // 중복확인 버튼 클릭 이벤트
    $("#btnCheckNick").click(function() {
        const newNick = $("#new-nickname").val();
        if (newNick === "") {
            showCustomAlert("닉네임을 입력해주세요.", false);
            return false;
        }

        $.ajax({
            type: "POST",
            url: "checkNickname", // 컨트롤러 URL
            data: { nickname: newNick },
            dataType: "json",
            success: function(response) {
                if (response.isValidNick) { // 닉네임 사용 가능
                    showCustomAlert("사용가능한 닉네임입니다.", false);
                    $("#nickname").val(newNick);
                } else { // 닉네임 사용 불가
                    showCustomAlert("이미 사용중인 닉네임입니다.", false);
                }
            },
            error: function() {
                showCustomAlert("요청 실패!", false);
            }
        });
    });

    // 비밀번호 유효성 검사
    $("#new-password").keyup(checkPasswordStrength);
    $("#confirm-new-password").keyup(checkSamePasswd);
    $("#new-password").change(checkSamePasswd);
});

function openNickModal() {
    // 닉네임 수정 모달 열기
    $("#nickname-modal").dialog({
        modal: true,
        title: '',
        open: function() {
            $(this).prev(".ui-dialog-titlebar").css("background-color", "transparent");
        },
        buttons: {
            "확인": function() {
                const newNick = $("#new-nickname").val();
                if (newNick && checkNick(newNick)) {
                    updateField("nickname", newNick);
                    $(this).dialog("close");
                } else {
                    showCustomAlert("닉네임을 입력하세요.", false);
                }
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
}

function openEmailModal() {
    // 이메일 수정 모달 열기
    $("#email-modal").dialog({
        modal: true,
        title: '',
        open: function() {
            $(this).prev(".ui-dialog-titlebar").css("background-color", "transparent");
        },
        buttons: {
            "확인": function() {
                const newEmail = $("#new-email").val();
                const authCode = $("#email-auth-code").val();
                if (newEmail && authCode) {
                    verifyAuthCode(newEmail, authCode);
                    $(this).dialog("close");
                } else {
                    showCustomAlert("이메일과 인증 코드를 입력하세요.", false);
                }
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
}

function openPhoneModal() {
    // 전화번호 수정 모달 열기
    $("#phone-modal").dialog({
        modal: true,
        title: '',
        open: function() {
            $(this).prev(".ui-dialog-titlebar").css("background-color", "transparent");
        },
        buttons: {
            "확인": function() {
                const newPhone = $("#new-phone").val();
                const authCode = $("#phone-auth-code").val();
                if (newPhone && authCode) {
                    // 인증번호 확인 요청
                    verifyPhoneAuthCode(newPhone, authCode);
                    $(this).dialog("close");
                } else {
                    showCustomAlert("전화번호와 인증 코드를 입력하세요.", false);
                }
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
}

function openAddressModal() {
    // 주소 수정 모달 열기
    $("#address-modal").dialog({
        modal: true,
        title: '',
        open: function() {
            $(this).prev(".ui-dialog-titlebar").css("background-color", "transparent");
        },
        buttons: {
            "확인": function() {
                const newAddress = $("#new-postcode").val() + "/" + $("#new-address1").val() + "/" + $("#new-address2").val();
                if (newAddress) {
                    updateField("address", newAddress);
                    $(this).dialog("close");
                } else {
                    showCustomAlert("주소를 입력하세요.", false);
                }
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
}

function openPasswordModal() {
    // 비밀번호 변경 모달 열기
    $("#password-modal").dialog({
        modal: true,
        title: '',
        open: function() {
            $(this).prev(".ui-dialog-titlebar").css("background-color", "transparent");
        },
        buttons: {
            "확인": function() {
                const currentPassword = $("#current-password").val();
                const newPassword = $("#new-password").val();
                const confirmNewPassword = $("#confirm-new-password").val();
                if (newPassword !== confirmNewPassword) {
                    showCustomAlert("새 비밀번호가 일치하지 않습니다.", false);
                    return;
                }
                if (currentPassword && newPassword && confirmNewPassword) {
                    changePassword(currentPassword, newPassword);
                    $(this).dialog("close");
                } else {
                    showCustomAlert("모든 필드를 입력하세요.", false);
                }
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
}

function checkPasswordStrength() {
    let passwd = $("#new-password").val();
    let msg = "";
    let color = "";

    let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
    if (lengthRegex.exec(passwd)) {
        let engUpperRegex = /[A-Z]/; // 대문자
        let engLowerRegex = /[a-z]/; // 소문자
        let numRegex = /\d/; // 숫자
        let specRegex = /[!@#$%^&*]/; // 특수문자

        let count = 0;
        if (engUpperRegex.exec(passwd)) { count++; }
        if (engLowerRegex.exec(passwd)) { count++; }
        if (numRegex.exec(passwd)) { count++; }
        if (specRegex.exec(passwd)) { count++; }

        switch (count) {
            case 4: msg = "안전"; color = "GREEN"; break;
            case 3: msg = "보통"; color = "ORANGE"; break;
            case 2: msg = "위험"; color = "RED"; break;
            default:
                msg = "영문 대소문자, 숫자, 특수문자 중 2개 이상을 포함시켜주세요.";
                color = "RED";
        }
    } else {
        msg = "영문 대소문자, 숫자, 특수문자 중 2개 이상을 포함시켜주세요.";
        color = "RED";
    }
    if (passwd.search($("#current-password").val()) > -1) {
        msg = "비밀번호에 현재 비밀번호가 포함되었습니다.";
        color = "RED";
    }
    $("#checkPwResult").text(msg);
    $("#checkPwResult").css("color", color);
}

function checkSamePasswd() {
    let passwd = $("#new-password").val();
    let passwd2 = $("#confirm-new-password").val();
    if (passwd === passwd2) {
        $("#checkPwResult2").text("*비밀번호가 일치합니다.");
        $("#checkPwResult2").css("color", "#34A853");
    } else {
        $("#checkPwResult2").text("*비밀번호가 일치하지 않습니다.");
        $("#checkPwResult2").css("color", "RED");
    }
}

function changePassword(currentPassword, newPassword) {
    $.ajax({
        type: "POST",
        url: "changePassword",
        data: JSON.stringify({ currentPassword: currentPassword, newPassword: newPassword }),
        contentType: "application/json",
        success: function(response) {
            if (response.success) {
                showCustomAlert("비밀번호가 성공적으로 변경되었습니다.", true);
            } else {
                showCustomAlert(response.message, false);
            }
        },
        error: function() {
            showCustomAlert("요청 실패!", false);
        }
    });
}

function sendAuthMail() {
    const newEmail = $("#new-email").val();
    $.ajax({
        type: "POST",
        url: "sendAuthMail",
        contentType: "application/json",
        data: JSON.stringify({ email: newEmail }),
        success: function(response) {
            if (response.success) {
                showCustomAlert("인증 메일이 발송되었습니다.", false);
            } else {
                showCustomAlert("인증 메일 발송에 실패했습니다.", false);
            }
        },
        error: function() {
            showCustomAlert("요청 실패!", false);
        }
    });
}

function verifyAuthCode(email, authCode) {
    $.ajax({
        type: "POST",
        url: "verifyEmailAuthCode",
        contentType: "application/json",
        data: JSON.stringify({ email: email, authCode: authCode }),
        success: function(response) {
            if (response.success) {
                updateField("email", email);
                showCustomAlert("이메일이 성공적으로 변경되었습니다.", true);
            } else {
                showCustomAlert(response.message, false);
            }
        },
        error: function() {
            showCustomAlert("요청 실패!", false);
        }
    });
}

function sendAuthSMS() {
    const newPhone = $("#new-phone").val();
    $.ajax({
        type: "POST",
        url: "send-one",
        contentType: "application/json",
        dataType: "json", // 응답 데이터 형식 명시
        data: JSON.stringify({ user_phone: newPhone }),
        success: function(response) {
            console.log(response); // 디버깅을 위한 로그 추가
            if (response.success) {
                showCustomAlert("인증번호가 발송되었습니다.", false);
            } else {
                showCustomAlert("인증번호 발송에 실패했습니다.", false);
            }
        },
        error: function() {
            showCustomAlert("요청 실패!", false);
        }
    });
}

function verifyPhoneAuthCode(phone, authCode) {
    $.ajax({
        type: "POST",
        url: "verifyPhoneAuthCode",
        contentType: "application/json",
        data: JSON.stringify({ authCode: authCode }),
        success: function(response) {
            console.log(response); // 디버깅을 위한 로그 추가
            if (response.success) {
                updateField("phone", phone);
                showCustomAlert(response.message, true);
            } else {
                showCustomAlert(response.message, false);
            }
        },
        error: function() {
            showCustomAlert("요청 실패!", false);
        }
    });
}

function updateField(field, value) {
    $.ajax({
        type: "POST",
<<<<<<< HEAD
        url: 'updateField', // 전화번호 필드는 coolUpdateField 경로 사용하지 않도록 변경
        data: JSON.stringify({ field: field, value: value }),
        contentType: "application/json",
=======
        url: field === 'phone' ? 'coolUpdateField' : 'updateField', // 전화번호 필드는 coolUpdateField 경로 사용
        data: { 
        	field: field, 
        	value: value 
       	},
//         contentType: "application/json",
>>>>>>> branch 'main' of https://github.com/HANSUNGMINI/oioi.git
        success: function(response) {
       		showCustomAlert(response.message, response.result);
//             if (response.result) {
//                 showCustomAlert(response.message, true);
//             } else {
//                 showCustomAlert(response.message, false);
//             }
        },
        error: function() {
            showCustomAlert("요청 실패!", false);
        }
    });
}

function search_address() {
    new daum.Postcode({
        oncomplete: function(data) {
            $("#new-postcode").val(data.zonecode);
            $("#new-address1").val(data.address);
            $("#new-address2").focus();
        }
    }).open();
}

function showCustomAlert(message, reloadPage) {
    $("#custom-alert-message").text(message);
    $("#custom-alert-modal").data("reloadPage", reloadPage).dialog("open");
}

function showWithdrawModal(event) {
    event.preventDefault(); // 기본 동작 막기
    $("#withdrawModal").dialog({
        modal: true,
        buttons: {
            "확인": function() {
                $("#withdrawForm").submit();
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
}

function submitWithdrawForm() {
    var password = $("#password").val();

    $.ajax({
        type: "POST",
        url: "userWithdraw",
        data: { password: password },
        success: function(response) {
            if (response.success) {
                alert(response.message);
                window.location.href = "${pageContext.request.contextPath}/"; // 홈 페이지로 리다이렉트
            } else {
                alert(response.message);
            }
        },
        error: function() {
            alert("요청 실패!");
        }
    });

    return false; // 폼 제출 중단
}
</script>
</body>
</html>
