<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title> 판매페이지 </title>
    <!-- favicon 스크립트 -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
    <!-- Favicon -->
    <!-- <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png"> -->
    <!-- Web Font -->    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
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
    
    <style type="text/css">
        .single-widget.category {
            height: 250px;        
        }
        
        #recentProduct{
        	color : #34A853
        }
        
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
    let listLimit = 12;

    $(document).ready(function() {
        let contextPath = '<%= request.getContextPath() %>';
        let cate2 = JSON.parse('${cate2}');
        let cate3 = JSON.parse('${cate3}');
		
        let urlParams = new URLSearchParams(window.location.search);
        let initialFilter = urlParams.get('filter') || 'newest';
        $('#filter').val(initialFilter);
        
        $('#cate1').change(function() {
            let selectedCate1 = $(this).val();
            let filteredCate2s = cate2.filter(function(cate) {
                return cate.UP_CTG_CODE == selectedCate1;
            });

            $('#cate2').empty().append('<option value="">중분류를 선택하시오</option>');
            $.each(filteredCate2s, function(index, cate) {
                $('#cate2').append($('<option>').text(cate.CTG_NAME).attr('value', cate.CTG_CODE));
            });
            $('#cate2').prop('disabled', false).niceSelect('update');
            $('#cate3').empty().append('<option value="">소분류를 선택하시오</option>');
            $('#cate3').prop('disabled', true).niceSelect('update');
        });

        $('#cate2').change(function() {
            let selectedCate2 = $(this).val();
            let filteredCate3s = cate3.filter(function(cate) {
                return cate.UP_CTG_CODE == selectedCate2;
            });

            $('#cate3').empty().append('<option value="">소분류를 선택하시오</option>');
            $.each(filteredCate3s, function(index, cate) {
                $('#cate3').append($('<option>').text(cate.CTG_NAME).attr('value', cate.CTG_CODE));
            });
            $('#cate3').prop('disabled', false).niceSelect('update');
        });

        $('#cate3').change(function() {
            pageNum = 1;
            isEmpty = false;
            updateProducts(true);
        });
		
        $('#filter').change(function() {
            pageNum = 1;
            isEmpty = false;
            updateProducts(true);
        });
        
        $('.range').change(function() {
            pageNum = 1;
            isEmpty = false;
            updateProducts(true);
        });
        
        
        function updateProducts(isNewFilter = false) {

            if (isLoading) return;
            isLoading = true;

            if (isNewFilter) {
                $('#productList').empty();
            }

            let cate1 = $('#cate1').val() || "";
            let cate2 = $('#cate2').val() || "";
            let cate3 = $('#cate3').val() || "";
            let filter = $('#filter').val() || "newest";  // 필터 옵션 추가
            let range = $('input[name="range"]:checked').val();
            
            $.ajax({
                url: contextPath + '/filterProducts',
                type: 'GET',
                data: {
                    cate1: cate1,
                    cate2: cate2,
                    cate3: cate3,
                    filter: filter,  // 필터 옵션 전송
                    pageNum: pageNum,
                    listLimit: listLimit,
                    range : range,
                },
                dataType: 'json',
                success: function(data) {
                    if (data.length === 0) {
                        isEmpty = true;
                    } else {
                        $.each(data, function(index, product) {
                            $('#productList').append(
                                '<div class="col-lg-4 col-md-6 col-12">'
                                + '    <div class="single-product">'
                                + '        <div class="product-img">'
                                + '             <form action="productDetail" method="get">'
                                + '               <input type="hidden" name="PD_IDX" value="'+ product.PD_IDX + '">'
                                + '               <a href="#" onclick="this.parentNode.submit(); return false;">'
                                + '               	<img class="default-img" src="' + contextPath + '/resources/upload/' + product.image1 + '">'
                                + '					<div class="'+ product.PD_STATUS_COLOR +'">' +  product.PD_STATUS_VALUE +'</div>'
                                + '               </a>'
                                + '           </form>'
                                + '       </div>'
                                + '       <div class="product-content">'
                                + '           <h3><a href="productDetail?PD_IDX='+ product.PD_IDX +'">'+ product.PD_SUBJECT +'</a></h3>'
                                + '           <div class="product-price">'
                                + '               <span>'+ new Intl.NumberFormat().format(product.PD_PRICE) +'원</span>'
                                + '           </div>'
                                + '       </div>'
                                + '   </div>'
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

        $(window).scroll(function() {
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100 && !isLoading && !isEmpty) {
                updateProducts();
            }
        });

        // 페이지 로드 시 초기 데이터 불러오기
        updateProducts();  
    	
    	/* 최근 본 상품 함수 호출 */
    	showRecentLookProduct();
    	
    	/* 최근 본 상품 */
    	function showRecentLookProduct() {
    		let storedProducts = JSON.parse(localStorage.getItem("products")) || [];
    		storedProducts = storedProducts.join(',');
    		
    		let isNull = false;
    		if (storedProducts.length === 0) {
    			isNull = true;
    		}
    	
    		if (isNull) {
    			let nullDiv = '<div style="margin-top: 50px; font-size:13px; text-align:center; height: 50px; color:#34A853"> 최근 본 상품 목록이 비어 있습니다. </div>';
    			$("#recentProduct").append(nullDiv);
    			return;  // 최근 본 상품이 없을 경우 
    		}
    		
            $.ajax({
                type: "GET",
                url: "recentLookProductList",
                data: {
                    "recentProduct": storedProducts
                },
                dataType: "json",
                success: function(response) {
    				let productList = response;
    				
    				if (productList == '') {
    					let nullDiv = '<div style="margin-top: 50px; font-size:13px; text-align:center; height: 50px;color:#34A853"> 최근 본 상품 목록이 비어 있습니다. </div>';
    					$("#recentProduct").append(nullDiv);
    					return;  // 최근 본 상품이 없을 경우 
    				}
    				
    				$.each(productList, function(index, pr) {
    				
    					let productDetail = 
    							'<div class="single-post first" >'
    						   + ' <div class="image">'
    						   +'	<a href="productDetail?PD_IDX='+ pr.PD_IDX +'">'
                               + '    <img src="' + contextPath + '/resources/upload/' + pr.IMG + '">'
                               + '  </a>'
                               +' </div>'
                               +'     <div class="content">'
                               +'         <h5 style="text-overflow: ellipsis;"><a href="productDetail?PD_IDX='+ pr.PD_IDX +'" >' + pr.PD_SUBJECT +'</a></h5>'
                               +'        <small style="color:black">'+ pr.RD_DATE +'</small>'
                               +'        <p class="price">'+ pr.PD_PRICE +' 원'
                               +' </div>'
                               +' </div>'
                               
                          $("#recentProduct").append(productDetail);
    				});
    				
                }
            });
    	}
    	
//     	// "찜하기" 버튼 클릭 시 AJAX 요청 보내기
//         $(document).on('click', '.add-to-wishlist', function(e) {
//             e.preventDefault();

//             let productId = $(this).data('product-id');

//             $.ajax({
//                 url: contextPath + '/addToWishlist',
//                 type: 'POST',
//                 data: {
//                     productId: productId
//                 },
//                 success: function(response) {
// 					if (response.success) {
//         				alert('찜 목록에 추가되었습니다.');
//     				} else {
//        					alert('로그인 상태가 아닙니다. \n로그인 후 이용해주세요.');
//     				}
// 				},
//                 error: function(xhr, status, error) {
//                     console.error('찜하기 요청 오류:', error);
//                     alert('찜 목록 추가에 실패했습니다.');
//                 }
//             });
//         });

    	
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
                            <li class="active"><a href="blog-single.html">팝니다</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->
    
    <!-- Product Style -->
    <section class="product-area shop-sidebar shop section" style="padding-top:10px">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-4 col-12">
                    <div class="shop-sidebar">
                        <!-- Single Widget -->
                        <div class="single-widget category">
                            <h3 class="title">Categories</h3>
                            <ul class="categor-list">
                                <li>
                                    <select id="cate1" name="cate1" class="form-control" required >
                                        <option value="">대분류</option>
                                        <c:forEach var="cate1" items="${cate1}">
                                            <option value="${cate1.CTG_CODE}">${cate1.CTG_NAME}</option>
                                        </c:forEach>
                                    </select>
                                </li>
                                <li>        
                                    <select id="cate2" name="cate2" class="form-control" required disabled>
                                        <option value="">중분류를 선택하시오</option>
                                    </select>
                                </li>
                                <li>          
                                    <select id="cate3" name="cate3" class="form-control" required disabled>
                                        <option value="">소분류를 선택하시오</option>
                                    </select>
                                </li>
                            </ul>
                        </div>
                        <!--/ End Single Widget -->
                        
                        <!-- Single Widget -->
                        <div class="single-widget recent-post" >
                            <h3 class="title" id="recentProduct" style="text-align:center;"> 👕 최근 본 상품 👕 </h3>
                            <!-- Single Post -->
                            
<!--                                 <div class="image"> -->
<!--                                     <img src="https://via.placeholder.com/75x75" alt="#"> -->
<!--                                 </div> -->
<!--                                 <div class="content"> -->
<!--                                     <h5><a href="#">최근 본 상품</a></h5> -->
<!--                                     <small>8시간 전</small> -->
<!--                                     <p class="price">100억</p> -->
<!--                                 </div> -->
<!--                             </div> -->
                            <!-- End Single Post -->
                        </div>
                        
                        
                    </div>
                </div>
                <div class="col-lg-9 col-md-8 col-12">
                    <div class="row">
                        <div class="col-12">
                            <!-- Shop Top -->
                            <div class="shop-top">
                                <ul class="view-mode">
                                    <li><a href="product"><i>상품등록</i></a></li>
                                </ul>
                            </div>
                            <div class="dd">
                            	 <input type="radio" name="range" class="range" value="0" checked>전체 반경
                            	 <c:if test="${not empty US_ID && US_STATUS != 'US03'}">
	                            	 <input type="radio" name="range" class="range" value="5000">반경5km
	                            	 <input type="radio" name="range" class="range" value="10000">반경10km
                            	 </c:if>
                            	 <ul class="view-mode" >
                                	<li>
	                          			<select id="filter" name="filter" class="form-control">
	                                        <option value="newest" <c:if test="${param.searchType eq 'newest'}"> selected</c:if>> 최신순</option>
											<option value="popular" <c:if test="${param.searchType eq 'popular'}"> selected</c:if>> 인기순</option>
	                                    </select>
                                    </li>          
                                </ul>
                            </div>
                            <!--/ End Shop Top -->
                        </div>
                    </div>
                    
<!--                     <div> -->
<!-- 	                    <div align="center" style="margin-top:40px; margin-bottom:30px;">	 -->
<!-- 				       		<form action="javascript:void(0);" name="fr"> -->
<%-- 								<input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력하여주세요" id="searchKeyword">  --%>
<!-- 								<input type="submit" value="검색" id="submitBtn"/> -->
<!-- 								<select name="searchType" id="searchType"> -->
<%-- 									<option value="brand" <c:if test="${param.searchType eq 'brand'}"> selected</c:if>> 제조사</option> --%>
<%-- 									<option value="model" <c:if test="${param.searchType eq 'model'}"> selected</c:if>> 모델</option> --%>
<!-- 								</select> -->
<!-- 							</form> -->
<!-- 				        </div> -->
<!-- 			        </div> -->
                    <!-- 원본 -->
                    <div class="row" id="productList">
<%--                         <c:forEach var="product" items="${getProduct}"> --%>
<!--                             <div class="col-lg-4 col-md-6 col-12"> -->
<!--                                 <div class="single-product"> -->
<!--                                     <div class="product-img"> -->
<!--                                         <form action="productDetail" method="get"> -->
<%--                                             <input type="hidden" name="PD_IDX" value="${product.PD_IDX}"> --%>
<!--                                             <a href="#" onclick="this.parentNode.submit(); return false;"> -->
<%--                                                 <img class="default-img" src="<%= request.getContextPath() %>/resources/upload/${product.image1}"> --%>
<!--                                             </a> -->
<!--                                         </form> -->
<!--                                         <div class="button-head"> -->
<!--                                             <div class="product-action"> -->
<!--                                                 <a title="Wishlist" href="#"><i class="ti-heart"></i><span>찜하기</span></a> -->
<!--                                             </div> -->
<!--                                             <div class="product-action-2"> -->
<!--                                                 <a title="Add to cart" href="#"></a> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                     <div class="product-content"> -->
<%--                                         <h3><a href="product-details.html">${product.PD_SUBJECT}</a></h3> --%>
<!--                                         <div class="product-price"> -->
<%--                                             <span>${product.PD_PRICE}</span> --%>
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                             </div> -->
<%--                         </c:forEach> --%>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--/ End Product Style 1  -->    
<!-- 	<div class="col-lg-1 col-12 d-flex align-items-end"> -->
<!-- 		 <div class="chatbot"> -->
<%-- 	        <a href="chatbot" onclick="window.open(this.href, '_blank', 'width=500, height=700, left=1600, top=200, resizable=no'); return false;"><img src="${pageContext.request.contextPath}/resources/images/chatbot2.PNG" id="chatImg" alt=""></a> --%>
<!-- 	    </div> -->
<!-- 		        <div class="col-md-5 col-lg-4 order-md-last" id="paymentSide" style="background-color: gray"> -->
        
<!-- 		        </div> -->
    </div>
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="ti-close" aria-hidden="true"></span></button>
                </div>
                <div class="modal-body">
                    <div class="row no-gutters">
                        <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                            <!-- Product Slider -->
                            <div class="product-gallery">
                                <div class="quickview-slider-active">
                                    <div class="single-slider">
                                        <img src="https://via.placeholder.com/569x528" alt="#">
                                    </div>
                                    <div class="single-slider">
                                        <img src="https://via.placeholder.com/569x528" alt="#">
                                    </div>
                                    <div class="single-slider">
                                        <img src="https://via.placeholder.com/569x528" alt="#">
                                    </div>
                                    <div class="single-slider">
                                        <img src="https://via.placeholder.com/569x528" alt="#">
                                    </div>
                                </div>
                            </div>
                            <!-- End Product slider -->
                        </div>
                        <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                            <div class="quickview-content">
                                <h2>Flared Shift Dress</h2>
                                <div class="quickview-ratting-review">
                                    <div class="quickview-ratting-wrap">
                                        <div class="quickview-ratting">
                                            <i class="yellow fa fa-star"></i>
                                            <i class="yellow fa fa-star"></i>
                                            <i class="yellow fa fa-star"></i>
                                            <i class="yellow fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                        <a href="#"> (1 customer review)</a>
                                    </div>
                                    <div class="quickview-stock">
                                        <span><i class="fa fa-check-circle-o"></i> in stock</span>
                                    </div>
                                </div>
                                <h3>$29.00</h3>
                                <div class="quickview-peragraph">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia iste laborum ad impedit pariatur esse optio tempora sint ullam autem deleniti nam in quos qui nemo ipsum numquam.</p>
                                </div>
                                <div class="size">
                                    <div class="row">
                                        <div class="col-lg-6 col-12">
                                            <h5 class="title">Size</h5>
                                            <select>
                                                <option selected="selected">s</option>
                                                <option>m</option>
                                                <option>l</option>
                                                <option>xl</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-6 col-12">
                                            <h5 class="title">Color</h5>
                                            <select>
                                                <option selected="selected">orange</option>
                                                <option>purple</option>
                                                <option>black</option>
                                                <option>pink</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="quantity">
                                    <!-- Input Order -->
                                    <div class="input-group">
                                        <div class="button minus">
                                            <button type="button" class="btn btn-primary btn-number" disabled="disabled" data-type="minus" data-field="quant[1]">
                                                <i class="ti-minus"></i>
                                            </button>
                                        </div>
                                        <input type="text" name="quant[1]" class="input-number"  data-min="1" data-max="1000" value="1">
                                        <div class="button plus">
                                            <button type="button" class="btn btn-primary btn-number" data-type="plus" data-field="quant[1]">
                                                <i class="ti-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <!--/ End Input Order -->
                                </div>
                                <div class="add-to-cart">
                                    <a href="#" class="btn">Add to cart</a>
                                    <a href="#" class="btn min"><i class="ti-heart"></i></a>
                                    <a href="#" class="btn min"><i class="fa fa-compress"></i></a>
                                </div>
                                <div class="default-social">
                                    <h4 class="share-now">Share:</h4>
                                    <ul>
                                        <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></li>
                                        <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></li>
                                        <li><a class="youtube" href="#"><i class="fa fa-pinterest-p"></i></li>
                                        <li><a class="dribbble" href="#"><i class="fa fa-google-plus"></i></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

   
    <footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>

	<!-- 최근 본 상품 js --> 
<%--     <script src="${pageContext.request.contextPath}/resources/js/trade/tradeRecentProduct.js"></script> --%>
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
