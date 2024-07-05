<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="zxx">
<head>
   <!-- Meta Tag -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name='copyright' content=''>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <!-- Title Tag  -->
    <title>Auction</title>
   <!-- Favicon 
        인터넷 위에보면 아이콘 넣기 가능 이미지만 바꾸며ㅑㄴ댐-->
   <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
   <!-- Web Font -->
   <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
   
   <!-- StyleSheet -->
   
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
   <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
   <style type="text/css">
	   	.overlay {
	            position: absolute;
	            top: 0;
	            bottom: 0;
	            left: 0;
	            right: 0;
	            height: 100%;
	            width: 100%;
	            opacity: 0.7;
	            background-color: black;
	            color: white;
	            display: flex;
	            align-items: center;
	            justify-content: center;
	            font-size: 24px;
	            font-weight: bold;
	            border-radius: 5px;
	        }
	        
	        .non_overlay {
	        	display : none;
	        }
   
   </style>
   <script type="text/javascript">
	  let isLoading = false;
	  let isEmpty = false;
	  let pageNum = 1;
	  let listLimit = 4;
	  let statusValue = "";
   
      $(function(){
        
	      function status(value, isNewFilter = false) {
	          console.log("status : " + value);
	          if (isLoading) return;
	          isLoading = true;
	          
	          if (isNewFilter) {
	              $('#statusList').empty();
	              pageNum = 1;
	              statusValue = value;
	          }
	          
	          $.ajax({
	        	 url : "auction",
	        	 type : "POST",
	        	 data : {
	        		 APD_STATUS : value,
	        		 pageNum: pageNum,
	                 listLimit: listLimit
	        	 },
	        	 dataType : "JSON",
	        	 success : function(data){
	        		 console.log("성공 : " + data);
	        		 if(data.length === 0){
	        			 isEmpty = true;
	        		 }else{
// 	        			 var html ='';
// 	            		 $('#statusList').empty().append(html);
	            		 $.each(data, function(index, item) {
	            			 $('#statusList').append(
	                                 '<div class="col-xl-3 col-lg-4 col-md-4 col-12">'
	                                + '<div class="single-product">' 
		           	                + '<div class="product-img">' 
		           	                + '<a href="javascript:void(0)" onclick="return apdDetailView(\'' + item.APD_IDX + '\')">' 
		           	                + '<img class="default-img" src="<%= request.getContextPath() %>/resources/upload/' + item.APD_MAIN_IMAGE + '">'
		           	             	+ '<span class="' + item.APD_STATUS_COLOR +'">' + item.value + '</span>'
	           	                	+ '</a>'
	           	                	+ '<div class="button-head">' 
		           	                + '<div class="product-action">' 
		           	                + '<a data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class="ti-eye"></i><span>Quick Shop</span></a>' 
		           	                + '<a title="Wishlist" href="#"><i class="ti-heart"></i><span>Add to Wishlist</span></a>' 
		           	                + '<a title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>' 
		           	                + '</div>' 
		           	                + '<div class="product-action-2">' 
		           	                + '<form action="auctionDetail">' 
		           	                + '<input type="hidden" name="APD_IDX" value="' + item.APD_IDX + '">' 
		           	                + '<input type="submit" value="상세 페이지로 이동">' 
		           	                + '</form>' 
		           	                + '</div>' 
		           	                + '</div>' 
		           	                + '</div>' 
		           	                + '<div class="product-content">' 
		           	                + '<h3><a href="product-details.html">' + item.APD_NAME + '</a></h3>' 
		           	                + '<div class="product-price">' 
		           	                + '<span>[판매시작가] ' + new Intl.NumberFormat().format(item.APD_START_PRICE) + '원</span><br>' 
		           	                + '<span>[즉시구매가] ' + new Intl.NumberFormat().format(item.APD_BUY_NOW_PRICE) + '원</span>'
		           	                + '<span class="pro_time" style="float:right; color:gray"><small>' + item.RD_DATE +'</small></span>'
		           	                + '</div>' 
		           	                + '</div>' 
		           	                + '</div>' 
		           	                + '</div>'
	                             );
	            		 });
		        		 pageNum++;
	        		 }
	        		 isLoading = false;
	        	 },
	        	 error: function(xhr, status, error) {
	                 console.error('AJAX 요청 오류:', error);
	                 isLoading = false;
	             }
	          });
	      }
	      
		  status(statusValue);
		  
		  $('.nav-link').click(function(e) {
		        e.preventDefault(); // 링크 클릭 기본 동작 방지
		        currentStatus = $(this).attr('data-status');
		        status(currentStatus, true); // 새로운 필터로 데이터 요청
		  });
    	  
    	  $(window).scroll(function() {
              if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100 && !isLoading && !isEmpty) {
            	  status(statusValue);
              }
          });
      });
      
   </script>
</head>
<body class="js">

   <header><jsp:include page="../INC/top.jsp"></jsp:include></header>
   <!-- Breadcrumbs -->
   <div class="breadcrumbs">
      <div class="container">
         <div class="row">
            <div class="col-12">
               <div class="bread-inner">
                  <ul class="bread-list">
                     <li><a href="./">Home<i class="ti-arrow-right"></i></a></li>
                     <li class="active"><a href="notice">경매<i class="ti-arrow-right"></i></a></li>
                     <li class="active"><a href="notice">리스트</a></li>
                  </ul>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- End Breadcrumbs -->
   
      <!-- 인기 상품 -->
   	<!-- 인기 상품? -->
	<div class="product-area most-popular section">
        <div class="container">
            <div class="row">
				<div class="col-12">
					<div class="section-title">
						<h2>인기 상품</h2>
						<a href="#"> 더보기</a>
					</div>
				</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="owl-carousel popular-slider">
                    
                    	<c:forEach var="popular" items="${apdPopular}">
							<!-- 제품 하나하나 -->
							<div class="single-product">
								<div class="product-img">
									<a href="auctionDetail?APD_IDX=${popular.APD_IDX}">
										<img class="default-img" src="<%= request.getContextPath() %>/resources/upload/${popular.APD_MAIN_IMAGE}">
	<!-- 									<img class="hover-img"   alt="#"> -->
										<span class="${popular.APD_STATUS_COLOR}">${popular.APD_STATUS_VALUE}</span> <!-- out-of-stock = 빨간색 / new = 파란?보라?색 / price-dec = 초록색 -->
									</a>
									<div class="button-head">
										<div class="product-action">
											<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a>
										</div>
										<div class="product-action-2">
											<a title="Add to cart" href="auctionDetail?APD_IDX=${popular.APD_IDX}">상품 상세페이지로 바로가기</a>
										</div>
									</div>
								</div>
								<div class="product-content">
									<h3><a href="product-details.html">${popular.APD_NAME}</a></h3>
									<div class="product-price">
										<!-- 세일 기준 -->
	<!-- 									<span class="old">이전가격</span> -->
										<span>[판매시작가]<fmt:formatNumber value="${popular.APD_START_PRICE}" pattern="#,###"/>원</span><br>
										<span>[판매시작가]<fmt:formatNumber value="${popular.APD_BUY_NOW_PRICE}" pattern="#,###"/>원</span>
										<span class="pro_time" style="float:right; color:gray"><small>${popular.RD_DATE}</small></span>
									</div>
								</div>
							</div>
							<!-- 제품 하나 끝 -->
                    	</c:forEach>
                    
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- End Most Popular Area -->
   
   
   
   
   
   
   
   <!-- 다시 -->
   <!-- Start Product Area -->
    <div class="product-area section">
            <div class="container">
            <div class="row">
               <div class="col-12">
                  <div class="section-title">
                     <h2>경매상품</h2>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="col-12">
                  <div class="product-info">
                     <div class="nav-main">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
						    <li class="nav-item"><a class="nav-link" href="#" data-status="APD05">판매중</a></li>
						    <li class="nav-item"><a class="nav-link" href="#" data-status="APD06">입찰중</a></li>
						    <li class="nav-item"><a class="nav-link" href="#" data-status="APD07">경매마감</a></li>
						</ul>
                     </div>
							<div>
                              <div class="row" id="statusList"></div>
                           </div>
                           <div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
    </div>
   <!-- End Product Area -->
   
   

   
      

      
      
    
    <!-- Modal end -->
   <header><jsp:include page="../INC/bottom.jsp"></jsp:include></header>
 
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