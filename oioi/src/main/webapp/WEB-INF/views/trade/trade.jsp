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

        function updateProducts(isNewFilter = false) {
            if (isLoading) return;
            isLoading = true;

            if (isNewFilter) {
                $('#productList').empty();
            }

            let cate1 = $('#cate1').val() || "";
            let cate2 = $('#cate2').val() || "";
            let cate3 = $('#cate3').val() || "";

            $.ajax({
                url: contextPath + '/filterProducts',
                type: 'GET',
                data: {
                    cate1: cate1,
                    cate2: cate2,
                    cate3: cate3,
                    pageNum: pageNum,
                    listLimit: listLimit
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
                                + '                   <img class="default-img" src="' + contextPath + '/resources/upload/' + product.image1 + '">'
                                + '               </a>'
                                + '           </form>'
                                + '           <div class="button-head">'
                                + '           <div class="product-action">'
                                + '               <a title="Wishlist" href="#"><i class="ti-heart"></i><span>찜하기</span></a>'
                                + '           </div>'
                                + '           <div class="product-action-2">'
                                + '               <a title="Add to cart" href="#"></a>'
                                + '           </div>'
                                + '       </div>'
                                + '       </div>'
                                + '       <div class="product-content">'
                                + '           <h3><a href="product-details.html">'+ product.PD_SUBJECT +'</a></h3>'
                                + '           <div class="product-price">'
                                + '               <span>'+ product.PD_PRICE +'</span>'
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
                        <div class="single-widget recent-post">
                            <h3 class="title">최근 본 상품</h3>
                            <!-- Single Post -->
                            <div class="single-post first">
                                <div class="image">
                                    <img src="https://via.placeholder.com/75x75" alt="#">
                                </div>
                                <div class="content">
                                    <h5><a href="#">최근 본 상품</a></h5>
                                    <p class="price">100억</p>
                                    <ul class="reviews">
                                        <li class="yellow"><i class="ti-star"></i></li>
                                        <li class="yellow"><i class="ti-star"></i></li>
                                        <li class="yellow"><i class="ti-star"></i></li>
                                        <li><i class="ti-star"></i></li>
                                        <li><i class="ti-star"></i></li>
                                    </ul>
                                </div>
                            </div>
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
                            <!--/ End Shop Top -->
                        </div>
                    </div>
                    	<!-- 최신순, 조회순 틀 -->
<!--                     <div align="right" style="margin-top:40px; margin-bottom:30px;">	 -->
<!-- 			       		<form action="javascript:void(0);" name="fr"> -->
<!-- 							<select name="searchType" id="searchType"> -->
<%-- 								<option value="brand" <c:if test="${param.searchType eq 'brand'}"> selected</c:if>> 제조사</option> --%>
<%-- 								<option value="model" <c:if test="${param.searchType eq 'model'}"> selected</c:if>> 모델</option> --%>
<!-- 							</select> -->
<%-- 							<input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="검색어를 입력하여주세요" id="searchKeyword">  --%>
<!-- 							<input type="submit" value="검색" id="submitBtn"/> -->
<!-- 						</form> -->
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
    <!-- Modal end -->
    
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
</html>
