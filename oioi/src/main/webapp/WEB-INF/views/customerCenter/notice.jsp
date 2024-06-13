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
    <title>공지사항</title>
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

    h2 {
        font-size: 32px;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 45px;
        text-align: center;
        table-layout: fixed;
        border-radius: 8px; /* 모서리 둥글게 처리 */
        overflow: hidden;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 10px; /* 셀 간격 늘리기 */
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    th {
        background-color: #f2f2f2;
        font-weight: bold;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9; /* 번갈아가는 행 색상 */
    }

    tr:hover {
        background-color: #f5f5f5; /* 호버 효과 */
    }
    
	
	/* 반응형 디자인을 위해 추가 */
	@media (max-width: 992px) {
	    .main-sidebar,
	    .notice_body {
	        float: none;
	        width: 100%;
	    }
	}
	
	#highlighted-row {
		border: 1px solid #eeeeeec2; 
	}
	
	.notice_body {
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
	
	/* 글쓰기 버튼 위치 */
	.write_btn {
		margin-right: 15px;
		margin-bottom: -15px;
		float: right;
	}
	
	/* 페이징 위치 */
	
	/* faq */
	#faqContent {
		background-color:#e4e4e4;
		width: 100%;
		height: 40%;
		border: none;
		border-radius: 10px;
	}
	
	/* 챗봇 */
	#chatImg {
		width : 60px;
		height : 60px;
		float: right;
	}
		
	.row .chatbot {
	    display: inline-block;
	    vertical-align: top;
	    text-align: center; /* 이미지 가운데 정렬 */
	}
	
	#chatImg {
 	    max-width: 100%; /* 이미지가 부모 요소를 넘지 않도록 조정 */ 
	    height: auto;
	}
	
	.chatbot img {
		border : 0.5px solid #eeeeeec2;
		padding : 5px;
	    border-radius: 40%
	}
	
	.pagination {
		display : flex;
	}
	.paging{
		margin : 0px auto;
		margin-bottom : 20px;
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
		  				<em class = "cs_title_1">공지사항</em><br>
		  				<em class = "cs_sub_title">오이마켓 소식을 알려드립니다</em>
		  			</div>
		  		</div>
			 
					<div class="notice_body">
				 		 <div class = "write_btn">
						 	<a href = "noticeWrite"> 글쓰기 </a>
						 </div>
						<table>
					        <thead>
					            <tr>
					                <th class="notice_num"  width = "10px">번호</th>
					                <th class="notice_title"  width = "150px">제목</th>
					                <th class="notice_writer"  width = "30px">작성자</th>
					                <th class="notice_date"  width = "30px">작성일</th>
					            </tr>
					        </thead>
					        <tbody>
				                  <tr>
				                      <td> 1 </td>
				                      <td><a href="noticeDetail"> 저쩌구 </a></td>
				                      <td> 관리자</td>
				                      <td> 2024.06.07 </td>
				                  </tr>
					        </tbody>
					    </table>
					</div>
				</div>
				
				<%-- 페이징 --%>
				<nav aria-label="Page navigation example" style="display:flex">
					<div class = "paging">
				  		<ul class="pagination">
				    		<li class="page-item">
						    <a id="previousPageLink" class="page-link" href="notice?pageNum=${pageNum - 1}" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						    </a>
						</li>
						
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						    <li class="page-item">
						        <a class="page-link pageLink" href="notice?pageNum=${i}">${i}</a>
						    </li>
						</c:forEach>
						
						<li class="page-item">
						    <a id="nextPageLink" class="page-link" href="notice?pageNum=${pageNum + 1}" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						    </a>
						</li>
			
				  		</ul>
			  		</div>
				</nav> 
				
				<script>
				    // JavaScript를 사용하여 페이지 링크의 클릭 이벤트를 관리합니다.
				    document.addEventListener('DOMContentLoaded', function() {
				        var previousPageLink = document.getElementById('previousPageLink');
				        var nextPageLink = document.getElementById('nextPageLink');
				
				        // pageNum이 1 이하일 경우 이전 페이지 링크를 비활성화합니다.
				        if (${pageNum le 1}) {
				            previousPageLink.addEventListener('click', function(event) {
				                event.preventDefault(); // 링크 클릭을 막음
				                alert("더이상 페이지가 없습니다");
				            });
				        }
				
				        // endPage가 maxPage보다 크거나 pageNum + 1이 maxPage보다 클 경우 다음 페이지 링크를 비활성화합니다.
				        if (${endPage gt pageInfo.maxPage} || ${pageNum + 1 gt pageInfo.maxPage}) {
				            nextPageLink.addEventListener('click', function(event) {
				                event.preventDefault(); // 링크 클릭을 막음
				                alert("더이상 페이지가 없습니다");
				            });
				        }
				    });
				</script>
				
			    
			</div>
			<%-- 챗봇 --%>
			 <div class="col-lg-1 col-12 d-flex align-items-end">
				 <div class="chatbot">
			        <a href="chatbot" onclick="window.open(this.href, '_blank', 'width=500, height=700, left=1600, top=200, resizable=no'); return false;"><img src="${pageContext.request.contextPath}/resources/images/chatbot2.PNG" id="chatImg" alt=""></a>
			    </div>
<!-- 		        <div class="col-md-5 col-lg-4 order-md-last" id="paymentSide" style="background-color: gray"> -->
		        
<!-- 		        </div> -->
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