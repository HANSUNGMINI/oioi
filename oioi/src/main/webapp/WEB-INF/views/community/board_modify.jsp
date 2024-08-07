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
    <title>게시판 수정</title>
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
	<!-- StyleSheet -->
	<script src="https://kit.fontawesome.com/ef42a902c7.js" crossorigin="anonymous"></script>
	<!-- Bootstrap -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
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
	    text-align : center;
	    font-size: 20px;
	    font-weight: bold;
	}
	
	/* 글 적는 곳 */ 
	#title {
		border-radius: 10px;
		border : none;
	}
	
	.detail_view {
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
		background-color: #34A853;
		color: white;
		border-radius: 10px;
	}
	
	.boardCategory {
    	margin-left: 175px;
    	margin-right : 10px;
    	margin-top: -1px;
		height: 33px;
	    line-height: 32px;
	    border-radius: 12px;
	    font-size: 13px;
    }
    
    
</style>

<script type="text/javascript">
	
	let previousLink = null;
	let previousText = "";
	
	 $(function() {
		 
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
	
		$("#fileInput").on("change", function() {
		    if (this.files.length > 3) {
		        alert("최대 3개의 이미지만 업로드할 수 있습니다.");
		        this.value = ""; // 선택된 파일 초기화
		    }
		});
	 });
	


</script>

<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<!-- Preloader -->
<!-- Start Blog Single -->
<section class="blog-single shop-blog grid section">
	<div class="container">
		<div class="row">
			<%-- 본문 --%>
			 <div class="col-lg-12 col-12" id="highlighted-row"> 
				 <div class="row">
					 <div class="cs_title_container">
					 	<div class = "notice_d_t_div">
				  			<em class = "notice_d_title">게시판 수정</em><br>
				  		</div>
				  	 </div>
			  		
			   		<form action="boardModify" method= "post" enctype="multipart/form-data">
				 		<input type="hidden" name="CM_IDX" value="${board.CM_IDX}">
			   			<div class = "detail_view" style="width: 900px; height: 800px;">
							 <div class ="view_tit">
				   				<select class="boardCategory" name="CM_CATEGORY">
									<option value="CC02" <c:if test="${board.CM_CATEGORY == 'CC02'}">selected</c:if>>질문게시판</option>
									<option value="CC03" <c:if test="${board.CM_CATEGORY == 'CC03'}">selected</c:if>>신고게시판</option>
									<option value="CC04" <c:if test="${board.CM_CATEGORY == 'CC04'}">selected</c:if>>정보게시판</option>
									<option value="CC05" <c:if test="${board.CM_CATEGORY == 'CC05'}">selected</c:if>>친목게시판</option>
								</select>
				  				<h3><input type = "text" id="title" value="${board.CM_TITLE}" name = "CM_TITLE" style = "width : 400px" required="required" maxlength="40"> </h3>
				  			</div>
				  			
				  			<div class = "view_info" align="left" style="text-align: center;">
								<input type="file" value="파일 추가하기" name="CM_IMAGE" id="fileInput" multiple>
<!-- 				  			</div> -->
			  			
<!-- 			  			<div class = "view_info"> -->
							<em><b>작성자 : ${board.CM_NICK}</b></em>
			  				</div>
			  			
						
						<textarea id="summernote" style = "background-color:white" name = "CM_CONTENT" required="required" maxlength="500" >
							${board.CM_CONTENT}
						</textarea>
						    <script>
						    $('#summernote').summernote({
						        placeholder: '내용을 입력하세요 (글자수 500자까지 가능합니다)',
						        tabsize: 2,
						        height: 550,
						        toolbar: [
						          ['style', ['style']],
						          ['font', ['bold', 'underline', 'clear']],
						          ['color', ['color']],
						          ['para', ['ul', 'ol', 'paragraph']],
						          ['table', ['table']],
						          ['insert', ['link', 'picture', 'video']],
						          ['view', ['fullscreen', 'codeview', 'help']]
						        ]
						      });
						    </script>
					    </div>
					    
					     <div class="button-container">
			 				<input type="submit"  value = "등록" class="btn btn-primary" style="padding-right: 10px; padding-left: 10px; margin-right: 10px;">
			 				<input type="button"  value = "돌아가기" class="btn btn-primary" style="padding-right: 10px; padding-left: 10px; " onclick="history.back();" >
			 			</div>	
				    </form>
				</div>	
			 </div>
		</div>
	</div>
</section>



<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
		
	
<!-- Jquery -->
<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script> --%>
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