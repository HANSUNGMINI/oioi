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
    <title>커뮤니티 게시판</title>
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
		border-radius: 3px;
		
	}
	
	#report {
		font-size: 20px;
	}
	
	
	/*신고하기*/
	textarea{
		min-width : 85.5%;
		max-width : 85.5%;
		min-height: 100px;
		box-shadow : inset 3px 3px 10px #e6e6e6;
		vertical-align : top;
		margin-left : 15px;
		margin-top : 15px;
	}
	
	[type="radio"] {
		padding : 5px;
		vertical-align: middle;
		appearance: none;
		border: max(2px, 0.1em) solid gray;
		border-radius: 50%;
		width: 1.25em;
		height: 1.25em;
		}
	
	[type="radio"]:checked {
	  border: 0.4em solid #34A853;
	}
	
	[type="radio"]:focus-visible {
	  outline: max(2px, 0.1em) dotted #34A853;
	  outline-offset: max(2px, 0.1em);
	}
	
	[type="radio"]:hover {
	  box-shadow: 0 0 0 max(4px, 0.2em) lightgray;
	  cursor: pointer;
	}
	
	[type="radio"]:hover + span {
	  cursor: pointer;
	}
	
	.modal-header-community {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align: start;
    align-items: flex-start;
    -ms-flex-pack: justify;
    justify-content: space-between;
    padding: 15px;
    border-bottom: 1px solid #e9ecef;
    border-top-left-radius: .3rem;
    border-top-right-radius: .3rem;
	}

	.modal-body-community {
	    position: relative;
	    -ms-flex: 1 1 auto;
	    flex: 1 1 auto;
	    padding: 1rem;
	}
	
	.modal-dialog-community {
    position: relative;
    width: auto;
    margin: 10px;
    pointer-events: none;
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
	
	
	function confirmDelete(CM_IDX) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = 'boardDelete?CM_IDX=' + CM_IDX;
        }
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
			
			
			<%-- 본문 --%>
			 <div class="col-lg-12 col-12" id="highlighted-row"> 
				 <div class="row">
				 
					 <div class="cs_title_container">
					 	<div class = "notice_d_t_div">
<!-- 				  			<em class = "notice_d_title">게시판</em><br> -->
				  		</div>
				  	 </div>
			  		
			   		<form action="#">
			   			<div class = "detail_view" 
			   				<c:if test="${boardDetail.CM_CONTENT.length() < 500}"> 
			   					style="width: 900px; height: 800px;"
    						</c:if>
    						>
							 <div class ="view_tit">
				  				<h3>${boardDetail.CM_TITLE}</h3>
				  			</div>
			  			
				  			<div class = "view_info" style="display: flex; justify-content: space-between; align-items: center;" align="center">
				  			<span style="margin-left:auto">
								<em><b>닉네임</b></em>
								<em>${boardDetail.CM_NICK}</em>
								<em class="em"><b>날짜</b></em>
								<em>${boardDetail.CM_REG_DATE}</em>
								<em class="em"><b>조회수</b></em>
								<em>${boardDetail.CM_READ_COUNT}</em>
							</span>
								    <span style="margin-left: auto;">
								    	<a id="report" href="javascript:void(0);" data-toggle="modal" data-target="#notify_model">🚨</a>
								    </span>
				  			</div>
							<div class = "view_cont" <c:if test="${boardDetail.CM_CONTENT.length() < 500}"> style="width: 840px; height: 600px;"
    						</c:if>>
							
				  				<p style="font-size: 20px; padding-top: 30px;">
				  					<c:if test="${boardDetail.CM_IMAGE1 != null}">
				  						<img src="${pageContext.request.contextPath}/resources/upload/${boardDetail.CM_IMAGE1}" alt="#" style="width: 200px; height: 200px; ">
				  					</c:if>
				  					<c:if test="${boardDetail.CM_IMAGE2 != null}">
				  						<img src="${pageContext.request.contextPath}/resources/upload/${boardDetail.CM_IMAGE2}" alt="#" style="width: 200px; height: 200px;">
				  					</c:if>
				  					<c:if test="${boardDetail.CM_IMAGE3 != null}">
				  						<img src="${pageContext.request.contextPath}/resources/upload/${boardDetail.CM_IMAGE3}" alt="#" style="width: 200px; height: 200px;">
				  					</c:if>
				  					${boardDetail.CM_CONTENT}
								</p>
				  			</div>
					    </div>
					    
					     <div class="button-container" style="padding:4px">
			 				<input type="button"  value = "목록" class="btn btn-primary" onclick="location.href='community?type=${boardDetail.CM_CATEGORY}'" style="margin-right:10px;">
			 				 <c:if test="${boardDetail.CM_ID eq sessionScope.US_ID || not empty sessionScope.isAdmin}">
				 				<input type="button"  value = "수정" class="btn btn-primary" onclick="location.href='boardModify?CM_IDX=${boardDetail.CM_IDX}'" style="margin-right:10px;">
				 				<input type="button"  value = "삭제" class="btn btn-primary" onclick="confirmDelete(${boardDetail.CM_IDX})">
			 				</c:if>
			 			</div>	
				    </form>
				 </div>
			</div>
		</div>
	</div>
	
	<%-- 신고하기 --%>
	<div class="modal" id="notify_model">
		<div class="modal-dialog-community">
			<div class="modal-content" style="width:500px; margin:auto;">
			<!-- Modal Header -->
			<div class="modal-header-community">
			<h4 class="modal-title">신고하기</h4>
			</div>
      	<form action="report" method="post" enctype="multipart/form-data"  onsubmit="return validateReport()">
	      <!-- Modal body -->
	      <div class="modal-body-community">
	      	
		      <%-- 라디오박스 --%>
		      	<c:forEach var="report" items="${reportMap}">
		      		<c:set var="i" value="${i+1}"></c:set>
					<label for="n${i}"><input type="radio" name="RP_CATEGORY" id="n${i}" value="${report.code}">  &nbsp;${report.value}</label> <br>
		      	</c:forEach>
				
				<%-- 파일 --%>
				<div style="padding:5px;">
                    <small>이미지는 최대 2장 등록 가능합니다</small>
                    
			         <input type="file" id="fileInput" style="display: none;" name="RP_IMG" accept=".png, .jpeg" multiple>
					<div class="preView">
						<img src="${pageContext.request.contextPath}/resources/images/submitIMG.png" name="reportImg" class="tempImg addImg" id="uploadTrigger">
					</div>
				</div>
				
				<%-- 내용 입력 --%>
				<textarea placeholder="내용을 입력하세요"
				
				
				 style = "resize : none" name="RP_CONTENT"  id="RP_CONTENT" maxlength="300"></textarea>
		  </div>
		  
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="submit" class="btn btn-success">신고하기</button>
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
			<input type="hidden" name="TO_ID" value="${param.TO_ID}">
			<input type="hidden" name="PD_IDX" value="${param.PD_IDX}">
		</form>			      
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