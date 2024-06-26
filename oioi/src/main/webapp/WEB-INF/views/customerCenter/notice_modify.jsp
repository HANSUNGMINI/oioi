<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="zxx"><head>
	<!-- Meta Tag -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="copyright" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Title Tag  -->
    <title>공지사항 수정</title>
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
	
	<!-- 썸머노트 -->
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	
</head>

<style>
 .highlighted-row {
        margin-top: 30px;
        background:#fff;
        border:1px solid #ccc;
        border-radius: 8px;
        padding: 30px;
        width: 100%;    
        height: 100%;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    
	/* 반응형 디자인을 위해 추가 */
	@media (max-width: 992px) {
	    .main-sidebar,
	    .notice_body {
	        float: none;
	        width: 100%;
	    }
	}
	
	/* 중앙 정렬을 위한 Flexbox 설정 */
	#highlighted-row {
	    display: flex;
	    justify-content: center; /* 가로 축 가운데 정렬 */
	    align-items: center; /* 세로 축 가운데 정렬 */
	    border: 1px solid #eeeeeec2;
	    background: #fff;
	    border-radius: 8px;
	    padding: 30px;
	    width: 100%;
	    height: 100%;
	}
	
	#highlighted-row .row {
	    padding: 10px;
	    display: flex;
	    flex-direction: column; /* 세로로 정렬 */
	    align-items: center; /* 가로 축 가운데 정렬 */
	}
	
	.notice_body {
		padding: 10px;
	}
	
	#highlighted-row .row {
		padding: 10px;
	}
	
	/* 제목 */
	.cs_title_container {
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    margin-top: 30px;
	    margin-bottom: 30px;
	    width: 100%;
	    text-align: center;
	}
	
	.cs_title {
	    text-align: center;
	    margin : 0px auto;
	}
	
	.cs_title_1 {
	    font-size: 24px; /* Adjust font size as needed */
	    font-weight: bold;
	}
	
	.cs_sub_title {
	    font-size: 16px; /* Adjust font size as needed */
	    color : #34A853;
	}
	
	/* 글 적는 곳 */ 
	#title {
		border-radius: 10px;
		border : none;
	}
	
	.detail_view {
		text-align : center;
		padding : 30px;
	}
	
	.detail_view .view_tit {
		margin-top : 20px;
		margin-bottom : 30px;
	}
	
	.view_tit h3 {
		font-size: 20px;
	}
	
	.detail_view .view_info {
		border-top : 1px solid #999;
		border-bottom : 1px solid #999;
		margin : auto;
		width : 100%;
		padding-top : 10px;
		padding-bottom : 10px;
	}
	
	.detail_view {
		border-radius : 15px;
		background-color : #F3F3F3;
		width : 100%;
	}
	
	em {
		padding : 5px;	
	}
	
	.note-editing-area {
		background-color : white;
	}
	
	.view_cont {
		margin-top : 10px;
		background-color : white;
	/* 	padding-bottom : 30px; */
	}
	
	/* 제출 버튼 */
	
	.button-container {
	    display: flex;
	    justify-content: center;
	    margin-top: 20px; /* Adjust the margin as needed */
	}
	
	.btn.btn-primary {
		padding : 7px;
	}
</style>

<script type="text/javascript">
	
	let previousLink = null;
	let previousText = "";
	
	function clickCategory(element) {
	    // 모든 <a> 태그의 굵기 초기화
	    // 이전에 클릭된 링크가 있으면, 텍스트와 스타일을 복원
	    if (previousLink) {
	        previousLink.style.fontWeight = 'normal';
	        previousLink.textContent = previousText;
	    }
	    
	 // 현재 클릭된 링크의 원래 텍스트와 스타일을 저장
	    previousLink = element;
	    previousText = element.textContent;

	    // 클릭된 <a> 태그의 텍스트를 굵게 변경하고 텍스트 추가
	    element.style.fontWeight = 'bold';
	    element.textContent = "> " + previousText;
}


</script>

<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<!-- Preloader -->
<!-- Start Blog Single -->
<!-- Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="bread-inner">
						<ul class="bread-list">
							<li><a href="./">Home<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="notice">고객센터<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="notice">공지사항<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="noticeWrite">공지사항 작성</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

<section class="blog-single shop-blog grid section"  style="padding-top:10px">
	<div class="container">
		<div class="row">
			<%-- 사이드바 --%>
			<div class="col-lg-3 col-12">
				<div class="main-sidebar">
					<!-- Single Widget -->
					<div class="single-widget category">
						<ul class="categor-list">
							<li><a href="notice" onclick="clickCategory(this)">공지사항</a></li>
							<li><a href="qna" onclick="clickCategory(this)">문의내역</a></li>
						</ul>
					</div>
				</div>
			</div>
			
			
			<%-- 본문 --%>
			 <div class="col-lg-8 col-12" id="highlighted-row"> 
				 <div class="row">
				 
					 <div class="cs_title_container">
						<div class = "cs_title">
			  				<em class = "cs_title_1">공지사항 수정</em><br>
			  			</div>
			  		</div>
			  		
			   		<form action="noticeWrite" method= "post">
			   			<div class = "detail_view">
							 <div class ="view_tit">
				  				<h3><input type = "text" id="title" placeholder="제목을 입력하시오" name = "board_subject" style = "width : 400px" required="required" maxlength="50"> </h3>
				  			</div>
			  			
			  			<div class = "view_info">
							<em><b>작성자</b></em>
							<em>${sessionScope.member_id}</em>
							<input type="checkbox" name="important" value="important" style="margin-left:50px" > 주요공지 
			  			</div>
			  			
						
						<textarea id="summernote" style = "background-color:white" name = "board_content" required="required" maxlength="7000"></textarea>
						    <script>
						    $('#summernote').summernote({
						        placeholder: '내용을 입력하시오 (글자수 5000자까지 가능합니다)',
						        tabsize: 2,
						        height: 400,
						        toolbar: [
						          ['style', ['style']],
						          ['font', ['bold', 'underline', 'clear']],
						          ['color', ['color']],
						          ['para', ['ul', 'ol', 'paragraph']],
						          ['table', ['table']],
				// 		          ['insert', ['link', 'picture', 'video']],
						          ['view', ['fullscreen', 'codeview', 'help']]
						        ]
						      });
						    </script>
					    </div>
					    
					     <div class="button-container">
			 				<input type="submit"  value = "수정" class="btn btn-primary" >
			 				<input type="button"  value = "취소" class="btn btn-primary" onclick="history.back()">
			 			</div>	
				    </form>
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