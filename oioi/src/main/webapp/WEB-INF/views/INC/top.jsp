<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name='copyright' content=''>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/topChatting.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/push/alarm.css">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
    var jq171 = jQuery.noConflict(true); // 이 버전의 jQuery를 별도의 변수에 저장하고, noConflict 모드로 설정
</script>
<!-- 아이콘 사용 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script type="text/javascript">
// 	function searchDivOpen() {
// 		 document.querySelector("#searchDiv").style.display = "block";
// 	}
	
	function searchDivClose() {
			setTimeout(function() {
                document.querySelector("#searchDiv").style.display = "none";
            }, 200) // 짧은 지연 시간을 추가하여 링크 클릭을 허용
	}
	
	function openChatting(url) {
		window.open(url, '_blank', 'width=500, height=700, left=720, top=200, resizable=no'); 
	}
	
	function openOIPay() {
			window.open('oiPay', '_blank', 'width=550, height=600, left=720, top=200, resizable=no'); 
	}
	
	function connectAct() {
// 			window.open('connectAct', '_blank', 'width=550, height=335, left=720, top=200, resizable=no'); 
			window.open('connectAct', '_blank', 'width=550, height=600, left=720, top=200, resizable=no'); 
	}
	
	/* 안 읽은 메세지 개수 */
	function getUnreadCount(){
    	 $.ajax({
   	        type: "get",
   	        url: "getMyUnreadCount",
   	        data: {
   	            US_ID: "${sessionScope.US_ID}"
   	        },
   	        success: function(data){
   	        	
   	        	let US_ID = "${sessionScope.US_ID}"
   	        	
   	        	if(US_ID != '' && data != 0) {
   	        		let unread = '<span class="total-count">'+ data +'</span>'
   	        		("#here").append(unread)
   	        	}
   	        	
   	        }
   	    });
    }
    
</script>
</head>
<body>
<header class="header shop v2">
		<!-- Topbar -->
		<div class="topbar">
			<div class="container">
				<div class="inner-content">
					<div class="row">
						<div class="col-lg-4 col-md-12 col-12">
							<!-- Top Left -->
							<div class="top-left">
								<ul class="list-main">
									<li><i class="ti-headphone-alt"></i> 010 5668 2627</li>
								</ul>
							</div>
							<!--/ End Top Left -->
						</div>
						<div class="col-lg-8 col-md-12 col-12">
							<!-- Top Right -->
							<div class="right-content">
							    <c:choose>
							        <c:when test="${sessionScope.isAdmin}">
							            <ul class="list-main">
							                <li><i class="ti-home"></i><a href="admin">관리자 페이지</a></li>
							                <li><i class="ti-shift-left"></i><a href="logout">로그아웃</a></li>
							            </ul>
							        </c:when>
							        <c:when test="${empty sessionScope.US_ID}">    
							            <ul class="list-main">
							                <li><i class="ti-power-off"></i><a href="adminlogin">관리자 로그인</a></li>
							                <li><i class="ti-shift-right"></i><a href="login">로그인</a></li>
							                <li><i class="ti-wand"></i><a href="easy_login">간편 로그인</a></li>
							            </ul>
							        </c:when>
							        <c:otherwise>
							            <c:choose>
							                <c:when test="${not empty sessionScope.KAKAO_LOGIN}">
							                    <ul class="list-main">
							                        <li>${sessionScope.US_NICK} 님</li>
							                        <li><i class="ti-home"></i><a href="myStore?userId=${sessionScope.US_ID}">내 상점</a></li>
							                        
							                        <c:choose>
							                            <c:when test="${empty sessionScope.BUI_ACCESS_TOKEN}">
							                                <li onclick="connectAct()" style="cursor: pointer;"><i class="ti-money"></i>OI 페이</li>
							                            </c:when>
							                            <c:otherwise>
							                                <li onclick="openOIPay()" style="cursor: pointer;"><i class="ti-money"></i>OI 페이</li>
							                            </c:otherwise>
							                        </c:choose>
							                        
							                        <li><i class="ti-shift-left"></i><a href="kakao_logout">로그아웃</a></li>
							                    </ul>
							                </c:when>
							                <c:when test="${not empty sessionScope.NAVER_LOGIN}">
							                    <ul class="list-main">
							                        <li>${sessionScope.US_NICK} 님 </li>
							                        <li><i class="ti-home"></i><a href="myStore?userId=${sessionScope.US_ID}">내 상점</a></li>
							                        
							                        <c:choose>
							                            <c:when test="${empty sessionScope.BUI_ACCESS_TOKEN}">
							                                <li onclick="connectAct()" style="cursor: pointer;"><i class="ti-money"></i>OI 페이</li>
							                            </c:when>
							                            <c:otherwise>
							                                <li onclick="openOIPay()" style="cursor: pointer;"><i class="ti-money"></i>OI 페이</li>
							                            </c:otherwise>
							                        </c:choose>
							                        
							                        <li><i class="ti-shift-left"></i><a href="logout">로그아웃</a></li>
							                    </ul>
							                </c:when>
							                <c:otherwise>
							                    <ul class="list-main">
							                        <li>${sessionScope.US_NICK} 님</li>
							                        <li><i class="ti-home"></i><a href="myStore?userId=${sessionScope.US_ID}">내 상점</a></li>
							                        
							                        <c:choose>
							                            <c:when test="${empty sessionScope.BUI_ACCESS_TOKEN}">
							                                <li onclick="connectAct()" style="cursor: pointer;"><i class="ti-money"></i>OI 페이</li>
							                            </c:when>
							                            <c:otherwise>
							                                <li onclick="openOIPay()" style="cursor: pointer;"><i class="ti-money"></i>OI 페이</li>
							                            </c:otherwise>
							                        </c:choose>
							                        
							                        <li><i class="ti-shift-left"></i><a href="logout">로그아웃</a></li>
							                    </ul>
							                </c:otherwise>
							            </c:choose>
							        </c:otherwise>
							    </c:choose>
							</div>
							<!-- End Top Right -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Topbar -->
		<div class="middle-inner">
			<div class="container">
				<div class="row">
					<div class="col-lg-2 col-md-2 col-12">
						<!-- Logo -->
						<div class="logo" style="width: 220px; ">
							<a href="./"><img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="margin-top:-12px; margin-left: 10px"></a>
						</div>
						<!--/ End Logo -->
						<!-- Search Form -->
						<div class="search-top">
							<div class="top-search"><a href="#0"><i class="ti-search"></i></a></div>
							<!-- Search Form -->
							<div class="search-top">
								<form class="search-form">
									<input type="text" placeholder="Search here..." name="search">
									<button value="search" type="submit"><i class="ti-search"></i></button>
								</form>
							</div>
							<!--/ End Search Form -->
						</div>
						<!--/ End Search Form -->
						<div class="mobile-nav"></div>
					</div>
					<div class="col-lg-8 col-md-6 col-12">
						<div class="search-bar-top">
							<div class="search-bar" onclick="showHandler()" onblur="searchDivClose()" id="searchbarDiv">
								<input type="text" name="search" placeholder="검색어를 입력해 주세요" autocomplete="off" style="width:100%" id="searchKeyword" >
								<button class="btnn" onclick="searchKeyword()"><i class="ti-search"></i></button>

								<div id="searchDiv"> 
									<div class="recentSearch"> 
									</div>
									<div class="popularSearch">
									</div>
									<div class="recommendKeyword">
									</div>
								</div>
								
							</div>
						</div>
					</div>
					<div class="col-lg-2 col-md-3 col-12">
						<div class="right-bar">
							
							<!-- 알림 -->
							<div class="sinlge-bar shopping">
								<a href="#" class="single-icon"><i class="ti-bell" aria-hidden="true" id="notification-icon"></i></a>
								<!-- Push List -->
								<div class="shopping-item">
									<div class="dropdown-cart-header" id="notification-push">
										
									</div>
									<ul class="shopping-list" id="notification-list">
									    <!-- 알림 항목들이 여기에 추가될 예정 -->
<!-- 									    <li> -->
<!-- 											<a class="cart-img" href="#"><img src="images/product-1.jpg" alt="#"></a> -->
<!-- 											<h4><a href="#">Woman Ring</a></h4> -->
<!-- 											<p class="quantity">1x - <span class="amount">$99.00</span></p> -->
<!-- 										</li> -->

									</ul>
									<div class="bottom">
									    <a href="#" class="btn animate" id="clear-notifications">모두 지우기</a>
									</div>
								</div>
								<!--/ End Push List -->
							</div>
							
							<div class="sinlge-bar">
								<a href="myPage" class="single-icon"><i class="fa fa-user-circle-o" aria-hidden="true"></i></a>
							</div>
							
							<%--  채팅 --%>
							
							<div class="sinlge-bar shopping" >
							
							
								<a <c:if test="${not empty sessionScope.US_ID}"> href="ChatList?US_ID=${sessionScope.US_ID}" onclick="window.open(this.href, '_blank', 'width=500, height=700, left=720, top=200, resizable=no'); return false;" </c:if> class="single-icon" >
									<i class="bi bi-chat-text" id="here"></i>
<%-- 									<c:if test="${not empty sessionScope.US_ID}"> --%>
<!-- 										<span class="total-count">2</span> -->
<%-- 									</c:if> --%>
								</a>
								
								
								<%-- 채팅목록 미리보기 --%>
								
								<div class="shopping-item">
									<div class="dropdown-cart-header">
										<span>채팅 목록</span>
									</div>
									
									<c:choose>
										<c:when test="${empty sessionScope.US_ID}">
											<ul class="shopping-list">
												<li> 채팅 목록이 존재하지 않습니다. </li>
											</ul>
										</c:when>
										<c:otherwise>

											<ul class="shopping-list">
												<li onclick="openChatting('Chatting')">
													<%-- 사용자 이미지 --%>
													<div class="message-avatar">
														<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="">
													</div>
													<%-- 대화 내용 --%>
													 <div class="list-item-content">
														<h4><a href="#">닉네임1</a></h4>
														<p class="quantity" style="padding-bottom: 0px;">대화</p>
													</div>
												</li>
												<li onclick="openChatting('Chatting')">
													<%-- 사용자 이미지 --%>
													<div class="message-avatar">
														<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="">
													</div>
													<%-- 대화 내용 --%>
													 <div class="list-item-content">
														<h4><a href="#">닉네임2</a></h4>
														<p class="quantity" style="padding-bottom: 0px;">대화</p>
													</div>
												</li>
											</ul>
											
											<div class="bottom">
												<a href="ChatList" onclick="window.open(this.href, '_blank', 'width=500, height=700, left=720, top=200, resizable=no'); return false;" class="btn animate">채팅 더보기</a>
											</div>
										</c:otherwise>
									</c:choose>
									
									
								</div>
								<!--/ End Shopping Item -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Header Inner -->
		<div class="header-inner">
			<div class="container">
				<div class="cat-nav-head">
					<div class="row">
						<div class="col-12">
							<div class="menu-area">
								<!-- Main Menu -->
								<nav class="navbar navbar-expand-lg">
									<div class="navbar-collapse">	
										<div class="nav-inner">	
											<ul class="nav main-menu menu navbar-nav">
												<li><a href="trade">거래</a></li>
												<li><a href="auction">경매<i class="ti-angle-down"></i></a>
													<ul class="dropdown">
														<li><a href="auctionRegist">경매상품등록</a></li>
														<li><a href="auction">경매리스트</a></li>
													</ul>
												</li>												
												<li><a href="community">커뮤니티</a></li>												
												<li><a href="notice">고객센터</a></li>												
												<!-- 지우지마 -->
												<li><a href="#">드롭다운 예시 남겨둔거<i class="ti-angle-down"></i></a>
													<ul class="dropdown">
														<li><a href="about-us.html">About Us</a></li>
														<li><a href="login.html">Login</a></li>
														<li><a href="register.html">Register</a></li>
														<li><a href="mail-success.html">Mail Success</a></li>
														<li><a href="404.html">404</a></li>
													</ul>
												</li>									
											</ul>
										</div>
									</div>
								</nav>
								<!--/ End Main Menu -->	
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--/ End Header Inner -->
	</header>
	 <!-- JavaScript 및 WebSocket 관련 스크립트 -->
    <script>
    
 	// 숫자를 원 단위로 포맷하는 함수 정의
    function formatCurrency(num) {
        return new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(num);
    }
    
    $(document).ready(function() {
    	getUnreadCount(); 
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
	<script src="${pageContext.request.contextPath}/resources/js/auction/notify.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/topSearch.js"></script>
</body>
</html>