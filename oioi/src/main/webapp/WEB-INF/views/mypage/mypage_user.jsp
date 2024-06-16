<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <!-- Meta Tag -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Title Tag -->
    <title>마이페이지</title>
    <!-- Web Font -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
    <!-- StyleSheet -->
    <script src="https://kit.fontawesome.com/ef42a902c7.js" crossorigin="anonymous"></script>
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
                            <span>홍길동</span>
                            <span></span>
                        </div>
                        <div class="info-item">
                            <label>아이디:</label>
                            <span>hong1</span>
                            <span></span>
                        </div>
                        <div class="info-item">
                            <label>닉네임:</label>
                            <span>아버지를아버지라</span>
                            <button class="edit-btn">수정</button>
                        </div>
                        <div class="info-item">
                            <label>이메일:</label>
                            <span>hong@example.com</span>
                            <button class="edit-btn">수정</button>
                        </div>
                        <div class="info-item">
                            <label>전화번호:</label>
                            <span>010-1234-5678</span>
                            <button class="edit-btn">수정</button>
                        </div>
                        <div class="info-item">
                            <label>주소:</label>
                            <span>서울</span>
                            <button class="edit-btn">수정</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-migrate-3.0.0.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/colors.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slicknav.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/owl-carousel.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/magnific-popup.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/facnybox.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/finalcountdown.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/nicesellect.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/ytplayer.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/flex-slider.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scrollup.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/onepage-nav.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/easing.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
</body>
</html>
