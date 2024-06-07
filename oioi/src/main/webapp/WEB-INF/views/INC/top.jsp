<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<style>
	#searchDiv {
		margin-top : 10px;
		display : none;
		background-color : #E4E4E4;
		border:none;
		border-radius: 5px;
	}
</style>
<script type="text/javascript">

	function searchDivOpen() {
		 document.querySelector("#searchDiv").style.display = "block";
	}
	
	function searchDivClose() {
		 document.querySelector("#searchDiv").style.display = "none";
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
								<ul class="list-main">
									<li><i class="ti-power-off"></i><a href="login">로그인</a></li>
									<li><i class="ti-home"></i><a href="myStore">내 상점</a></li>
								</ul>
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
						<div class="logo">
							<a href="./"><img src="images/logo.png" alt="logo"></a>
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
									<input name="search" placeholder="검색어 입력해줘" type="search" onkeyup="searchDivOpen()" onblur="searchDivClose()">
									<div id="searchDiv"> 추천 검색어 </div>
									<button class="btnn"><i class="ti-search"></i></button>
								</form>
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
								<a href="ChatList" onclick="window.open(this.href, '_blank', 'width=500, height=700, left=500, top=200, resizable=no'); return false;" class="single-icon" >
									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chat-text" viewBox="0 0 16 16" >
									  <path d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105"/>
									  <path d="M4 5.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8m0 2.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5"/>
									</svg>
									<span class="total-count">2</span>
								</a>
								
								
								<%-- 채팅목록 미리보기 --%>
								
								<div class="shopping-item">
									<div class="dropdown-cart-header">
										<span>채팅 목록</span>
									</div>
									
									<ul class="shopping-list">
										<li>
											<h4><a href="#">닉네임1</a></h4>
											<p class="quantity" style="padding-bottom: 0px;">대화</p>
										</li>
										<li>
											<h4><a href="#">닉네임2</a></h4>
											<p class="quantity" style="padding-bottom: 0px;">대화</p>
										</li>
									</ul>
									<div class="bottom">
										<a href="ChatList" onclick="window.open(this.href, '_blank', 'width=500, height=700, left=500, top=200, resizable=no'); return false;" class="btn animate">채팅 더보기</a>
									</div>
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
</body>
</html>