<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
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
            background-color: #27a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
        }
    </style>
</head>
<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<section class="blog-single shop-blog grid section">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-12">
                <jsp:include page="../mypage/sidebar.jsp"></jsp:include>
            </div>
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
                            <label>닉네임:</label>
                            <span id="nickname">${user.US_NICK}</span>
                            <button class="edit-btn" onclick="openNickModal()">수정</button>
                        </div>
                        <div class="info-item">
                            <label>이메일:</label>
                            <span>${user.US_EMAIL}</span>
                            <button class="edit-btn">수정</button>
                        </div>
                        <div class="info-item">
                            <label>전화번호:</label>
                            <span>${user.US_PHONE}</span>
                            <button class="edit-btn">수정</button>
                        </div>
                        <div class="info-item">
                            <label>주소:</label>
                            <span>${user.ad}</span>
                            <button class="edit-btn">수정</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>

<!-- 닉네임 수정 모달 -->
<div id="nickname-modal" title="">
    <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block; margin: 0 auto; padding: 10px 0;">
    <p>새 닉네임을 입력하세요:</p>
    <input type="text" id="new-nickname" class="form-control">
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
function openNickModal() {
    $("#nickname-modal").dialog({
        modal: true,
        title: '',
        open: function() {
            $(this).prev(".ui-dialog-titlebar").css("background-color", "transparent");
        },
        buttons: {
            "확인": function() {
                const newNick = $("#new-nickname").val();
                if (newNick) {
                    updateNick(newNick);
                    $(this).dialog("close");
                }
            },
            "취소": function() {
                $(this).dialog("close");
            }
        }
    });
}

function updateNick(newNick) {
    $.ajax({
        type: "POST",
        url: "updateNickname", // 컨트롤러 URL
        data: { nickname: newNick },
        dataType: "json",
        success: function(response) {
            if (response.result) { // 닉네임 등록 성공
                $('#nickname').text(newNick);
                alert('닉네임이 성공적으로 변경되었습니다.');
                location.reload(); // 현재 페이지 갱신(새로고침)
            } else { // 닉네임 등록 실패
                alert("닉네임 변경 실패!");
            }
        },
        error: function() {
            alert("요청 실패!");
        }
    });
}
</script>
</body>
</html>
