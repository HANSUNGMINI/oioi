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
    <title>커뮤니티</title>
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
	<!-- StyleSheet -->
	<script src="https://kit.fontawesome.com/ef42a902c7.js" crossorigin="anonymous"></script>
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
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

    .table1 {
        width: 100%;
        border-collapse: collapse;
        margin-top: 45px;
        text-align: center;
        table-layout: fixed;
        border-radius: 8px; /* 모서리 둥글게 처리 */
        overflow: hidden;
    }

    #th1, #td1 {
        border: 1px solid #ccc;
        padding: 10px; /* 셀 간격 늘리기 */
        text-align: center;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    #th1 {
        background-color: #f2f2f2;
        font-weight: bold;
    }

    .tr1:nth-child(even) {
        background-color: #f9f9f9; /* 번갈아가는 행 색상 */
    }

    .tr1:hover {
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
	
	/* 글쓰기 버튼 위치 */
 	.write_btn { 
 		margin-right: 15px; 
		margin-bottom: -15px; 
 		float: right; 
 	} 
 	 .search-top { 
 	 width : 400px; 
 	 text-align: center; 
 	 margin: 0; 
 	} 
	
 	.search_write { 
 		margin-bottom: 15px; 
 	} 
	
 	.search-form {
 	    width: 100%; 
	} 
	
 	.search-form input { 
 	    flex-grow: 1; 
 	    margin-right: 5px; 
	} 
	
/* 	.form-control { */
/* 		width :300px; */
/* 	} */
	
	.btn-primary, .btn-outline-secondary {
	    position: relative;
	    font-weight: 500;
	    font-size: 14px;
	    color: #fff;
	    background: #333;
	    display: inline-block;
	    -webkit-transition: all 0.4s ease;
	    -moz-transition: all 0.4s ease;
	    transition: all 0.4s ease;
	    z-index: 5;
	    display: inline-block;
	    padding: 8px 20px;
	    border-radius: 0px;
	    text-transform: uppercase;
	}
 	.search-top { 
 		margin-left: 185px; 
 	}
	
	.btn-primary {
		padding: 5px 15px;
	}
	
	.searchCategory {
		margin: 0px;
		height: 34px;
	    line-height: 33px;
	    margin-right: 10px;
	    border-radius: 3px;
	    border: 1px solid #ccc;
	    text-align: left;
	    color: #666;;
	}
	
	.category-list li {
        margin-bottom: 15px; /* 리스트 사이에 공간 추가 */
    }
     .board_num {
		width: 68px; 
		text-align: center;
	}
	
	.board_writer {
		width: 150px;
		text-align: center; 
	}
	
	.board_date {
		width: 200px;
		text-align: center; 
	}
	
	.board_category {
		width: 70px;
		text-align: center;
	}
 
	/* 페이징 위치 */
</style>
<body class="js">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	let categoryType = "";
	$(function() {
		showBoard("");
		
		
		
		// 페이지 로딩 시 "전체 게시판" 링크의 스타일과 텍스트를 변경
		let allElement = $("#all");
		allElement.css("fontWeight", "bold");
		allElement.text("> " + allElement.text());
		
		// 초기화 변수 설정
		let previousLink = allElement[0]; // jQuery 객체를 DOM 요소로 변환
		let previousText = allElement.text().substring(2); // "> " 제거한 텍스트 저장
		
		// 카테고리 클릭 시 실행되는 함수
		window.clickCategory = function(element,type) {
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
		    
		    showBoard(type);
		    
		};
	});
</script>
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<!-- Breadcrumbs -->
		<div class="breadcrumbs">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="bread-inner">
							<ul class="bread-list">
								<li><a href="index1.html">Home<i class="ti-arrow-right"></i></a></li>
								<li class="active"><a href="blog-single.html">커뮤니티</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- Start Blog Single -->
<section class="blog-single shop-blog grid section" style="padding: 10px 0px 100px;"> <!-- style="height: 700px;" -->
	<div class="container">
		<div class="row">
			<%-- 사이드바 --%>
			<div class="col-lg-3 col-12">
				<div class="main-sidebar">
					<!-- Single Widget -->
					<div class="single-widget category">
						<ul class="category-list">
							<li><a href="#" onclick="clickCategory(this, '')" id="all" >전체 게시판</a></li>
							<li><a href="#" onclick="clickCategory(this,'질문 게시판')">질문 게시판</a></li>
							<li><a href="#" onclick="clickCategory(this,'신고 게시판')">신고 게시판</a></li>
							<li><a href="#" onclick="clickCategory(this,'정보 게시판')">정보 게시판</a></li>
							<li><a href="#" onclick="clickCategory(this,'친목 게시판')">친목 게시판</a></li>
						</ul>
					</div>
				</div>
			</div>
		<%-- 본문 --%>
		 <div class="col-lg-9 col-12" id="highlighted-row"> 
			 <div class="row">
					<div class="notice_body">
						<div class="search_write row">
						    <div class="col-md-9" style="height: 40px;">
						        <!-- Search Form -->
						        <div class="search-top">
						            <form class="search-form d-flex">
						            	<select class="searchCategory">
						            		<option value="CM_title">제목</option>
						            		<option value="CM_content">내용</option>
						            	</select>
						                <input type="text" class="form-control" placeholder="검색어 입력" name="search">
						                <button value="search" type="submit" class="btn btn-outline-secondary"><i class="ti-search"></i></button>
						            </form>
						        </div>
						    </div>
						    <div class="col-md-3 text-right">
						        <a href="communityWrite" class="btn btn-primary" style="color: white;">글쓰기</a>
						    </div>
						</div>

						<table class="table1">
					        <thead>
					            <tr class="tr1">
					                <th id="th1" class="board_num">번호</th>
					                <th id="th1" class="board_category">게시판</th>   
					                <th id="th1" class="board_title">제목</th>
					                <th id="th1" class="board_writer">작성자</th>
					                <th id="th1" class="board_date">작성일</th>
					            </tr>
					        </thead>
					        <tbody class="tbody" id="tbody">
<!-- 				                  <tr class="tr1"> -->
<!-- 				                      <td id="td1"> 1 </td> -->
<!-- 				                      <td id="td1"><a href="boardDetail"> 저쩌구 </a></td> -->
<!-- 				                      <td id="td1"> 관리자</td> -->
<!-- 				                      <td id="td1"> 2024.06.07 </td> -->
<!-- 				                  </tr> -->
					        </tbody>
					    </table>
					</div>
				</div>
				
				
				
				<%-- 페이징 --%>
				
			</div>
		</div>
	</div>
</section>



<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
		
<script>
	function showBoard(type){
// 		alert(type);
		
		$.ajax({
			type : "GET",
			url : "selectBoard",
			data : {
				"type" : type
			},
			dataType : "JSON",
			success : function(response) {
				
				let boards = response.boardJson;
				let idx = response.boardJson[0].count;
				
				$("#tbody").empty();
				
				$.each(boards, function(index, board) {
					$("#tbody").append(
						'<tr class="tr1">' +
							'<td id="td1">' + idx-- + '</td>' +
							'<td id="td1">' + board.CM_CATEGORY.substring(0,2) + '</td>' +
							'<td id="td1"><a href="boardDetail?CM_IDX='+ board.CM_IDX +'">'+ board.CM_TITLE + '</a></td>' +
							'<td id="td1">' + board.CM_NICK + '</td>' +
							'<td id="td1">' + board.CM_REG_DATE + '</td>' +
						'</tr>'
					);
				});
				
			},
			error: function(xhr, status, error) {
				console.log("AJAX Error:", status, error); // 에러 로그 추가
			}
		});
	}
// 컨트롤러 > Map으로 받아서 type 뺴네요
// mapper > xml SELECT * FROM board() where <if type="전체 신고"> 전체 신고 전체구문, if 신고면 시곤
</script>
<!-- Jquery -->
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