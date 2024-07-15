<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <title>거래 내역</title>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
        /* 추가 스타일 */
        #highlighted-row {
            border: 1px solid #eeeeeec2;
            padding: 30px;
            margin-top: 50px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            background-color: #fff;
        }

        .nav-tabs {
            margin-bottom: 20px;
        }

        .nav-tabs .nav-item {
            flex: 1;
            text-align: center;
        }

        .nav-tabs .nav-link {
            border: none;
            font-size: 18px;
        }

        .nav-tabs .nav-link.active {
            background-color: #27a745;
            color: #fff;
            border-radius: 5px;
        }

        .trade-item {
            border: 1px solid #ddd;
            border-radius: 10px;
            margin-bottom: 15px;
            padding: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .trade-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 15px;
        }

        .trade-details {
            display: flex;
            align-items: center;
            flex: 1;
        }

        .trade-info {
            flex: 1;
        }

        .trade-info h5 {
            margin: 0 0 10px;
            font-weight: bold;
        }

        .trade-info p {
            margin: 0;
            color: #777;
        }

        .trade-price {
            font-size: 18px;
            font-weight: bold;
            color: #27a745;
            text-align: right;
        }

        .trade-status {
            font-size: 12px;
            color: #999;
            text-align: right;
        }
    </style>
</head>

<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<!-- Start Trade Section -->
<section class="shop-blog grid section">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-12">
                <jsp:include page="../mypage/sidebar.jsp"></jsp:include>
            </div>
            <div class="col-lg-9 col-12" id="highlighted-row">
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#buy-history">구매 내역</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#sell-history">판매 내역</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div id="buy-history" class="tab-pane active">
                        <c:forEach var="purchase" items="${purchaseList}">
                            <div class="trade-item">
                                <div class="trade-details">
                                    <img src="<%= request.getContextPath() %>/resources/upload/${purchase.main_image}" alt="${purchase.PD_SUBJECT}">
                                    <div class="trade-info">
                                        <h5>${purchase.PD_SUBJECT}</h5>
                                        <p>구매일: <fmt:formatDate value="${purchase.TD_TIME}" pattern="yyyy년 MM월 dd일" /></p>
                                        <p>판매자: ${purchase.US_NICK}</p>
                                    </div>
                                </div>
                                <div>
                                    <div class="trade-price"><fmt:formatNumber value="${purchase.PD_PRICE}" pattern="#,###"/>원</div>
                                    <div class="trade-status">${purchase.PD_STATUS_VALUE}</div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty purchaseList}">
                            <p>구매 내역이 없습니다.</p>
                        </c:if>
                    </div>
                    <div id="sell-history" class="tab-pane fade">
                        <c:forEach var="sale" items="${saleList}">
                            <div class="trade-item">
                                <div class="trade-details">
                                    <img src="<%= request.getContextPath() %>/resources/upload/${sale.main_image}" alt="${sale.PD_SUBJECT}">
                                    <div class="trade-info">
                                        <h5>${sale.PD_SUBJECT}</h5>
                                        <p>판매일: <fmt:formatDate value="${sale.TD_TIME}" pattern="yyyy년 MM월 dd일" /></p>
                                        <p>구매자: ${sale.US_NICK}</p>
                                    </div>
                                </div>
                                <div>
                                    <div class="trade-price"><fmt:formatNumber value="${sale.PD_PRICE}" pattern="#,###"/>원</div>
                                    <div class="trade-status">${sale.PD_STATUS_VALUE}</div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty saleList}">
                            <p>판매 내역이 없습니다.</p>
                        </c:if>
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
<!-- Active JS -->
<script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
</body>
</html>
