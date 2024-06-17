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

<!-- 아이콘 사용 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script type="text/javascript">

	function searchDivOpen() {
		 document.querySelector("#searchDiv").style.display = "block";
	}
	
	function searchDivClose() {
		 document.querySelector("#searchDiv").style.display = "close";
	}
	
	function openChatting(url) {
		window.open(url, '_blank', 'width=500, height=700, left=720, top=200, resizable=no'); 
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
									<li><i class="ti-headphone-alt"></i> 010 5668 2627 후원좀</li>
								</ul>
							</div>
							<!--/ End Top Left -->
						</div>
						<div class="col-lg-8 col-md-12 col-12">
							<!-- Top Right -->
							<div class="right-content">
							<c:choose>
								<c:when test="${empty sessionScope.US_ID}">	
									<ul class="list-main">
										<li><i class="ti-power-off"></i><a href="adminlogin">관리자 로그인</a></li>
										<li><i class="ti-power-off"></i><a href="login">로그인</a></li>
									</ul>
								</c:when>
								<c:otherwise>
									
									<ul class="list-main">
										<li>${US_NICK} 님</li>
										<li><i class="ti-home"></i><a href="myStore">내 상점</a></li>
										<li><i class="ti-money"></i><a href="oiPay">OI 페이</a></li>
										<li><i class="ti-shift-left"></i><a href="logout">로그아웃</a></li>
									</ul>
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
					<div class="col-lg-8 col-md-7 col-12">
						<div class="search-bar-top">
							<div class="search-bar">
								<select>
									<option selected="selected">카테고리</option>
									<option>괜히</option>
									<option>했나</option>
									<option>싶기도하고</option>
								</select>
								<form>
									<input name="search" placeholder="검색어 입력해줘" type="search" autocomplete="off"  onkeyup="searchDivOpen()" onblur="searchDivClose()">
									<button class="btnn"><i class="ti-search"></i></button>
								</form>
									<div id="searchDiv" style="background-color:#F6F6F6" > 
										<span style="color:#CC3D3D; font-weight: bold;">인기 검색어</span>
											<a href="trade" class="searchKey">삼성 노트북</a> <a href="trade" class="searchKey">신발</a>
										<hr>
										<div class="recommondKeyword" >
											<ul>
												<li><a href="trade">아이폰6</a></li>
												<li><a href="trade">아이폰7</a></li>
												<li><a href="trade">아이폰8</a></li>
												<li><a href="trade">아이폰8 Pro</a></li>
											</ul>
										</div>
									</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2 col-md-3 col-12">
						<div class="right-bar">
							
							<!-- 알림 -->
							<div class="sinlge-bar shopping">
								<a href="#" class="single-icon"><i class="ti-bell" aria-hidden="true"></i></a>
								
								<div class="shopping-item shopping">
									<div class="dropdown-cart-header">
									알림
									</div>
								</div>
							</div>
							
							
							<div class="sinlge-bar">
								<a href="myPage" class="single-icon"><i class="fa fa-user-circle-o" aria-hidden="true"></i></a>
							</div>
							
							<%--  채팅 --%>
							
							<div class="sinlge-bar shopping" >
							
							
								<a <c:if test="${not empty sessionScope.US_ID}"> href="ChatList" onclick="window.open(this.href, '_blank', 'width=500, height=700, left=720, top=200, resizable=no'); return false;" </c:if> class="single-icon" >
									<i class="bi bi-chat-text"></i>
									<c:if test="${not empty sessionScope.US_ID}">
										<span class="total-count">2</span>
									</c:if>
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
												<li><a href="auctionRegist">경매 상품 등록</a></li>												
												<!-- 지우지마 -->
												<li><a href="#">경매<i class="ti-angle-down"></i></a>
													<ul class="dropdown">
														<li><a href="about-us.html">경매중</a></li>
														<li><a href="login.html">입찰예정경매</a></li>
														<li><a href="register.html">종료된경매</a></li>
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
</body>
</html>