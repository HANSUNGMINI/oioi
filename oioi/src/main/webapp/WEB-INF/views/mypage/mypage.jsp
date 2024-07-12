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
    <title>마이페이지</title>
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
                    <h5 class="card-header">회원 정보</h5>
                    <div class="card-body">
                        <div class="info-item">
                            <label>이름</label>
                            <span>${user.US_NAME}</span>
                        </div>
                        <div class="info-item">
                            <label>이메일</label>
                            <span>${user.US_EMAIL }</span>
                        </div>
                        <div class="info-item">
                            <label>전화번호</label>
                            <span>${user.US_PHONE}</span>
                        </div>
                        <div class="info-item">
                            <label>주소</label>
                            <span>${user.US_ADDRESS}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
<script>
    
 	// 숫자를 원 단위로 포맷하는 함수 정의
    function formatCurrency(num) {
        return new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(num);
    }
    
    $(document).ready(function() {
   	 	var contextPath = '<%= request.getContextPath() %>';
//         var socket = new WebSocket('ws://localhost:8081/oi/push');
		var socket = new WebSocket('ws://c3d2401t1.itwillbs.com/oioi/push');
        socket.onopen = function() {
            console.log("웹소켓 연결 성공");
        };
        
        socket.onmessage = function(event) {
            try {
                var data = JSON.parse(event.data);
                if (data.msg === "registAPD") {
                    var item = data.item;
                    
                    // 알림 메시지 추가
                    $('#notification-push').html('<span>새로운 경매정보가 도착하였습니다. <br> 지금 바로 참여해보세요!</span>');
                    // 이미지 경로 설정
                	var imagePath = contextPath + '/resources/upload/' + item.APD_IMAGE;

                    var notificationItem = 
                        '<li data-apd-idx="' + item.APD_IDX + '" class="notification-item">' +
                        '<a class="cart-img" href="#"><img src="' + imagePath + '" alt="#"></a>' +
                        '<h4 style="font-size: 90%;">제품명: ' + item.APD_NAME + '<br>' +
                        '시작가 : ' + formatCurrency(item.APD_START_PRICE) + '<br>' +
                        '즉시 구매가 : ' + formatCurrency(item.APD_BUY_NOW_PRICE) +
                        '</h4>' +
                        '</li>';
                        
                    $('#notification-list').append(notificationItem);

                    // 알림 아이콘에 카운트 추가
                    var icon = $('#notification-icon');
                    var count = $('<span class="total-count">!</span>'); // 알림 카운트 생성
                    icon.after(count); // 알림 카운트 추가

                }
            } catch (e) {
                console.error("메시지 파싱 오류:", e, event.data);
            }
        };

        socket.onerror = function(error) {
            console.error("웹소켓 오류 발생:", error);
        };

        socket.onclose = function(event) {
            console.log("웹소켓 연결 종료", event);
        };

        $('#clear-notifications').on('click', function() {
            $('#notification-list').empty();
            $('#notification-icon').next('.total-count').remove(); // 알림 카운트 제거
            $('#notification-push').empty(); // 알림 메시지 제거
        });
        
     	// 알림 항목 클릭 시 상세 페이지로 이동
        $('#notification-list').on('click', '.notification-item', function() {
            var apdIdx = $(this).data('apd-idx');
            window.location.href = 'auctionDetail?APD_IDX=' + apdIdx;
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
