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
    <title>문의하기</title>
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
	
	<!-- 화살표 이미지 -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
	
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

	#highlighted-row {
		border: 1px solid #eeeeeec2; 
	}
	
	.notice_body {
		padding: 10px;
	}
	
	/* 반응형 디자인을 위해 추가 */
	@media (max-width: 992px) {
	    .main-sidebar,
	    .notice_body {
	        float: none;
	        width: 100%;
	    }
	}
	
	/* 안에 내용 비율 조절 */
	#highlighted-row .row {
		padding : 70px;
		display: inline;
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
	}
	
	.cs_title_1 {
	    font-size: 24px; /* Adjust font size as needed */
	    font-weight: bold;
	}
	
	.cs_sub_title {
	    font-size: 16px; /* Adjust font size as needed */
	    color : #34A853;
	}
	
		/* 글 적는 곳*/
	.cs_write input, textarea, select {
		margin-left : 10px;
		padding : 10px;
		border: 1px solid #999;
		border-radius : 10px;
		box-shadow : 3px 3px 10px #e6e6e6;
	}
	
	.cs_write .title_wr input[type = "text"]{
		margin-top : 20px;
		margin-bottom : 20px;
		width : 85.5%;
	}
	
	.cus_info input[type = "text"] {
		margin-right : 20px;
	}
	
	.cs_write .content_wr textarea {
		min-width : 85.5%;
		max-width : 85.5%;
		min-height: 200px;
		box-shadow : inset 3px 3px 10px #e6e6e6;
		vertical-align : top;
	}
	
	.cs_write input[type = "file"] {
		border : none;
		box-shadow : none;
		padding : 10px;
		margin-left : 40px;
	}
	
	.material-symbols-outlined {
		color : #34A853;
	}

	/* 제출 버튼 */
	
	.button-container {
	    display: flex;
	    justify-content: center;
	    margin-top: 20px; /* Adjust the margin as needed */
	}
	
	.btn.btn-primary,btn btn-success {
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
<section class="blog-single shop-blog grid section">
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
			  				<em class = "cs_title_1">1:1 문의</em><br>
			  				<em class = "cs_sub_title">궁금한 점을 해결해 드립니다 :)</em>
			  			</div>
			  		</div>
				 
				 
				 		<div class = "cs_write">
				 			<div class = "cus_info">
				 				작성자 <input type = "text" value="${qna.qna_writer}" name="qna_writer" readonly="readonly">
				 			</div>
				 			
				 			<div class = "title_wr">
				 				제목 <input type = "text" value="${qna.qna_subject}" style = "margin-left : 15px" name ="qna_subject" readonly="readonly">
				 			</div>
				 			
				 			<div class = "content_wr">
				 				질문 <textarea style = "resize : none" readonly="readonly">${qna.qna_content}</textarea>
				 				
				 				<div style="margin-left:50px;">
					 				파일
					 				<c:if test="${not empty qna.qna_file}">
											<c:set var="original_fileName" value="${fn:substringAfter(qna.qna_file, '_')}"/>
											${original_fileName}
											<%-- 다운로드 --%>
											<%-- 다운로드 속성값에 파일명 지정 시 그 이름으로 다운됨 --%>
											<a href="${pageContext.request.contextPath}/resources/upload/${qna.qna_file}" download="${original_fileName}">
												<input type="button" value="다운로드" id="downBtn">
											</a>
									</c:if>
								</div>
				 			</div>
				 			
				 			
				 			<div class = "content_wr" style="margin-top:30px;">
				 				<span class="material-symbols-outlined">
									subdirectory_arrow_right
								</span>
								
								
								
								<%-- 답변 상태에 따라 답변 보여주기 --%>
								<c:choose>
									<c:when test="${qna.qna_status eq 1}"> <%-- 답변 완료 --%>
										 답변 <textarea readonly="readonly" style = "resize : none">${qna.admin_content}</textarea>
									</c:when>
									<c:otherwise> <%-- 미답변 --%>
										 답변 <textarea placeholder="답변 대기 중입니다. 조금만 기다려 주세요." readonly="readonly" style = "resize : none;"></textarea>
									</c:otherwise>
								</c:choose>
								
							</div>
							
							 <div class="button-container" style="padding:4px">
				 				<input type="button"  value = "목록" class="btn btn-primary" onclick="history.back()">
				 				<input type="button"  value = "삭제" class="btn btn-primary" >
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