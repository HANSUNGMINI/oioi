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
    <!-- Title Tag  -->
    <title>나의 거래 내역</title>
    <!-- Web Font -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
    <!-- StyleSheet -->
    <script src="https://kit.fontawesome.com/ef42a902c7.js" crossorigin="anonymous"></script>
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
</head>

<style>
    #highlighted-row {
        border: 1px solid #eeeeeec2;
        padding: 30px;
        margin-top: 50px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
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
    }

    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
        color: #495057;
        background-color: #fff;
        border-color: #dee2e6 #dee2e6 #fff;
    }

    .nav-tabs .nav-link {
        border: 1px solid transparent;
        border-top-left-radius: 0.25rem;
        border-top-right-radius: 0.25rem;
    }

    .table {
        margin-bottom: 0;
    }

    .card-body {
        padding: 15px;
        background-color: #f8f8f8;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        padding: 10px 0;
        border-bottom: 1px solid #eee;
        width: 100%;
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
            align-items: flex-start;
        }

        .info-item label {
            margin-bottom: 5px;
        }
    }
</style>

<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<!-- Start Blog Single -->
<section class="blog-single shop-blog grid section">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-12">
                <jsp:include page="../mypage/sidebar.jsp"></jsp:include>
            </div>
            <div class="col-lg-9 col-12" id="highlighted-row">
                <div class="info-card text-center">
                    <h5 class="card-header">나의 거래 내역</h5>
                    <div class="card-body">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="purchase-tab" data-toggle="tab" href="#purchase" role="tab" aria-controls="purchase" aria-selected="true">구매 내역</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="sale-tab" data-toggle="tab" href="#sale" role="tab" aria-controls="sale" aria-selected="false">판매 내역</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="purchase" role="tabpanel" aria-labelledby="purchase-tab">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">제목</th>
                                            <th scope="col">문의 날짜</th>
                                            <th scope="col">상태</th>
                                            <th scope="col">상세보기</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="purchase" items="${purchaseList}">
                                            <tr>
                                                <td>${purchase.title}</td>
                                                <td><fmt:formatDate value="${purchase.date}" pattern="yyyy-MM-dd" /></td>
                                                <td>${purchase.status}</td>
                                                <td><a href="viewPurchase?purchaseId=${purchase.id}" class="btn btn-primary">보기</a></td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty purchaseList}">
                                            <tr>
                                                <td colspan="4">구매 내역이 없습니다.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane fade" id="sale" role="tabpanel" aria-labelledby="sale-tab">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">제목</th>
                                            <th scope="col">문의 날짜</th>
                                            <th scope="col">상태</th>
                                            <th scope="col">상세보기</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="sale" items="${saleList}">
                                            <tr>
                                                <td>${sale.title}</td>
                                                <td><fmt:formatDate value="${sale.date}" pattern="yyyy-MM-dd" /></td>
                                                <td>${sale.status}</td>
                                                <td><a href="viewSale?saleId=${sale.id}" class="btn btn-primary">보기</a></td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty saleList}">
                                            <tr>
                                                <td colspan="4">판매 내역이 없습니다.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
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
